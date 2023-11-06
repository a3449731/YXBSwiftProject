//
//  PlayEffectsView.swift
//  CUYuYinFang
//
//  Created by 蓝鳍互娱 on 2023/10/21.
//  Copyright © 2023 lixinkeji. All rights reserved.
//

import Foundation
import SDWebImage
import SVGAPlayer

@objc protocol PlayEffectsViewDelegate: NSObjectProtocol {
    func effects(startAnimation: PlayEffectsView)
    func effects(stopAnimation: PlayEffectsView)
}

/// 对播放特效的封装
class PlayEffectsView : UIView {
    /// 播放gif的view
    var gifPlayerView = UIImageView()
    
    /// 播放svga的view
    var svgaPlayerView = SVGAPlayer()
    
    /// 播放MP4, 使用的是腾讯VAP
    var mp4PlayerView: PlayMP4View = PlayMP4View()
    
    /// 播放vap特效
    var vapPlayerView: PlayVapView = PlayVapView()
    
    weak var delegate: PlayEffectsViewDelegate?
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.creatNotification()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func stopAnimating() {
        self.mp4PlayerView.stopMP4()
        self.vapPlayerView.stopVap()
        self.svgaPlayerView.stopAnimation()
        self.gifPlayerView.image = nil
        
        self.vapPlayerView.removeFromSuperview()
        self.mp4PlayerView.removeFromSuperview()
        self.svgaPlayerView.removeFromSuperview()
        self.gifPlayerView.removeFromSuperview()
        
    }
    
    public func playUrl(_ url : String, nickName: String? = nil) {
        let headerUrl = URL.init(string: url)!
        
        if headerUrl.pathExtension == "gif" || headerUrl.pathExtension == "webp" {
            do {
                self.addSubview(self.gifPlayerView)
                self.gifPlayerView.snp.remakeConstraints { make in
                    make.edges.equalToSuperview()
                }
                self.gifPlayerView.sd_setImage(with: headerUrl)
                
            } catch{}
            
            
        } else if headerUrl.pathExtension == "svga" {
            self.addSubview(self.svgaPlayerView)
            
            self.svgaPlayerView.snp.remakeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            let queue = DispatchQueue(label: "svgaParser", qos: .default, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)
            queue.async {
                SVGAParser().parse(with: headerUrl) { videoItem in
                    self.svgaPlayerView.videoItem = videoItem
                    self.svgaPlayerView.startAnimation()
                } failureBlock: { error in
                    
                }
            }
        }  else if headerUrl.pathExtension == "mp4" {
            if nickName == nil {
                self.addSubview(self.mp4PlayerView)
                
                self.mp4PlayerView.snp.remakeConstraints { make in
                    make.edges.equalToSuperview()
                }
                
                self.mp4PlayerView.startMP4(urlString: url)
            } else {
                self.addSubview(self.vapPlayerView)
                
                self.vapPlayerView.snp.remakeConstraints { make in
                    make.edges.equalToSuperview()
                }
                
                self.vapPlayerView.startVap(urlString: url, userInfo: ["nickname": "", "headImg": ""])
            }
            
        } else {
            debugPrint("🚀 头像框的这种格式未解析，",headerUrl.pathExtension)
        }
    }

    deinit {
        self.removeNotication()
        debugPrint(self.className + " deinit 🍺")
    }
}


private extension PlayEffectsView {
    private func creatNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(mp4DidStartNotification), name: Notification.Name("MP4DidStart_Notification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(mp4DidStopNotification), name: Notification.Name("MP4DidStop_Notification"), object: nil)
    }
    
    @objc private func mp4DidStartNotification() {
        self.delegate?.effects(startAnimation: self)
    }
    
    @objc private func mp4DidStopNotification() {
        self.delegate?.effects(stopAnimation: self)
    }
    
    private func removeNotication() {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("MP4DidStart_Notification"), object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name("MP4DidStop_Notification"), object: nil)
    }
}

//extension PlayEffectsView: SVGAPlayerDelegate {
//    func svgaPlayerDidFinishedAnimation(_ player: SVGAPlayer!) {
//        self.delegate?.effects(stopAnimation: self)
//    }
//}
