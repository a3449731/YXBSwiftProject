//
//  ProgressPlugin.swift
//  MyNetWork
//
//  Created by 杨晓斌 on 2023/7/20.
//

import UIKit
import Moya

// MARK: 为了使用Moya自带的菊花插件，进行的调整
struct ProgressPlugin {
    func cteatProgressPlugin() -> NetworkActivityPlugin  {
        NetworkActivityPlugin { change, target in
            
            DispatchQueue.main.async {
                switch change {
                case .began:
                    NetworkActivityIndicator.shared.incrementActivityCount()
                case .ended:
                    NetworkActivityIndicator.shared.decrementActivityCount()
                }
            }
        }
    }
}

//extension NetworkActivityPlugin {
//
//    static func cteatProgressPlugin() -> NetworkActivityPlugin  {
//        NetworkActivityPlugin { change, target in
//
//            DispatchQueue.main.async {
//                switch change {
//                case .began:
//                    NetworkActivityIndicator.shared.incrementActivityCount()
//                case .ended:
//                    NetworkActivityIndicator.shared.decrementActivityCount()
//                }
//            }
//        }
//    }
//}


// 网络菊花，自动展示在window上
class NetworkActivityIndicator: UIView {

    static let shared = NetworkActivityIndicator()

    private var activityCount = 0 {
        didSet {
            DispatchQueue.main.async {
                if self.activityCount <= 0 {
                    self.hide()
                } else {
                    self.show()
                }
            }
        }
    }
    
    // 菊花
    private let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.color = .white
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicatorView
    }()

    private override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        // 修改的背景色
        backgroundColor = UIColor.gray.withAlphaComponent(0.4)

        addSubview(activityIndicatorView)
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    private func show() {
        guard !isDescendant(of: UIApplication.shared.keyWindow ?? UIView()) else { return }

        frame = UIApplication.shared.keyWindow?.bounds ?? UIScreen.main.bounds
        activityIndicatorView.startAnimating()
        UIApplication.shared.keyWindow?.addSubview(self)
    }

    private func hide() {
        activityIndicatorView.stopAnimating()
        removeFromSuperview()
    }

    func incrementActivityCount() {
        activityCount += 1
    }

    func decrementActivityCount() {
        activityCount -= 1
    }
}
