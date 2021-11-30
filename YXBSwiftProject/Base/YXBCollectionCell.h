//
//  YXBCollectionCell.h
//  YunXiaoZhi
//
//  Created by YangXiaoBin on 2019/11/1.
//  Copyright © 2019 YangXiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXBCollectionCell : UICollectionViewCell

/// 可重置layout,决定滑动方向等 [self.collectionView setCollectionViewLayout:layout];
@property (nonatomic, strong) UICollectionView *collectionView;

@end

NS_ASSUME_NONNULL_END
