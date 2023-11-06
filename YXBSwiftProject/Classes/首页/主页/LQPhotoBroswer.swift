//
//  LQPhotoBroswer.swift
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/11/1.
//  Copyright © 2023 ShengChang. All rights reserved.
//

import UIKit
import JXPhotoBrowser
import SDWebImage

@objc class LQPhotoBroswer: NSObject {
    @objc static func show(urlArray: [String], currentIndex: Int) {
        let browser = JXPhotoBrowser()
        browser.numberOfItems = {
            urlArray.count
        }
        browser.reloadCellAtIndex = { context in
            let url = URL(string: urlArray[context.index])
            let browserCell = context.cell as? JXPhotoBrowserImageCell
            browserCell?.index = context.index
//            let collectionPath = IndexPath(item: context.index, section: indexPath.section)
//            let collectionCell = collectionView.cellForItem(at: collectionPath) as? BaseCollectionViewCell
//            let placeholder = collectionCell?.imageView.image
            // 用 SDWebImage 加载
            browserCell?.imageView.sd_setImage(with: url, placeholderImage: nil)
        }
//        browser.transitionAnimator = JXPhotoBrowserZoomAnimator(previousView: { index -> UIView? in
//            let path = IndexPath(item: index, section: indexPath.section)
//            let cell = collectionView.cellForItem(at: path) as? BaseCollectionViewCell
//            return cell?.imageView
//        })
        browser.pageIndex = 0
        browser.show()
    }
    
    
}
