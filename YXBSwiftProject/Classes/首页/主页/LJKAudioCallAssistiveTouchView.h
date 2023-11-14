//
//  LJKAudioCallAssistiveTouchView.h
//  CUYuYinFang
//
//  Created by 芦 on 2023/8/3.
//  Copyright © 2023 lixinkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LJKAudioCallAssistiveTouchViewDelegate <NSObject>

@optional

- (void)assistiveTouchViewClicked;
- (void)closeClicked;

@end

@interface LJKAudioCallAssistiveTouchView : UIView

- (instancetype)initDefaultType;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *nameLabel;
+ (UIWindow *)getCurrentWindow;

@property (weak, nonatomic) id<LJKAudioCallAssistiveTouchViewDelegate> delegate;

@end
