//
//  SPHomeViewController.m
//  YXBSwiftProject
//
//  Created by YangXiaoBin on 2020/6/18.
//  Copyright © 2020 ShengChang. All rights reserved.
//

#import "SPHomeViewController.h"
#import "YXBSwiftProject-Swift.h"
#import "MBProgressHUD+NH.h"
#import "SPHornalCollectionViewController.h"
#import "SPPlayMP4ViewController.h"
#import "MaskAnimationViewController.h"
#import "LQCircleMaskAnimation.h"

@interface SPHomeViewController () <UINavigationControllerDelegate>

@end

@implementation SPHomeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navigationController.delegate = self;
    
    [self setupUI];
    [self setupTool];
    [self setupData];
}

- (void)setupUI {
    UIColor *color = [YXBThemeManager sharedInstance].backgroundColor;
    self.view.backgroundColor = color;
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setTitle:@"暗黑模式" forState:(UIControlStateNormal)];
    //    UIColor *buttonColor = [YXBThemeManager sharedInstance].titleTextColor;
    [button setTitleColor:[YXBThemeManager sharedInstance].titleTextColor forState:(UIControlStateNormal)];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(100);
        make.top.mas_equalTo(200);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(50);
    }];
    [button addTarget:self action:@selector(butonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *whiteButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [whiteButton setTitle:@"白色模式" forState:(UIControlStateNormal)];
    //    UIColor *bwhiteButtonColor = [YXBThemeManager sharedInstance].backgroundColor;
    [whiteButton setTitleColor: [YXBThemeManager sharedInstance].titleTextColor forState:(UIControlStateNormal)];
    [self.view addSubview:whiteButton];
    [whiteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(200);
        make.top.mas_equalTo(200);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(50);
    }];
    [whiteButton addTarget:self action:@selector(whiteAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    UIButton *playButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [playButton setTitle:@"礼物特效" forState:(UIControlStateNormal)];
    //    UIColor *bwhiteButtonColor = [YXBThemeManager sharedInstance].backgroundColor;
    [playButton setTitleColor: [YXBThemeManager sharedInstance].titleTextColor forState:(UIControlStateNormal)];
    [self.view addSubview:playButton];
    [playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(200);
        make.top.mas_equalTo(300);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(50);
    }];
    [playButton addTarget:self action:@selector(playAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    UIButton *dressButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [dressButton setTitle:@"装扮中心" forState:(UIControlStateNormal)];
    [dressButton setTitleColor: [YXBThemeManager sharedInstance].titleTextColor forState:(UIControlStateNormal)];
    [self.view addSubview:dressButton];
    [dressButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(100);
        make.top.mas_equalTo(300);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(50);
    }];
    [dressButton addTarget:self action:@selector(dressAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    UIButton *messageButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [messageButton setTitle:@"发消息" forState:(UIControlStateNormal)];
    [messageButton setTitleColor: [YXBThemeManager sharedInstance].titleTextColor forState:(UIControlStateNormal)];
    [self.view addSubview:messageButton];
    [messageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(100);
        make.top.mas_equalTo(400);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(50);
    }];
    [messageButton addTarget:self action:@selector(messageAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    UIButton *maskButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [maskButton setTitle:@"mask动画" forState:(UIControlStateNormal)];
    [maskButton setTitleColor: [YXBThemeManager sharedInstance].titleTextColor forState:(UIControlStateNormal)];
    [self.view addSubview:maskButton];
    [maskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(200);
        make.top.mas_equalTo(400);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(50);
    }];
    [maskButton addTarget:self action:@selector(maskAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"loading" withExtension:@"gif"];
//    UIImage *image = [UIImage imageNamed:@"loading.gif"];
//    imageView.image = image;
    [imageView sd_setImageWithURL:url];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(100);
        make.top.mas_equalTo(300);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
    }];
    
    [MBProgressHUD showGifToView:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideGifHUD];
    });
}

- (void)setupTool {

}

- (void)setupData {
    
    NSLog(@"\n kSafeAreaTopMargin =%f,\n kSafeAreaBottomMargin = %f,\n kNavigationBarHeight = %f ,\n kStatusBarHeight = %f ,\n kTabbarHeight = %f,\n kStatusBarAndNavigationBarHeight = %f",kSafeAreaTopMargin,kSafeAreaBottomMargin,kNavigationBarHeight,kStatusBarHeight,kTabbarHeight,kStatusBarAndNavigationBarHeight);
}

- (void)butonAction:(UIButton *)button {
    HonourRankSegmentVC *vc = [[HonourRankSegmentVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];    
//    [YXBThemeManager sharedInstance].currentThemeIdentifier = YXBThemeIndetifierDark;
}

- (void)whiteAction:(UIButton *)button {
    MSSystemNoticeVC *vc = [[MSSystemNoticeVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
//    [YXBThemeManager sharedInstance].currentThemeIdentifier = YXBThemeIndetifierWhite;
}

- (void)playAction:(UIButton *)button {
    SPPlayMP4ViewController *vc = [[SPPlayMP4ViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
//    [YXBThemeManager sharedInstance].currentThemeIdentifier = YXBThemeIndetifierWhite;
}

- (void)dressAction:(UIButton *)button {
    MSDressSegmentVC *vc = [[MSDressSegmentVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)messageAction:(UIButton *)button {
    MessageViewController *vc = [[MessageViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)maskAction:(UIButton *)button {
    MaskAnimationViewController *vc = [MaskAnimationViewController sharedManager];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

//RoomMessageTableView

#pragma mark ---- UINavigationControllerDelegate ----
// 转场动画
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if ([toVC isEqual:[MaskAnimationViewController sharedManager]] && operation == UINavigationControllerOperationPush) {
        return [[LQCircleMaskAnimation alloc]init];
    } else {
        return nil;
    }
}

@end
