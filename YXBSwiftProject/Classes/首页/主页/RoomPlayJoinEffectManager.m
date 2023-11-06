//
//  RoomPlayJoinEffectManager.m
//  CUYuYinFang
//
//  Created by 蓝鳍互娱 on 2023/10/25.
//  Copyright © 2023 lixinkeji. All rights reserved.
//

#import "RoomPlayJoinEffectManager.h"

@interface RoomPlayJoinEffectManager () <PlayVapViewViewDelegate>

@property (nonatomic, strong) NSLock *lock;


// 记录正在播放的是哪个url，播完好移除
@property (nonatomic, strong) NSDictionary *isPlayingDic;

@end

@implementation RoomPlayJoinEffectManager

// 传入需要条件到的view上。view自己在外面布局，默认充满
- (instancetype)initWithSuperView:(UIView *)view {
    self = [super init];
    if (self) {
        _animationArray = [NSMutableArray array];
        _lock = [[NSLock alloc] init];
        _isPlayingAnimation = NO;
        _isPaused = NO;
        
        _playView = [[PlayVapView alloc] init];
        _playView.backgroundColor = [UIColor clearColor];
        _playView.delegate = self;
        _playView.hidden = YES;
        [view addSubview:_playView];
        [_playView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return self;
}

- (void)addAnimation:(NSDictionary *)dic {
    [self.lock lock];
    [self.animationArray addObject:dic];
    [self.lock unlock];
}

- (void)addAnimations:(NSArray *)dicArray {
    [self.lock lock];
    [self.animationArray addObjectsFromArray:dicArray];
    [self.lock unlock];
}

- (void)removeAnimation:(NSDictionary *)dic {
    if ([dic isEqualToDictionary:self.isPlayingDic]) {
        [self stopCurrentAnimation];
    } else {
        [self.lock lock];
        NSInteger index = [self.animationArray indexOfObject:dic];
        if (index >= 0 && index < self.animationArray.count) {
            NSLog(@"YXB_LOG: 移除指定动画,%ld",index);
            [self.animationArray removeObjectAtIndex:index];
        }
        [self.lock unlock];
    }
}

// 结束当前动画，正常情况应该不用调用这个。会继续播放下一个动画
- (void)stopCurrentAnimation {
    [self.lock lock];
    NSInteger index = [self.animationArray indexOfObject:self.isPlayingDic];
    if (index >= 0 && index < self.animationArray.count) {
        NSLog(@"YXB_LOG: 停止当前动画,%ld",index);
        [self.animationArray removeObjectAtIndex:index];
    }
    // 还是别调用了，是个坑，让他自己结束就好。
//    [self.playView stopVap];
    [self.lock unlock];
}

- (void)playAnimations {
    // 标记了 是否正在播放， 是否暂停的状态。
    if (self.animationArray.count == 0 || self.isPlayingAnimation || self.isPaused) {
        NSLog(@"YXB_LOG: 现在正在一个特殊的状态, 排队等播出, %@, 播放状态:%d, 暂停状态:%d", self.animationArray, self.isPlayingAnimation, self.isPaused);
        return;
    }
    // 记录当前
    self.isPlayingAnimation = YES;
    NSDictionary *dic = self.animationArray[0];
    self.isPlayingDic = dic;
    [self.playView startVapWithUrlString:dic[@"passAction"] userInfo:dic];
}

// 暂停
- (void)pause {
    self.isPaused = YES;
}

// 恢复
- (void)resume {
    if (self.isPaused) {
        self.isPaused = NO;
        [self playAnimations];
    }
}

// 播放下一个
- (void)next {
    NSLog(@"YXB_LOG: 播放下一个动画, 注意啊，在连播时候一定要给个延迟调用");
    // 连播不得不延迟，不然无法连播，VAP内部会错误提示cuz window is nil!。 大概是播放完成后被自动移除了，开始播放后又要重新添加，需要一个时差。
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self playAnimations];
    });
}

// 立即停止动画，并且清空数组
- (void)stopAndClear {
    [self.lock lock];
    [self.playView stopVap];
    [self.animationArray removeAllObjects];
    [self.lock unlock];
}

# pragma mark ---- PlayMP4ViewViewDelegate
- (void)effectsWithStartAnimation:(PlayVapView *)startAnimation container:(UIView *)container {
    self.playView.hidden = NO;
    
    // 默认实现，如果外界实现了代理，就不会走这个了
    if ([self.delegate respondsToSelector:@selector(playVap:didStart:url:)]) {
        [self.delegate playVap:startAnimation didStart:container url:self.isPlayingDic[@"headerUrl"]];
        return;
    }
    
}

- (void)effectsWithStopAnimation:(PlayVapView *)stopAnimation container:(UIView *)container {
    self.playView.hidden = YES;
    [self removeAnimation:self.isPlayingDic];
    self.isPlayingAnimation = NO;
    self.isPlayingDic = nil;
    
    // 默认实现，如果外界实现了代理，就不会走这个了
    if ([self.delegate respondsToSelector:@selector(playVap:didStop:url:)]) {
        [self.delegate playVap:stopAnimation didStop:container url:self.isPlayingDic[@"headerUrl"]];
        return;
    }
    
    [self next];
}

// 如果失败了就扔掉，继续下一个
- (void)effectsWithDidFail:(PlayVapView *)didFail error:(NSError *)error {
    self.playView.hidden = YES;
    [self removeAnimation:self.isPlayingDic];
    self.isPlayingAnimation = NO;
    self.isPlayingDic = nil;

    
    // 默认实现，如果外界实现了代理，就不会走这个了
    if ([self.delegate respondsToSelector:@selector(playVap:didFail:url:)]) {
        [self.delegate playVap:didFail didFail:error url:self.isPlayingDic[@"headerUrl"]];
        return;
    }
    
    [self next];
}

@end
