//
//  YXBReusableView.h
//  YunXiaoZhi
//
//  Created by YangXiaoBin on 2019/11/1.
//  Copyright © 2019 YangXiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QMUIKit/QMUIButton.h>

@class YXBHeaderView;

NS_ASSUME_NONNULL_BEGIN

@protocol YXBHeaderDelegate <NSObject>

- (void)reusableView:(YXBHeaderView *)reusableView tapLeftButton:(UIButton *)button;

- (void)reusableView:(YXBHeaderView *)reusableView tapRightButton:(UIButton *)button;

@end


@interface YXBHeaderView : UICollectionReusableView

@property (nonatomic, weak) id<YXBHeaderDelegate> delegate;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) QMUIButton *leftButton;
@property (nonatomic, strong) QMUIButton *rightButton;
@property (nonatomic, strong) UIImageView *imageView;

@end

NS_ASSUME_NONNULL_END
