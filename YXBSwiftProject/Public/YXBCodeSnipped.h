//
//  YXBCodeSnipped.h
//  MyProject
//
//  Created by YangXiaoBin on 2019/12/3.
//  Copyright © 2019 YangXiaoBin. All rights reserved.
//

#program mark ---------- 代码块,方便在不同电脑上使用 -----------------

#ifndef YXBCodeSnipped_h
#define YXBCodeSnipped_h


#program mark ---------- GCD_After -----------------
/*
//GCD延迟
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
               
               });
*/

#program mark ---------- GCD_Timer -----------------
/*
@property (nonatomic, strong) dispatch_source_t timer;

// 创建GCD定时器
dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
_timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0); //每秒执行
// 事件回调
dispatch_source_set_event_handler(_timer, ^{
                                
                                  dispatch_async(dispatch_get_main_queue(), ^{
    // 在主线程中实现需要的功能
    
});
                                  });

// 开启定时器
dispatch_resume(_timer);
//    // 挂起定时器（dispatch_suspend 之后的 Timer，是不能被释放的！会引起崩溃）
//    dispatch_suspend(_timer);
//    // 关闭定时器
//    dispatch_source_cancel(_timer);
*/

#program mark ---------- YXB_Form -----------------
/*
#import "SweetViewController.h"
#import "SweetCell.h"
#import <QMUIKit/QMUIAlertController.h>
#import <QMUIKit/QMUIDialogViewController.h>
#import <QMUIKit/QMUITextField.h>

@interface SweetViewController ()

@end

@implementation SweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self setupTool];
    [self setupData];
}

- (void)setupUI {
    [self creatTableView];
    UIView *fotterView = [self creatTableFooter];
    self.tableView.tableFooterView = fotterView;
}

- (void)setupTool {
    
}

- (void)setupData {
    
}

- (void)creatTableView {
    XLFormDescriptor *form;
    XLFormSectionDescriptor *section;
    XLFormRowDescriptor *row;
    
    form = [XLFormDescriptor formDescriptor];
    
    section = [XLFormSectionDescriptor formSection];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"1" rowType:YXBFormRowDescriptorTypeSweetCell title:@"账号"];
    [row.cellConfig setObject:@"请输入短信验证码" forKey:@"textField.placeholder"];
    // 键盘
    [row.cellConfig setObject:@(UIKeyboardTypeNumberPad) forKey:@"keyboardType"];
    // 秘密输入
    //    [row.cellConfig setObject:@(YES) forKey:@"textField.secureTextEntry"];
    // 对齐方式
    [row.cellConfig setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    // textField交互
    //    [row.cellConfig setObject:@(NO) forKey:@"textField.enabled"];
    // 右视图
    //    [row.cellConfig setObject:@(UITextFieldViewModeAlways) forKey:@"textField.rightViewMode"];
    //    [row.cellConfig setObject:[self creatCodeButton] forKey:@"textField.rightView"];
    row.height = 80;
    row.value = @"12345667778";
    [section addFormRow:row];
    
    [form addFormSection:section];
    
    self.form = form;
    
}

- (UIButton *)creatCodeButton {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setTitleColor:MLColorBlue forState:(UIControlStateNormal)];
    [button setTitle:@"获取验证码" forState:(UIControlStateNormal)];
    return button;
}

#pragma mark ---------- 分区头尾 ---------------
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

#pragma mark ---------- 确认按钮 ----------------
- (UIView *)creatTableFooter {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = MLColorBG_white;
    view.frame = CGRectMake(0, 0, kScreenWidth, 80);
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.backgroundColor = MLColorBlue;
    [button setTitleColor:MLColorWhite forState:(UIControlStateNormal)];
    [button setTitle:@"确认" forState:(UIControlStateNormal)];
    button.layer.cornerRadius = 4;
    [view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.bottom.mas_equalTo(-10);
    }];
    [button addTarget:self action:@selector(confirmAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    return view;
}

- (IBAction)confirmAction:(UIButton *)sender {
    MJWeakSelf;
    QMUIAlertController *alert = [QMUIAlertController alertControllerWithTitle:@"提示" message:@"确认提交？" preferredStyle:(QMUIAlertControllerStyleAlert)];
    [alert addCancelAction];
    QMUIAlertAction *confirmAction = [QMUIAlertAction actionWithTitle:@"确认" style:(QMUIAlertActionStyleDefault) handler:^(__kindof QMUIAlertController * _Nonnull aAlertController, QMUIAlertAction * _Nonnull action) {
        [weakSelf payPass];
    }];
    [alert addAction:confirmAction];
    [alert showWithAnimated:YES];
}

- (void)payPass {
    MJWeakSelf;
    QMUIDialogTextFieldViewController *dialogViewController = [[QMUIDialogTextFieldViewController alloc] init];
    dialogViewController.title = @"请输入安全密码";
    dialogViewController.headerViewBackgroundColor = MLColorWhite;
    [dialogViewController addTextFieldWithTitle:nil configurationHandler:^(QMUILabel *titleLabel, QMUITextField *textField, CALayer *separatorLayer) {
        textField.maximumTextLength = 6;
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.secureTextEntry = YES;
    }];
    // 自动根据输入框的内容是否为空来控制 submitButton.enabled 状态。这个属性默认就是 YES，这里为写出来只是为了演示
    dialogViewController.enablesSubmitButtonAutomatically = YES;
    [dialogViewController addCancelButtonWithText:@"取消" block:nil];
    [dialogViewController addSubmitButtonWithText:@"确定" block:^(QMUIDialogTextFieldViewController *dialogViewController) {
        QMUITextField *textField = dialogViewController.textFields.firstObject;
        [weakSelf requestWithPassword:textField.text];
        [dialogViewController hide];
    }];
    [dialogViewController show];
}

- (void)requestWithPassword:(NSString *)password {
    XLFormRowDescriptor *userDescrip = [self.form formRowWithTag:@"1"];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
*/


