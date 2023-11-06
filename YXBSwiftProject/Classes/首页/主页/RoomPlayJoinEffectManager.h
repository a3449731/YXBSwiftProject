//
//  RoomPlayJoinEffectManager.h
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/10/31.
//  Copyright © 2023 ShengChang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YXBSwiftProject-Swift.h"

@protocol RoomPlayJoinEffectManagerDelegate <NSObject>

@optional
- (void)playVap:(PlayVapView *)view didStart:(UIView *)container url:(NSString *)urlString;
- (void)playVap:(PlayVapView *)view didStop:(UIView *)container url:(NSString *)urlString;
- (void)playVap:(PlayVapView *)view didFail:(NSError *)error url:(NSString *)urlString;

@end

@interface RoomPlayJoinEffectManager : NSObject

@property (nonatomic, strong) NSMutableArray *animationArray;
@property (nonatomic, assign) BOOL isPlayingAnimation;
@property (nonatomic, assign) BOOL isPaused;

@property (nonatomic, weak) id<RoomPlayJoinEffectManagerDelegate> delegate;

@property (nonatomic, strong) PlayVapView *playView;

// 传入需要条件到的view上。view自己在外面布局，默认充满
- (instancetype)initWithSuperView:(UIView *)view;

- (void)addAnimations:(NSArray *)dicArray;
- (void)addAnimation:(NSDictionary *)dic;
// 移除某个动画。
- (void)removeAnimation:(NSDictionary *)dic;
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
