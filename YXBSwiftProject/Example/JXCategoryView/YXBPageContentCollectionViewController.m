//
//  YXBPageContentCollectionViewController.m
//  NIM
//
//  Created by YangXiaoBin on 2020/5/30.
//  Copyright © 2020 Netease. All rights reserved.
//

#import "YXBPageContentCollectionViewController.h"
#import <IGListKit/IGListKit.h>
#import <MJRefresh.h>
#import <Masonry.h>
//#import "MyTeamSection.h"
//#import "FriendsAPI.h"
#import "NSArray+IGListDiffable.h"

@interface YXBPageContentCollectionViewController () <IGListAdapterDataSource, JXPagerViewListViewDelegate, UIScrollViewDelegate>

@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);

@property (nonatomic, strong) IGListAdapter *adapter;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *modelArray;
@property (nonatomic, copy) NSString *currentPage;

@end

@implementation YXBPageContentCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self setupTool];
    [self setupData];
}

- (void)setupUI {
    [self creatCollectionView];
}

- (void)setupTool {
    [self creatAdapter];
    [self creatMJ_header];
    [self creatMJ_footer];
}

- (void)setupData {
    self.currentPage = @"1";
    self.modelArray = [NSMutableArray array];
    [self reqeustOnePage];
}

#pragma mark ----------- MJRefresh -----------------------
- (void)creatMJ_header {
    MJWeakSelf;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf reqeustOnePage];
    }];
    self.collectionView.mj_header = header;
}

- (void)creatMJ_footer {
    MJWeakSelf;
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf reqeustMoreData];
    }];
    self.collectionView.mj_footer = footer;
}

#pragma mark ---------- 请求数据 -----------
- (void)reqeustOnePage {
//    MJWeakSelf;
//    self.currentPage = @"1";
//    FriendsAPI *network = [[FriendsAPI alloc] initWithPage:self.currentPage limit:@"20"];
//    [network startWithCompletionBlockWithSuccess:^(__kindof FriendsAPI * _Nonnull request) {
//        weakSelf.modelArray = [[request jsonForModel] mutableCopy];
//        [weakSelf.adapter reloadDataWithCompletion:nil];
//        [weakSelf.collectionView.mj_header endRefreshing];
//        [weakSelf.collectionView.mj_footer endRefreshing];
//    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//        [weakSelf.collectionView.mj_header endRefreshing];
//        [weakSelf.collectionView.mj_footer endRefreshing];
//    }];
}

- (void)reqeustMoreData {
//    MJWeakSelf;
//    self.currentPage = [NSString stringWithFormat:@"%ld",[self.currentPage integerValue] + 1];
//    FriendsAPI *network = [[FriendsAPI alloc] initWithPage:self.currentPage limit:@"20"];
//    [network startWithCompletionBlockWithSuccess:^(__kindof FriendsAPI * _Nonnull request) {
//        NSArray *array = [request jsonForModel];
//        [weakSelf.modelArray addObjectsFromArray:array];
//        [weakSelf.adapter reloadDataWithCompletion:nil];
//        [weakSelf.collectionView.mj_header endRefreshing];
//        [weakSelf.collectionView.mj_footer endRefreshing];
//    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//        [weakSelf.collectionView.mj_header endRefreshing];
//        [weakSelf.collectionView.mj_footer endRefreshing];
//    }];
}


#pragma mark ---------------- collectionView --------------------
- (void)creatCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    // contentofset 会偏移的情况
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

#pragma mark ------------- IGList ------------------
- (void)creatAdapter {
    IGListAdapterUpdater *updater = [[IGListAdapterUpdater alloc] init];
    self.adapter = [[IGListAdapter alloc] initWithUpdater:updater viewController:self];
    self.adapter.dataSource = self;
    self.adapter.scrollViewDelegate = self;
    self.adapter.collectionView = self.collectionView;
}

- (NSArray<id <IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {
    if (self.modelArray) {
        return @[self.modelArray];
    }
    return nil;
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
    return [IGListSectionController new];
}

- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
    return nil;
}

#pragma mark ----------------- JXPagerViewListViewDelegate ---------------------
// 返回列表视图
// 如果列表是VC，就返回VC.view
// 如果列表是View，就返回View自己
- (UIView *)listView {
    return self.view;
}

/**
 返回listView内部持有的UIScrollView或UITableView或UICollectionView
 主要用于mainTableView已经显示了header，listView的contentOffset需要重置时，内部需要访问到外部传入进来的listView内的scrollView

 @return listView内部持有的UIScrollView或UITableView或UICollectionView
 */
- (UIScrollView *)listScrollView {
    return self.collectionView;
}

/**
 当listView内部持有的UIScrollView或UITableView或UICollectionView的代理方法`scrollViewDidScroll`回调时，需要调用该代理方法传入的callback

 @param callback `scrollViewDidScroll`回调时调用的callback
 */
- (void)listViewDidScrollCallback:(void (^)(UIScrollView *scrollView))callback {
    self.scrollCallback = callback;
}

#pragma mark ---------- UIScrollViewDelegate ----------------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.scrollCallback) {
        self.scrollCallback(scrollView);
    }
}

@end
