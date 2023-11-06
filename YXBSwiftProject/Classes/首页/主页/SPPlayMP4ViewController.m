//
//  SPPlayMP4ViewController.m
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/10/24.
//  Copyright © 2023 ShengChang. All rights reserved.
//

#import "SPPlayMP4ViewController.h"
#import "YXBSwiftProject-Swift.h"
#import "RoomPlayMP4Manager.h"
#import "RoomPlayJoinEffectManager.h"
#import <PYPhotoBrowser/PYPhotoBrowser.h>



@interface SPPlayMP4ViewController ()

@property (nonatomic, strong) RoomPlayJoinEffectManager *joinPlayer;

//@property (nonatomic, strong) PlayVapView *joinPlayer;

//@property (nonatomic, strong) PlayMP4View *mp4Player;

@end

@implementation SPPlayMP4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    [button setTitle:@"播放" forState:(UIControlStateNormal)];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(50);
    }];
    [button addTarget:self action:@selector(playAction:) forControlEvents:(UIControlEventTouchUpInside)];
//
//    NSString *urlString = @"https://lanqi123.oss-cn-beijing.aliyuncs.com/lanqi/file/1697599934577.webp";
//    NSURL *imgUrl = [NSURL URLWithString:urlString];
////    [_imageView sd_setImageWithURL:imgUrl];
//    UIImageView *imageView = [[UIImageView alloc] init];
//    [imageView sd_setImageWithURL:imgUrl];
//    [self.view addSubview:imageView];
//    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(200);
//        make.width.height.mas_equalTo(100);
//        make.centerX.mas_equalTo(0);
//    }];
    
    self.joinPlayer = [[RoomPlayJoinEffectManager alloc] initWithSuperView:self.view];
    
    NSArray *array = @[@{
      @"passAction" : @"https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1698288781473.mp4",
      @"nickname" : @"",
      @"headImg" : @""
    },@{
        @"passAction" : @"https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1698288863069.mp4",
        @"nickname" : @"",
        @"headImg" : @""
    }];
    [self.joinPlayer addAnimations:array];
    
    
    
    
//    self.joinPlayer = [[PlayVapView alloc] init];
//    self.joinPlayer.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:self.joinPlayer];
//    [self.joinPlayer mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(0);
//        make.top.mas_equalTo(100);
//        make.width.mas_equalTo(200);
//        make.height.mas_equalTo(200);
//
////        make.edges.mas_equalTo(0);
//    }];
    
//    self.mp4Player = [[PlayMP4View alloc] init];
//    self.mp4Player.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:self.mp4Player];
//    [self.mp4Player mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(0);
//        make.bottom.mas_equalTo(0);
//        make.width.mas_equalTo(200);
//        make.height.mas_equalTo(200);
//    }];
    
    
//    [self.joinPlayer startVapWithUrlString:@"https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1698042378272.mp4" nickName:@"你爸爸"];
    
//    [self.joinPlayer startVapWithUrlString:@"https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1698288863069.mp4" userInfo:@{@"":@"", @"":@""}];
    
//    [self.joinPlayer startVapWithUrlString:@"https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1698288863069.mp4" nickName:@"座驾2"];
    
//    [self.mp4Player startMP4WithUrlString:@"https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1698288863069.mp4"];
    
//    [self.joinPlayer startVapWithUrlString:@"https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1697789199554.mp4" nickName:@"打工兔兔"];

//    [self.joinPlayer startVapWithUrlString:@"https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1698128757190.mp4" nickName:@"入场特效"];
}

- (void)playAction:(UIButton *)button {
//    /Users/lanqihuyu/Desktop/YXBSwiftProject/YXBSwiftProject/Classes/首页/主页/video.mp4
    // 座驾
    // https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1698042378272.mp4
    
    // 座驾2
    // https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1697693633395.mp4
    
    // https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1697693633395.mp4
    
    // 入场特效
    // https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1698128757190.mp4

    // 打工兔兔
    // https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1697789199554.mp4
    
    // 万圣节特效
    // https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1698288863069.mp4
    
    // webp头像
    // https://lanqi123.oss-cn-beijing.aliyuncs.com/lanqi/file/1697599934577.webp
    
//    [self.joinPlayer startMP4WithUrlString:@"https://lanqi123.oss-cn-beijing.aliyuncs.com/file/1698128757190.mp4"];
    
    [self.view makeToast:@"响应了button"];
    
//    [self.joinPlayer playAnimations];
    
    
    [LQPhotoBroswer showWithUrlArray:@[@"https://lanqi123.oss-cn-beijing.aliyuncs.com/file/14423_fd56a01b47f949f5bcb1690d62f4aa8e_ios_1698758120.gif"] currentIndex:0];
    
//    // 1. 创建photoBroseView对象
//    PYPhotoBrowseView *photoBroseView = [[PYPhotoBrowseView alloc] init];
//    // 2.1 设置图片源(UIImageView)数组
//    photoBroseView.imagesURL = @[@"https://lanqi123.oss-cn-beijing.aliyuncs.com/file/14423_fd56a01b47f949f5bcb1690d62f4aa8e_ios_1698758120.gif"];
//    // 2.2 设置初始化图片下标（即当前点击第几张图片）
//    photoBroseView.currentIndex = 0;
//    // 3.显示(浏览)
//    [photoBroseView show];
}


#pragma mark ---- RoomPlayJoinEffectManagerDelegate
//- (void)playVap:(PlayVapView *)view didStop:(UIView *)container url:(NSString *)urlString {
//    NSLog(@"动画%@结束触发", urlString);
//    [self.joinPlayer next];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    NSLog(@"SPPlayMP4ViewController,释放了");
}

@end
