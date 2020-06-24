//
//  YXBBaseViewController.m
//  NIM
//
//  Created by YangXiaoBin on 2020/5/27.
//  Copyright © 2020 Netease. All rights reserved.
//

#import "YXBBaseViewController.h"

@interface YXBBaseViewController ()

@end

@implementation YXBBaseViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = YXBColorBG_Black;
}

@end
