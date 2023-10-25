//
//  PlayEffectsViewController.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/10/12.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import UIKit
import QGVAPlayer
import RxSwift
import RxCocoa

@objc class PlayEffectsViewController: UIViewController {
    let disposed = DisposeBag()
    
    let effectView: PlayEffectsView = {
        let view = PlayEffectsView()
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(effectView)
        effectView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
 
//    https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1697693598040.mp4
//    https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1698039495056.mp4
//    https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1698042378272.mp4
        
        
        let btn = MyUIFactory.commonButton(title: "点我方", titleColor: .titleColor_black, titleFont: .titleFont_14, image: nil)
        view.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        btn.rx.tap.subscribe(onNext: { [weak self] in
            
            self?.effectView.playUrl("https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1698042378272.mp4")
            
        })
        .disposed(by: disposed)
    }
    
    
            
}
