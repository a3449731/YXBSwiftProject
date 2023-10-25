//
//  PlayMP4View.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/10/23.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import UIKit
import QGVAPlayer
import Tiercel

@objc protocol PlayMP4ViewViewDelegate: NSObjectProtocol {
    func effects(startAnimation: PlayMP4View, container: UIView)
    func effects(stopAnimation: PlayMP4View, container: UIView)
    
    @objc optional func effects(didFinishAnimation: PlayMP4View, container: UIView)
    @objc optional func effects(didFail: PlayMP4View, error: Error)
}

@objcMembers class PlayMP4View: UIView {
    
    let mananger = SessionManager("downLoadMP4", configuration: SessionConfiguration())
    
    @objc weak var delegate: PlayMP4ViewViewDelegate?
    
    // 播放MP4特效的空间
    lazy var vapView: UIView = {
        let vapView = UIView.init(frame: .zero)
//        vapView.center = self.center
        // 退出后台停止
        vapView.hwd_enterBackgroundOP = HWDMP4EBOperationType.stop
        vapView.enableOldVersion(true)
        // 关闭交互，为了能穿透，响应到下层事件
        vapView.isUserInteractionEnabled = false
        
        // 这个是QGVAPWrapView才支持的
//        vapView.contentMode = .aspectFit

        // 这个好像是静音
        vapView.setMute(true)
        return vapView
    }()
    
    // 渲染模式， 右侧透明通道
    let blendMode: QGHWDTextureBlendMode = .alphaRight
    let repeatCount = 2
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .backgroundColor_white
        // 关闭交互，为了能穿透，响应到下层事件
        self.isUserInteractionEnabled = false
        
        self.creatUI()
        
//        self.isUserInteractionEnabled = false
//        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
//        vapView.addGestureRecognizer(tap)
    }
    
    private func creatUI() {
        self.addSubview(vapView)
        vapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
//    @objc private func tapAction(_ gesture: UITapGestureRecognizer) {
//        let location = gesture.location(in: self)
//        if vapView.frame.contains(location) {
//            self.stopMP4()
//        }
//    }
    
    /// VAP只能做本地播放，所以一定是下载好的资源路径
    @objc func startMP4(urlString: String) {
        let task = self.mananger.download(urlString)
        
        task?.progress(onMainQueue: true) { (task) in
            let progress = task.progress.fractionCompleted
            debugPrint("下载中, 进度：\(progress)")
        }.success { [weak self] (task) in
            guard let self = self else { return }
            debugPrint("文件路径:", task.filePath)
            // 这是用的废弃的方法，因为要指定了blendMode模式，才能适配蓝鱼语音的MP4特效
            self.vapView.playHWDMP4(task.filePath, blendMode: self.blendMode, repeatCount: self.repeatCount, delegate: self)
            
        }.failure { (task) in
            debugPrint("下载失败")
        }
    }
    
    /// 停止播放
    @objc func stopMP4() {
        vapView.stopHWDMP4()
    }
    
//    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        return self
//    }
    
    // 可以清理渲染layer的。
    @objc func clear() {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        debugPrint(self.className + " deinit 🍺")
    }
}


// MARK: -- 这是使用UIView就可以展示的特效 融合特效的接口 vapx
extension PlayMP4View: HWDMP4PlayDelegate {
    
    // 当特效中留的有注入位置的tag标时候，可以通过类似下面的内容展示进去
    func content(forVapTag tag: String!, resource info: QGVAPSourceInfo!) -> String! {
        /*
        let extraInfo: [String: String] = ["[sImg1]" : "http://shp.qlogo.cn/pghead/Q3auHgzwzM6GuU0Y6q6sKHzq3MjY1aGibIzR4xrJc1VY/60",
                                           "[textAnchor]" : "我是主播名",
                                           "[textUser]" : "我是用户名😂😂",]
        return extraInfo[tag] ?? ""
        */
        return tag
    }

    // 由于组件内不包含网络图片加载的模块，因此需要外部支持图片加载。
    func loadVapImage(withURL urlStr: String!, context: [AnyHashable : Any]!, completion completionBlock: VAPImageCompletionBlock!) {
        /*
        //call completionBlock as you get the image, both sync or asyn are ok.
        //usually we'd like to make a net request
        DispatchQueue.main.async {
            let image = UIImage(named: "ZS_login_logo")
            completionBlock(image, nil, urlStr)
        }
        */
        debugPrint("loadVapImageWithURLloadVapImageWithURL:", urlStr);
    }
    
    // 控制限制隐藏主要是动画玩成后，会定在最后一帧。
    func viewDidStartPlayMP4(_ container: UIView!) {
        DispatchQueue.main.async {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.isHidden = false
                NotificationCenter.default.post(name: NSNotification.Name("MP4DidStart_Notification"), object: nil)
            self.delegate?.effects(startAnimation: self, container: container)
//            }
        }
    }
    
    func viewDidStopPlayMP4(_ lastFrameIndex: Int, view container: UIView!) {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: NSNotification.Name("MP4DidStop_Notification"), object: nil)
            self.isHidden = true
            self.delegate?.effects(stopAnimation: self, container: container)
        }
    }
    
    func viewDidFinishPlayMP4(_ totalFrameCount: Int, view container: UIView!) {
        DispatchQueue.main.async {
            self.delegate?.effects?(didFinishAnimation: self, container: container)
        }
    }
    
    func viewDidFailPlayMP4(_ error: Error!) {
        DispatchQueue.main.async {
            self.delegate?.effects?(didFail: self, error: error)
        }
    }
}


// MARK: 这是使用QGVAPWrapView展示的另一种特效，VAPWrapViewDelegate
/*
extension PlayMP4View: VAPWrapViewDelegate {
    
    // 当特效中留的有注入位置的tag标时候，可以通过类似下面的内容展示进去
    func vapWrapview_content(forVapTag tag: String, resource info: QGVAPSourceInfo) -> String {
        /*
        let extraInfo: [String: String] = ["[sImg1]" : "http://shp.qlogo.cn/pghead/Q3auHgzwzM6GuU0Y6q6sKHzq3MjY1aGibIzR4xrJc1VY/60",
                                           "[textAnchor]" : "我是主播名",
                                           "[textUser]" : "我是用户名😂😂",]
        return extraInfo[tag] ?? ""
        */
        return tag
    }
    
    // 由于组件内不包含网络图片加载的模块，因此需要外部支持图片加载。
    func vapWrapView_loadVapImage(withURL urlStr: String, context: [AnyHashable : Any], completion completionBlock: @escaping VAPImageCompletionBlock) {
        /*
        //call completionBlock as you get the image, both sync or asyn are ok.
        //usually we'd like to make a net request
        DispatchQueue.main.async {
            let image = UIImage(named: "ZS_login_logo")
            completionBlock(image, nil, urlStr)
        }
        */
    }
}
*/
