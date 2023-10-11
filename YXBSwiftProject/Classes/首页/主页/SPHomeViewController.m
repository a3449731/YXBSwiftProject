//
//  SPHomeViewController.m
//  YXBSwiftProject
//
//  Created by YangXiaoBin on 2020/6/18.
//  Copyright © 2020 ShengChang. All rights reserved.
//

#import "SPHomeViewController.h"
#import "YXBSwiftProject-Swift.h"

@interface SPHomeViewController ()

@end

@implementation SPHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
}

- (void)setupTool {

}

- (void)setupData {
    
    NSLog(@"\n kSafeAreaTopMargin =%f,\n kSafeAreaBottomMargin = %f,\n kNavigationBarHeight = %f ,\n kStatusBarHeight = %f ,\n kTabbarHeight = %f,\n kStatusBarAndNavigationBarHeight = %f",kSafeAreaTopMargin,kSafeAreaBottomMargin,kNavigationBarHeight,kStatusBarHeight,kTabbarHeight,kStatusBarAndNavigationBarHeight);
}

- (void)butonAction:(UIButton *)button {
    LQWithdrawVC *vc = [[LQWithdrawVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];    
//    [YXBThemeManager sharedInstance].currentThemeIdentifier = YXBThemeIndetifierDark;
}

- (void)whiteAction:(UIButton *)button {
    MSSystemNoticeVC *vc = [[MSSystemNoticeVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
//    [YXBThemeManager sharedInstance].currentThemeIdentifier = YXBThemeIndetifierWhite;
}

@end
