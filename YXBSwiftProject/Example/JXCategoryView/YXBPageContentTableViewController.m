//
//  YXBPageContentTableViewController.m
//  NIM
//
//  Created by YangXiaoBin on 2020/5/30.
//  Copyright © 2020 Netease. All rights reserved.
//

#import "YXBPageContentTableViewController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface YXBPageContentTableViewController () <UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate, JXPagerViewListViewDelegate>

@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *modelArray;
@property (nonatomic, copy) NSString *currentPage;

@end

@implementation YXBPageContentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self setupTool];
    [self setupData];
}

- (void)setupUI {
    [self creatTableView];
}

- (void)setupTool {
    [self creatMJ_header];
    [self creatMJ_footer];
}

- (void)setupData {
    self.currentPage = @"1";
    self.modelArray = [NSMutableArray array];
    [self reqeustOnePage];
}

#pragma mark ---------- MJRefresh -------------
- (void)creatMJ_header {
    MJWeakSelf;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf reqeustOnePage];
    }];
    self.tableView.mj_header = header;
}

- (void)creatMJ_footer {
    MJWeakSelf;
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf reqeustMoreData];
    }];
    self.tableView.mj_footer = footer;
}

#pragma mark ----------- tableView ------------
- (void)creatTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    // contentofset 会偏移的情况
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"UITableViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = [UIColor grayColor];
    label.text = @"    明细";
    label.frame = CGRectMake(0, 0, kScreenWidth, 60);
    return label;
}


-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"qsy"];
}

-(BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}

#pragma mark ---------- 请求数据 -----------
- (void)reqeustOnePage {
//    MJWeakSelf;
//    self.currentPage = @"1";
//    ProfitGroupListAPI *network = [[ProfitGroupListAPI alloc] initWithPageNum:self.currentPage pageSize:@"10" ID:@"GDA"];
//    [network startWithCompletionBlockWithSuccess:^(__kindof ProfitGroupListAPI * _Nonnull request) {
//        weakSelf.modelArray = [[request jsonForModel] mutableCopy];
//        [weakSelf.tableView reloadData];
//        [weakSelf.tableView.mj_header endRefreshing];
//        [weakSelf.tableView.mj_footer endRefreshing];
//    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//        [weakSelf.tableView.mj_header endRefreshing];
//        [weakSelf.tableView.mj_footer endRefreshing];
//    }];
}

- (void)reqeustMoreData {
//    MJWeakSelf;
//    self.currentPage = [NSString stringWithFormat:@"%ld",[self.currentPage integerValue] + 1];
//    ProfitGroupListAPI *network = [[ProfitGroupListAPI alloc] initWithPageNum:self.currentPage pageSize:@"10" ID:@"GDA"];
//    [network startWithCompletionBlockWithSuccess:^(__kindof ProfitGroupListAPI * _Nonnull request) {
//        NSArray *array = [request jsonForModel];
//        [weakSelf.modelArray addObjectsFromArray:array];
//        [weakSelf.tableView reloadData];
//        [weakSelf.tableView.mj_header endRefreshing];
//        [weakSelf.tableView.mj_footer endRefreshing];
//    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//        [weakSelf.tableView.mj_header endRefreshing];
//        [weakSelf.tableView.mj_footer endRefreshing];
//    }];
}

#pragma mark - JXPagingViewListViewDelegate

- (UIView *)listView {
    return self.view;
}

- (UIScrollView *)listScrollView {
    return self.tableView;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}

#pragma mark ---------- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.scrollCallback) {
        self.scrollCallback(scrollView);
    }
}

@end
