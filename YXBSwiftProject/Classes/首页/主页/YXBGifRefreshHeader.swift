//
//  YXBGifRefreshHeader.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/10/14.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import MJRefresh

@objc class YXBGifRefreshHeader: MJRefreshGifHeader {
    override func prepare() {
        super.prepare()
        
        // 处理gif图
        guard let gifURL = Bundle.main.url(forResource: "refeshIcon", withExtension: "gif"),
              let gifData = try? Data(contentsOf: gifURL),
              let gifImage = UIImage.sd_image(withGIFData: gifData) else {
            return
        }
        var imagesArray = [UIImage]()
        imagesArray.append(gifImage)
        
        // 常规状态下做一个封面图
        let image = UIImage(named: "refeshIconCover")!
        self.setImages([image], duration: 3, for: .idle)
//        gifHeader?.setImages(imagesArray, duration: 3, for: .pulling)
        self.setImages(imagesArray, duration: 3, for: .refreshing)
        self.stateLabel.isHidden = true
        self.lastUpdatedTimeLabel.isHidden = true
        
        // Set the height of the refresh header
        self.mj_h = 80
    }
}

