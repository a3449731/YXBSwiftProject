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
                
//                let hud = MBProgressHUD.showAdded(to: UIApplication.shared.currentUIWindow()!, animated: true)
//                // 创建UIImageView来显示自定义的GIF图
//                let gifImageView = UIImageView(frame: CGRect(x: 50, y: 50, width: 100, height: 100))
//                let url = Bundle.main.url(forResource: "loading", withExtension: "gif")
////                gifImageView.image = UIImage(named: "loading")
//                gifImageView.sd_setImage(with: url)
//                hud.customView = gifImageView
//                // 设置模式为自定义视图
//                hud.mode = .customView
//                // 隐藏时是否从父视图移除
//                hud.removeFromSuperViewOnHide = true
////                // 隐藏MBProgressHUD
////                hud.hide(animated: true, afterDelay: 3.0)
                
                switch change {
                case .began:
                    MBProgressHUD.showGif(to: UIApplication.shared.currentUIWindow())
                case .ended:
                    MBProgressHUD.hideGifHUD(for: UIApplication.shared.currentUIWindow())
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
