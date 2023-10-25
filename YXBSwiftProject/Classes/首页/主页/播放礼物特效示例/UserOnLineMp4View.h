//
//  UserOnLineMp4View.h
//  YinPai
//
//  Created by Windy on 2022/5/6.
//  Copyright © 2022 wb. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface UserOnLineMp4View : UIView
//播放等级升级特效
- (void)mp4ShowMp4Animation:(NSString *)urlString;
- (void)resumeMP4;
@end

NS_ASSUME_NONNULL_END
