//
//  AnimationQueue.h
//  CUYuYinFang
//
//  Created by 蓝鳍互娱 on 2023/10/24.
//  Copyright © 2023 lixinkeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "蓝鱼语音-Swift.h"

@protocol RoomPlayMP4ManagerDelegate <NSObject>

@optional
- (void)playMP4:(PlayMP4View *)view didStart:(UIView *)container url:(NSString *)urlString;
- (void)playMP4:(PlayMP4View *)view didStop:(UIView *)container url:(NSString *)urlString;
- (void)playMP4:(PlayMP4View *)view didFail:(NSError *)error url:(NSString *)urlString;

@end

@interface RoomPlayMP4Manager : NSObject

@property (nonatomic, strong) NSMutableArray *animationArray;
@property (nonatomic, assign) BOOL isPlayingAnimation;
@property (nonatomic, assign) BOOL isPaused;

@property (nonatomic, weak) id<RoomPlayMP4ManagerDelegate> delegate;

@property (nonatomic, strong) PlayMP4View *giftPlayView;

// 传入需要条件到的view上。view自己在外面布局，默认充满
- (instancetype)initWithSuperView:(UIView *)view;

- (void)addAnimations:(NSArray *)urlStringArray;
- (void)addAnimation:(NSString *)urlString;
// 移除某个动画。
- (void)removeAnimation:(NSString *)urlString;
- (void)playAnimations;

// 播放下一个
- (void)next;

// 结束当前动画，正常情况应该不用调用这个。会继续播放下一个动画
- (void)stopCurrentAnimation;
// 立即停止动画，并且情况数组
- (void)stopAndClear;

// 暂停队列和恢复队列,暂停不会立即结束当前动画，会等待当前动画播放完成
- (void)pause;
- (void)resume;

@end