#program mark ---------- YXB_IGListCollection -----------------
/*
#import "MemberViewController.h"
#import <IGListKit/IGListKit.h>

@interface MemberViewController () <IGListAdapterDataSource>

@property (nonatomic, strong) IGListAdapter *adapter;
@property (nonatomic, strong) IGListCollectionView *collectionView;

@end

@implementation MemberViewController

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
    
}

#pragma mark ---------------- collectionView --------------------
- (void)creatCollectionView {
    IGListCollectionViewLayout *layout = [[IGListCollectionViewLayout alloc] initWithStickyHeaders:YES scrollDirection:(UICollectionViewScrollDirectionVertical) topContentInset:100 stretchToEdge:YES];
    self.collectionView = [[IGListCollectionView alloc] initWithFrame:CGRectZero listCollectionViewLayout:layout];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = UIColorFromHex(#F2F4F8);
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

#pragma mark ----------- MJRefresh -----------------------
- (void)creatMJ_header {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
    }];
    self.collectionView.mj_header = header;
}

- (void)creatMJ_footer {
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
    }];
    self.collectionView.mj_footer = footer;
}

#pragma mark ------------- IGList ------------------
- (void)creatAdapter {
    IGListAdapterUpdater *updater = [[IGListAdapterUpdater alloc] init];
    self.adapter = [[IGListAdapter alloc] initWithUpdater:updater viewController:self];
    self.adapter.dataSource = self;
    self.adapter.collectionView = self.collectionView;
}

- (NSArray<id <IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {
    return @[@"1"];
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
    return [IGListSectionController new];
}

- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
    return nil;
}

@end
*/

#program mark ---------- YXB_IGSection -----------------
/*
- (instancetype)init {
    self = [super init];
    if (self) {
        self.inset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.minimumLineSpacing = 0;
        self.minimumInteritemSpacing = 0;
        self.supplementaryViewSource = self;
    }
    return self;
}

- (NSInteger)numberOfItems {
    return 3;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    return CGSizeMake(self.collectionContext.containerSize.width - self.inset.left - self.inset.right, 50);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    id cellClass = [UICollectionViewCell class];
    UICollectionViewCell *cell = [self.collectionContext dequeueReusableCellOfClass:cellClass forSectionController:self atIndex:index];
    return cell;
}

- (void)didUpdateToObject:(id)object {
    
}

- (void)didSelectItemAtIndex:(NSInteger)index {
    
}

- (NSArray<NSString *> *)supportedElementKinds {
    return @[UICollectionElementKindSectionHeader];
}

- (__kindof UICollectionReusableView *)viewForSupplementaryElementOfKind:(NSString *)elementKind
atIndex:(NSInteger)index {
    id headerClass = [UICollectionReusableView class];
    UICollectionReusableView *header = [self.collectionContext dequeueReusableSupplementaryViewOfKind:elementKind forSectionController:self class:headerClass atIndex:index];
    return header;
}

- (CGSize)sizeForSupplementaryViewOfKind:(NSString *)elementKind
atIndex:(NSInteger)index {
    return CGSizeMake(self.collectionContext.containerSize.width, 100);
}
 */

#program mark ---------- YXB_TableView -----------------
/*
#import "BillViewController.h"

@interface BillViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation BillViewController

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
    
}

- (void)setupData {
    
}

#pragma mark ----------- tableView ------------
- (void)creatTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
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
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 115;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"UITableViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
*/


