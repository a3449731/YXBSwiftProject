//
//  UserOnLineMp4View.m
//  YinPai
//
//  Created by Windy on 2022/5/6.
//  Copyright © 2022 wb. All rights reserved.
//

#import "UserOnLineMp4View.h"
#import <QGVAPWrapView.h>
//#import "UserOnLineMp4Manager.h"
@interface UserOnLineMp4View()<HWDMP4PlayDelegate>
@property (nonatomic, strong) VAPView *userOnLinemp4View;//用户上线特效
//@property (nonatomic, strong) UserOnLineMp4Manager *userOnLineMp4Manager;//用户上线特效管理
@end
@implementation UserOnLineMp4View
-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self bulidVapMp4];
//        [self bulidVapManager];
    }
    return self;
}
- (void)bulidVapMp4{
    if (!_userOnLinemp4View) {
        _userOnLinemp4View = [[VAPView alloc] initWithFrame:self.bounds];
        _userOnLinemp4View.center = self.center;
        _userOnLinemp4View.contentMode = UIViewContentModeScaleAspectFit;
//        _userOnLinemp4View.testFont = @"20";
        _userOnLinemp4View.hwd_enterBackgroundOP = HWDMP4EBOperationTypePauseAndResume;
        [_userOnLinemp4View enableOldVersion:YES];
        [self addSubview:_userOnLinemp4View];
//        [_userOnLinemp4View mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(self);
//        }];
    }
}
//- (void)bulidVapManager{
//    if (!_userOnLineMp4Manager) {
//        _userOnLineMp4Manager = [[UserOnLineMp4Manager alloc]init];
//        _userOnLineMp4Manager.delegate = self;
//    }
//}
//- (void)addMp4Animation:(ChatMsgTopUserOnLineModel*)userOnLineMsgMdl{
//    [_userOnLineMp4Manager addMp4Animation:userOnLineMsgMdl];
//}
- (void)resumeMP4{
    self.userOnLinemp4View.hidden = YES;
//    self.userOnLineMp4Manager.isShowUserOnLineMp4Animation = NO;
//    [self.userOnLineMp4Manager playMp4Animation];
}
#pragma mark - MP4AnimationManagerDelegate
- (void)mp4ShowMp4Animation:(NSString *)urlString {
    MJWeakSelf
    dispatch_async(dispatch_get_main_queue(), ^{
//        weakSelf.userOnLineMp4Manager.isShowUserOnLineMp4Animation = YES;
        weakSelf.userOnLinemp4View.hidden = NO;
        //播放mp4特效
        if (urlString.length) {
            [weakSelf.userOnLinemp4View playHWDMP4:urlString repeatCount:0 delegate:self];
        }
    });
}
//播放流程MP4
- (void)viewDidFinishPlayMP4:(NSInteger)totalFrameCount view:(UIView *)container {
//    //note:在子线程被调用
    MJWeakSelf
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.userOnLinemp4View.hidden = YES;
//        weakSelf.userOnLineMp4Manager.isShowUserOnLineMp4Animation = NO;
//        [weakSelf.userOnLineMp4Manager playMp4Animation];
    });
    NSLog(@"MP4 FinishPlay");
}
- (void)viewDidStopPlayMP4:(NSInteger)lastFrameIndex view:(UIView *)container {
    NSLog(@"MP4 StopPlay");
}
- (void)viewDidFailPlayMP4:(NSError *)error {
    MJWeakSelf
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.userOnLinemp4View.hidden = YES;
//        weakSelf.userOnLineMp4Manager.isShowUserOnLineMp4Animation = NO;
//        [weakSelf.userOnLineMp4Manager playMp4Animation];
    });
    NSLog(@"MP4 FailPlay：%ld", (long)error.code);
}
//mp4Key
- (NSString *)contentForVapTag:(NSString *)tag resource:(QGVAPSourceInfo *)info {
    NSString *title = @"";
//    if ([tag isEqualToString:@"tag1"]) {
//        title = _userOnLineMsgMdl.avatar;
//    }else if([tag isEqualToString:@"tag2"]){
//        NSString *suffix = @"";
//        if (_userOnLineMsgMdl.name_suffix.length) {
//            suffix = [NSString stringWithFormat:@"「%@」",_userOnLineMsgMdl.name_suffix];
//        }
//        title = [NSString stringWithFormat:@"%@%@ 上线啦！",suffix,_userOnLineMsgMdl.user_nickname];
//
//    }
    return title;
}

//provide image for url from tag content
- (void)loadVapImageWithURL:(NSString *)urlStr context:(NSDictionary *)context completion:(VAPImageCompletionBlock)completionBlock {
//    ALLog(@"loadVapImageWithURLloadVapImageWithURL");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *image = [self getImageFromURL:urlStr];
        //返回主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(image, nil, urlStr);
        });
    });
}
-(UIImage *) getImageFromURL:(NSString *)fileURL{
    UIImage * result;
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    return result;
}
@end
