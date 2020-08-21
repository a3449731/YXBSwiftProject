//
//  YXBNavigationController.m
//  MyProject
//
//  Created by YangXiaoBin on 2019/12/18.
//  Copyright © 2019 YangXiaoBin. All rights reserved.
//

#import "YXBNavigationController.h"

@interface YXBNavigationController ()

@end

@implementation YXBNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        self.navigationBar.translucent = NO;
        self.navigationBar.tintColor = YXBColor_titleText;
        self.navigationBar.backgroundColor = [UIColor clearColor];
        [self.navigationBar setBackgroundImage:UIImageWithColor(YXBColor_background) forBarMetrics:(UIBarMetricsDefault)];
        [self.navigationBar setShadowImage:[UIImage new]];
        NSDictionary *att = @{NSForegroundColorAttributeName : YXBColor_titleText,
        NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:17]};
        [self.navigationBar setTitleTextAttributes:att];
    }
    return self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    } else {
        viewController.hidesBottomBarWhenPushed = NO;
    }
    [super pushViewController:viewController animated:animated];
}

@end
