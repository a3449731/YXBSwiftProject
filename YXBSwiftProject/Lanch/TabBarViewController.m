//
//  MainTabBarController.m
//  CYLTabBarController
//
//  Created by YangXiaoBin on 2019/11/11.
//  Copyright © 2019 YangXiaoBin. All rights reserved.
//
#import "TabBarViewController.h"
#import <UIKit/UIKit.h>
#import "YXBNavigationController.h"
#import "SPHomeViewController.h"

@interface TabBarViewController ()<UITabBarControllerDelegate>

@property (nonatomic, strong) NSMutableArray *vcArray;
@property (nonatomic, strong) NSMutableArray *configArray;

@end

@implementation TabBarViewController

- (instancetype)init {
    self = [self configData];
    if (self) {
        self.delegate = self;
        [UITabBar appearance].translucent = NO;
        self.navigationController.navigationBar.hidden = YES;
        self.tabBar.unselectedItemTintColor = YXBColorGray;
        self.tabBar.tintColor = YXBColorBlack;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    [self becomeFirstResponder];
}

- (instancetype)configData {
    self.vcArray = [NSMutableArray array];
    self.configArray = [NSMutableArray array];
    [self configFirstVC];
    [self configFirstVC];
    [self configFirstVC];
    [self configFirstVC];
    UIEdgeInsets imageInsets = UIEdgeInsetsZero;//UIEdgeInsetsMake(4.5, 0, -4.5, 0);
    UIOffset titlePositionAdjustment = UIOffsetMake(0, -3.5);
    return [super initWithViewControllers:self.vcArray tabBarItemsAttributes:self.configArray imageInsets:imageInsets titlePositionAdjustment:titlePositionAdjustment];    
}

- (void)configFirstVC {
    UIViewController *vc = [[SPHomeViewController alloc] init];
    UINavigationController *nav = [[YXBNavigationController alloc]
                             initWithRootViewController:vc];
    CGFloat firstXOffset = -12/2;
    NSDictionary *firstTabBarItemsAttributes = @{
        CYLTabBarItemTitle : @"首页",
        CYLTabBarItemImage : @"home_normal",  /* NSString and UIImage are supported*/
        CYLTabBarItemSelectedImage : @"home_highlight",  /* NSString and UIImage are supported*/
        CYLTabBarItemTitlePositionAdjustment: [NSValue valueWithUIOffset:UIOffsetMake(firstXOffset, -3.5)],
//        CYLTabBarItemTitlePositionAdjustment: [NSValue valueWithUIOffset:UIOffsetMake(-firstXOffset, -3.5)],
//        CYLTabBarLottieURL: [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"tab_me_animate" ofType:@"json"]],
//        CYLTabBarLottieSize: [NSValue valueWithCGSize:CGSizeMake(22, 22)]
    };
    //    [nav cyl_setHideNavigationBarSeparator:YES];
    [self.vcArray addObject:nav];
    [self.configArray addObject:firstTabBarItemsAttributes];
}

@end