#program mark ---------- YXB_TableView_Page -----------------
/*
#import "ProfitViewController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "ProfitGroupListAPI.h"

@interface ProfitViewController () <UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<FriendModel *> *modelArray;
@property (nonatomic, copy) NSString *currentPage;

@end

@implementation ProfitViewController

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
    label.textColor = MLColorBlack;
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
    MJWeakSelf;
    self.currentPage = @"1";
    ProfitGroupListAPI *network = [[ProfitGroupListAPI alloc] initWithPageNum:self.currentPage pageSize:@"10" ID:@"GDA"];
    [network startWithCompletionBlockWithSuccess:^(__kindof ProfitGroupListAPI * _Nonnull request) {
        weakSelf.modelArray = [[request jsonForModel] mutableCopy];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}

- (void)reqeustMoreData {
    MJWeakSelf;
    self.currentPage = [NSString stringWithFormat:@"%ld",[self.currentPage integerValue] + 1];
    ProfitGroupListAPI *network = [[ProfitGroupListAPI alloc] initWithPageNum:self.currentPage pageSize:@"10" ID:@"GDA"];
    [network startWithCompletionBlockWithSuccess:^(__kindof ProfitGroupListAPI * _Nonnull request) {
        NSArray *array = [request jsonForModel];
        [weakSelf.modelArray addObjectsFromArray:array];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}

@end
 */

#program mark ---------- YXB_UICollection -----------------
/*
#import "MemberViewController.h"
#import <IGListKit/IGListKit.h>

@interface MemberViewController () <IGListAdapterDataSource>

@property (nonatomic, strong) IGListAdapter *adapter;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation MemberViewController

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
    
}

#pragma mark ---------------- collectionView --------------------
- (void)creatCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = UIColorFromHex(#F2F4F8);
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

#pragma mark ----------- MJRefresh -----------------------
- (void)creatMJ_header {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
    }];
    self.collectionView.mj_header = header;
}

- (void)creatMJ_footer {
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
    }];
    self.collectionView.mj_footer = footer;
}

#pragma mark ------------- IGList ------------------
- (void)creatAdapter {
    IGListAdapterUpdater *updater = [[IGListAdapterUpdater alloc] init];
    self.adapter = [[IGListAdapter alloc] initWithUpdater:updater viewController:self];
    self.adapter.dataSource = self;
    self.adapter.collectionView = self.collectionView;
}

- (NSArray<id <IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {
    return @[@"1"];
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
    return [IGListSectionController new];
}

- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
    return nil;
}

@end
*/
 
#program mark ---------- YXB_UICollection_Page -----------------
/*
#import "MyTeamViewController.h"
#import <IGListKit/IGListKit.h>
#import "MyTeamSection.h"
#import "FriendsAPI.h"
#import "NSArray+IGListDiffable.h"

@interface MyTeamViewController () <IGListAdapterDataSource>

@property (nonatomic, strong) IGListAdapter *adapter;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray<MemberModel *> *modelArray;
@property (nonatomic, copy) NSString *currentPage;

@end

@implementation MyTeamViewController

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
    MJWeakSelf;
    self.currentPage = @"1";
    FriendsAPI *network = [[FriendsAPI alloc] initWithPage:self.currentPage limit:@"20"];
    [network startWithCompletionBlockWithSuccess:^(__kindof FriendsAPI * _Nonnull request) {
        weakSelf.modelArray = [[request jsonForModel] mutableCopy];
        [weakSelf.adapter reloadDataWithCompletion:nil];
        [weakSelf.collectionView.mj_header endRefreshing];
        [weakSelf.collectionView.mj_footer endRefreshing];
        [weakSelf hasMoreData:request];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf.collectionView.mj_header endRefreshing];
        [weakSelf.collectionView.mj_footer endRefreshing];
    }];
}

- (void)reqeustMoreData {
    MJWeakSelf;
    self.currentPage = [NSString stringWithFormat:@"%ld",[self.currentPage integerValue] + 1];
    FriendsAPI *network = [[FriendsAPI alloc] initWithPage:self.currentPage limit:@"20"];
    [network startWithCompletionBlockWithSuccess:^(__kindof FriendsAPI * _Nonnull request) {
        NSArray *array = [request jsonForModel];
        [weakSelf.modelArray addObjectsFromArray:array];
        [weakSelf.adapter reloadDataWithCompletion:nil];
        [weakSelf.collectionView.mj_header endRefreshing];
        [weakSelf.collectionView.mj_footer endRefreshing];
        [weakSelf hasMoreData:request];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf.collectionView.mj_header endRefreshing];
        [weakSelf.collectionView.mj_footer endRefreshing];
    }];
}

- (void)hasMoreData:(YTKRequest *)request {
    if ([[request.responseJSONObject valueForKey:@"data"] isKindOfClass:[NSDictionary class]] && [[request.responseJSONObject valueForKey:@"data"] containsObjectForKey:@"hasNextPage"]) {
        NSString *newPage = [[request.responseJSONObject valueForKey:@"data"] valueForKey:@"hasNextPage"];
        if (newPage && [newPage boolValue] == NO) {
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [self.collectionView.mj_footer resetNoMoreData];
        }
    }
}


#pragma mark ---------------- collectionView --------------------
- (void)creatCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = UIColorFromHex(#F2F4F8);
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
    self.adapter.collectionView = self.collectionView;
}

- (NSArray<id <IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {
    if (self.modelArray) {
        return @[self.modelArray];
    }
    return nil;
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
    return [MyTeamSection new];
}

- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
    return nil;
}

@end
 */

#endif /* YXBCodeSnipped_h */
