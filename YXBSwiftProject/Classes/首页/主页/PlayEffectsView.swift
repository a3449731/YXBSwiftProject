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

/// 对播放特效的封装
class PlayEffectsView : UIView {
    /// 播放gif的view
    var gifPlayerView = UIImageView()
    
    /// 播放svga的view
    var svgaPlayerView = SVGAPlayer()
    
    public func stopAnimating() {
        self.svgaPlayerView.stopAnimation()
        self.gifPlayerView.image = nil
        
        self.svgaPlayerView.removeFromSuperview()
        self.gifPlayerView.removeFromSuperview()
        
    }
    
    public func playUrl(_ url : String) {
        let headerUrl = URL.init(string: url)!
        
        if headerUrl.pathExtension == "gif" {
            do {
                self.addSubview(self.gifPlayerView)
                self.gifPlayerView.snp.makeConstraints { make in
                    make.edges.equalToSuperview()
                }
                self.gifPlayerView.sd_setImage(with: headerUrl)
                
            } catch{}
            
            
        } else if headerUrl.pathExtension == "svga" {
            self.addSubview(self.svgaPlayerView)
            
            self.svgaPlayerView.snp.makeConstraints { make in
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
        } else {
            debugPrint("🚀 头像框的这种格式未解析，",headerUrl.pathExtension)
        }

    }

}
