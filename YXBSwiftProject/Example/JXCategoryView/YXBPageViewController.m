//
//  YXBPageViewController.m
//  NIM
//
//  Created by YangXiaoBin on 2020/5/30.
//  Copyright © 2020 Netease. All rights reserved.
//

#import "YXBPageViewController.h"
#import <JXCategoryView/JXCategoryView.h>
#import "YXBPageContentViewController.h"
#import "YXBPageContentTableViewController.h"
#import "YXBPageContentCollectionViewController.h"

@interface YXBPageViewController () <JXCategoryListContainerViewDelegate,JXCategoryViewDelegate>

@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;

@end

@implementation YXBPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self setupTool];
    [self setupData];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.categoryView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 50);
    self.listContainerView.frame = CGRectMake(0, 50, self.view.bounds.size.width, self.view.bounds.size.height - 200);
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    //    self.listContainerView.initListPercent = 0.5;
    [self.view addSubview:self.listContainerView];
    
    //    self.titles = [self getRandomTitles];
    self.categoryView = [[JXCategoryTitleView alloc] init];
    //优化关联listContainer，以后后续比如defaultSelectedIndex等属性，才能同步给listContainer
    self.categoryView.listContainer = self.listContainerView;
    self.categoryView.delegate = self;
    self.categoryView.titles = [self titlesArray];
    self.categoryView.defaultSelectedIndex = 0;
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    self.categoryView.indicators = @[lineView];
    [self.view addSubview:self.categoryView];
}

- (void)setupTool {
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
}

- (void)setupData {
    
}

/**
 重载数据源：比如从服务器获取新的数据、否则用户对分类进行了排序等
 */
- (void)reloadData {
    //重载之后默认回到0，你也可以指定一个index
    self.categoryView.defaultSelectedIndex = 1;
    self.categoryView.titles = [self titlesArray];
    [self.categoryView reloadData];
}

- (NSArray *)titlesArray {
    return @[@"collectionViewController",@"viewController",@"tableViewController"];
}

#pragma mark - JXCategoryListContainerViewDelegate

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    if (index == 0) {
        return [YXBPageContentCollectionViewController new];
    } else if (index == 1) {
        return [YXBPageContentViewController new];
    } else {
        return [YXBPageContentTableViewController new];
    }
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return 3;
}

#pragma mark - JXCategoryViewDelegate ---------------------

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    //侧滑手势处理
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}

@end
