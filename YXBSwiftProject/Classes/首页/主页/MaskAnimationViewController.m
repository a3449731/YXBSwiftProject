//
//  MaskAnimationViewController.m
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/11/13.
//  Copyright © 2023 ShengChang. All rights reserved.
//

#import "MaskAnimationViewController.h"
#import "YXBSwiftProject-Swift.h"
#import "LJKAudioCallAssistiveTouchView.h"
#import "MaskAnimationViewController+Animation.h"

@interface MaskAnimationViewController () <LJKAudioCallAssistiveTouchViewDelegate>

@property (strong, nonatomic) UIButton *btn;
@property (strong, nonatomic) UIButton *maskLayer;
@property (strong, nonatomic) LJKAudioCallAssistiveTouchView *touchView;

@end

// 特殊持有单例，为了实现最小化
static MaskAnimationViewController *_instance;
static dispatch_once_t onceToken;

@implementation MaskAnimationViewController

#pragma mark - 初始化
+ (instancetype)sharedManager {
    dispatch_once(&onceToken, ^{
        _instance = [[MaskAnimationViewController alloc] init];
    });
    return _instance;
}

#pragma mark - 销毁
+ (void)attempDealloc{
    onceToken = 0;
    _instance = nil;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self hideAudioCallAssistiveTouchView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self showAudioCallAssistiveTouchView];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navigationController.delegate = self;
 
    RoomMessageTableView *view = [[RoomMessageTableView alloc] init];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(200);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(-100);
        make.right.mas_equalTo(0);
    }];
    
    self.view.backgroundColor = [UIColor redColor];
    
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn.frame = CGRectMake(150, 150, 150, 50);
//    smallButton.backgroundColor = [UIColor yellowColor];
    [_btn setTitle:@"最小化" forState:(UIControlStateNormal)];
    _btn.layer.cornerRadius = 25;
    [_btn addTarget:self action:@selector(smallButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
