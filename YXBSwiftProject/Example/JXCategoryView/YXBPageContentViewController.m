//
//  YXBPageContentViewController.m
//  NIM
//
//  Created by YangXiaoBin on 2020/5/30.
//  Copyright © 2020 Netease. All rights reserved.
//

#import "YXBPageContentViewController.h"

@interface YXBPageContentViewController ()

@end

@implementation YXBPageContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark ------------- JXCategoryListContentViewDelegate ------------------
/**
 如果列表是VC，就返回VC.view
 如果列表是View，就返回View自己

 @return 返回列表视图
 */
- (UIView *)listView {
    return self.view;
}

- (UIScrollView *)listScrollView {
    return nil;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    
}

@end
