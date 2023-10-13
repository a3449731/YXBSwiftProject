//
//  PlayEffectsViewController.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/10/12.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import UIKit
import QGVAPlayer

@objc class PlayEffectsViewController: UIViewController, HWDMP4PlayDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        DispatchQueue.global().async() {
////            let image = ImageCache.getImage(with: URL(string: iconImg)!)
//            let image = ImageCache.getImage(with: URL(string: "https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1694153898529.png")!)
//            // 回到主线程使用
//            DispatchQueue.main.async {
//                debugPrint("回到主线程", image)
//            }
//        }
        
        YXBImageCache.getResourcePath(urlString: "https://lanqi123.oss-cn-beijing.aliyuncs.com/mp4/%E9%A3%9E%E4%B9%A620231012-105005.mp4") { url, path in
            if let path = path {
                let localPath = YXBImageCache.getResourceLocalPath(for: url)
                debugPrint("缓存",path)
                debugPrint("本地",localPath)
                self.playVapx(path: localPath!)
                
            }
        }
        
//        ImageCache.getImageLocalPath(urlString: "https://lanqi123.oss-cn-beijing.aliyuncs.com/mp4/%E9%A3%9E%E4%B9%A620231012-105005.mp4") { urlString, path in
//            if let path = path {
//                self.playVapx(path: path)
//            }
//        }
        
        
//        let image = ImageCache.getImage(with: URL(string: "https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1694153898529.png")!)
//        debugPrint("本流程")
        
                
    }
    
    @objc func playVapx(path: String) {
        let vapView = UIView.init(frame: CGRectMake(0, 0, 752/2, 752/2))
//        VAPView *mp4View = [[VAPView alloc] initWithFrame:CGRectMake(0, 0, 752/2, 752/2)];
//        let mp4Path = String.init(format: "%@/Resource/vap.mp4", Bundle.main.resourcePath!)
        self.view.addSubview(vapView)
        vapView.center = self.view.center
        vapView.isUserInteractionEnabled = true
        vapView.hwd_enterBackgroundOP = HWDMP4EBOperationType.stop
        vapView.enableOldVersion(true)
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(onTap(gesture:)))
        vapView.addGestureRecognizer(gesture)
        vapView.playHWDMP4(path, repeatCount: -1, delegate: self)
    }
    
    @objc func onTap(gesture: UIGestureRecognizer) {
        gesture.view?.stopHWDMP4()
        gesture.view?.removeFromSuperview()
    }
    
//  #pragma mark -- 融合特效的接口 vapx
//    func content(forVapTag tag: String!, resource info: QGVAPSourceInfo) -> String {
//        let extraInfo: [String:String] = ["[sImg1]" : "http://shp.qlogo.cn/pghead/Q3auHgzwzM6GuU0Y6q6sKHzq3MjY1aGibIzR4xrJc1VY/60",
//                                          "[textAnchor]" : "我是主播名",
//                                          "[textUser]" : "我是用户名😂😂",]
//
//        return extraInfo[tag] ?? ""
//    }
//
//    func loadVapImage(withURL urlStr: String!, context: [AnyHashable : Any]!, completion completionBlock: VAPImageCompletionBlock!) {
//        DispatchQueue.main.async {
//            let image = UIImage.init(named: String.init(format:"%@/Resource/qq.png", Bundle.main.resourcePath!))
//            completionBlock(image, nil, urlStr)
//        }
//    }
    
}
