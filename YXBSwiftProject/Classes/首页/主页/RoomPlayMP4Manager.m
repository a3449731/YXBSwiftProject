//
//  AnimationQueue.m
//  CUYuYinFang
//
//  Created by 蓝鳍互娱 on 2023/10/24.
//  Copyright © 2023 lixinkeji. All rights reserved.
//

#import "RoomPlayMP4Manager.h"

@interface RoomPlayMP4Manager () <PlayMP4ViewViewDelegate>

@property (nonatomic, strong) NSLock *lock;


// 记录正在播放的是哪个url，播完好移除
@property (nonatomic, copy) NSString *isPlayingUrl;

@end

@implementation RoomPlayMP4Manager

// 传入需要条件到的view上。view自己在外面布局，默认充满
- (instancetype)initWithSuperView:(UIView *)view {
    self = [super init];
    if (self) {
        _animationArray = [NSMutableArray array];
        _lock = [[NSLock alloc] init];
        _isPlayingAnimation = NO;
        _isPaused = NO;
        
        _giftPlayView = [[PlayMP4View alloc] init];
        _giftPlayView.backgroundColor = [UIColor clearColor];
        _giftPlayView.delegate = self;
        _giftPlayView.hidden = YES;
        [view addSubview:_giftPlayView];
        [_giftPlayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return self;
}

- (void)addAnimation:(NSString *)urlString {
    [self.lock lock];
    [self.animationArray addObject:urlString];
    [self.lock unlock];
}

- (void)addAnimations:(NSArray *)urlStringArray {
    [self.lock lock];
    [self.animationArray addObjectsFromArray:urlStringArray];
    [self.lock unlock];
}

- (void)removeAnimation:(NSString *)urlString {
    if ([urlString isEqualToString:self.isPlayingUrl]) {
        [self stopCurrentAnimation];
    } else {
        [self.lock lock];
        NSInteger index = [self.animationArray indexOfObject:urlString];
        if (index >= 0 && index < self.animationArray.count) {
            [self.animationArray removeObjectAtIndex:index];
        }
        [self.lock unlock];
    }
}

- (void)playAnimations {
    // 标记了 是否正在播放， 是否暂停的状态。
    if (self.animationArray.count == 0 || self.isPlayingAnimation || self.isPaused) {
        return;
    }
    // 记录当前
    self.isPlayingAnimation = YES;
    NSString *urlString = self.animationArray[0];
    self.isPlayingUrl = urlString;
        
    [self.giftPlayView startMP4WithUrlString:urlString];
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
    if (self.isPlayingUrl != nil) {
        [self removeAnimation:self.isPlayingUrl];
    }
    self.isPlayingAnimation = NO;
    self.isPlayingUrl = nil;
    [self playAnimations];
}

// 结束当前动画，正常情况应该不用调用这个。会继续播放下一个动画
- (void)stopCurrentAnimation {
    [self.lock lock];
    NSInteger index = [self.animationArray indexOfObject:self.isPlayingUrl];
    if (index >= 0 && index < self.animationArray.count) {
        [self.animationArray removeObjectAtIndex:index];
    }
    [self.giftPlayView stopMP4];
    [self.lock unlock];
}

// 立即停止动画，并且清空数组
- (void)stopAndClear {
    [self.lock lock];
    [self.giftPlayView stopMP4];
    [self.animationArray removeAllObjects];
    [self.lock unlock];
}

# pragma mark ---- PlayMP4ViewViewDelegate
- (void)effectsWithStartAnimation:(PlayMP4View *)startAnimation container:(UIView *)container {
    self.giftPlayView.hidden = NO;
    
    // 默认实现，如果外界实现了代理，就不会走这个了
    if ([self.delegate respondsToSelector:@selector(playMP4:didStart:url:)]) {
        [self.delegate playMP4:startAnimation didStart:container url:self.isPlayingUrl];
        return;
    }
    
}

- (void)effectsWithStopAnimation:(PlayMP4View *)stopAnimation container:(UIView *)container {
    self.giftPlayView.hidden = YES;
    
    // 默认实现，如果外界实现了代理，就不会走这个了
    if ([self.delegate respondsToSelector:@selector(playMP4:didStop:url:)]) {
        [self.delegate playMP4:stopAnimation didStop:container url:self.isPlayingUrl];
        return;
    }
    
    [self next];
}

// 如果失败了就扔掉，继续下一个
- (void)effectsWithDidFail:(PlayMP4View *)didFail error:(NSError *)error {
    self.giftPlayView.hidden = YES;
    
    // 默认实现，如果外界实现了代理，就不会走这个了
    if ([self.delegate respondsToSelector:@selector(playMP4:didFail:url:)]) {
        [self.delegate playMP4:didFail didFail:error url:self.isPlayingUrl];
        return;
    }
    
    [self next];
}

@end
