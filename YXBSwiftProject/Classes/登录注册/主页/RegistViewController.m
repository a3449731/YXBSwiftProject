//
//  RegistViewController.m
//  MyProject
//
//  Created by 杨 on 10/1/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "RegistViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "YXBFormLeftRightCell.h"
#import "RegisterAPI.h"
#import <QMUIKit/QMUIAlertController.h>
#import <QMUIKit/QMUIDialogViewController.h>
#import <QMUIKit/QMUITextField.h>
#import <UIView+QMUI.h>
#import "PopDXCaptchaView.h"
#import "MessageAPI.h"
#import "UIButton+YXBAdd.h"
#import <YYText/YYText.h>
#import "UIColor+YXBGradient.h"

@interface RegistViewController ()

@end

@implementation RegistViewController

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self setupTool];
    [self setupData];
}

AC_SETUP_NAVIGATION_ITEM(NTVLocalized(@"注册"));

- (void)setupUI {
    self.view.backgroundColor = YXBColor_background_light;
    [self setupNavigationItem];
    [self creatTableView];
    UIView *headerView = [self creatTableHeader];
    headerView.frame = CGRectMake(0, 0, kScreenWidth, 200);
    self.tableView.tableHeaderView = headerView;
    
    UIView *footerView = [self creatTableFooter];
    footerView.frame = CGRectMake(0, 0, kScreenWidth, 180);
    self.tableView.tableFooterView = footerView;
    
//    self.tableView.backgroundView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"DML_login_backgroud02"]];
}

- (void)setupTool {
    NSInteger count = [self tableView:self.tableView numberOfRowsInSection:0];
    for (NSInteger i = 0; i < count; i++) {
        UITableViewCell *cell = [self tableView:self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        cell.qmui_borderPosition = QMUIViewBorderPositionBottom;
        cell.qmui_borderWidth = 1;
        cell.qmui_borderColor = YXBColor_separator;
    }
}

- (void)setupData {
    
}

#pragma mark --------- xlform ----
- (void)creatTableView {
    XLFormDescriptor *form;
    XLFormSectionDescriptor *section;
    XLFormRowDescriptor *row;
    
    form = [XLFormDescriptor formDescriptor];
    section = [XLFormSectionDescriptor formSection];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"1" rowType:YXBFormRowDescriptorTypeLeftRightCell];
    row.title = NTVLocalized(@"登录账号");
    row.height = 70;
    [row.cellConfig setObject:[UIColor clearColor] forKey:@"backgroundColor"];
    [row.cellConfig setObject:YXBColor_titleText forKey:@"titleLabel.textColor"];
    [row.cellConfig setObject:YXBColor_placeholder forKey:@"textField.placeholderColor"];
    [row.cellConfig setObject:YXBColor_titleText forKey:@"textField.textColor"];
    [row.cellConfig setObject:NTVLocalized(@"请输入手机号码或邮箱") forKey:@"textField.placeholder"];
//    [row.cellConfig setObject:@(UIKeyboardTypeNumberPad) forKey:@"keyboardType"];
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"4" rowType:YXBFormRowDescriptorTypeLeftRightCell];
    row.title = NTVLocalized(@"验 证 码");
    row.height = 70;
    [row.cellConfig setObject:[UIColor clearColor] forKey:@"backgroundColor"];
    [row.cellConfig setObject:YXBColor_titleText forKey:@"titleLabel.textColor"];
    [row.cellConfig setObject:YXBColor_placeholder forKey:@"textField.placeholderColor"];
    [row.cellConfig setObject:YXBColor_titleText forKey:@"textField.textColor"];
    [row.cellConfig setObject:NTVLocalized(@"请输入验证码") forKey:@"textField.placeholder"];
    [row.cellConfig setObject:@(UIKeyboardTypeNumberPad) forKey:@"keyboardType"];
    // 右视图
    [row.cellConfig setObject:@(UITextFieldViewModeAlways) forKey:@"textField.rightViewMode"];
    [row.cellConfig setObject:[self creatCodeButton] forKey:@"textField.rightView"];
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"2" rowType:YXBFormRowDescriptorTypeLeftRightCell];
    row.title = NTVLocalized(@"登录密码");
    row.height = 70;
    [row.cellConfig setObject:[UIColor clearColor] forKey:@"backgroundColor"];
    [row.cellConfig setObject:YXBColor_titleText forKey:@"titleLabel.textColor"];
    [row.cellConfig setObject:YXBColor_placeholder forKey:@"textField.placeholderColor"];
    [row.cellConfig setObject:YXBColor_titleText forKey:@"textField.textColor"];
    [row.cellConfig setObject:NTVLocalized(@"请设置密码") forKey:@"textField.placeholder"];
    [row.cellConfig setObject:@(YES) forKey:@"textField.secureTextEntry"];
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"3" rowType:YXBFormRowDescriptorTypeLeftRightCell];
    row.title = NTVLocalized(@"确认密码");
    row.height = 70;
    [row.cellConfig setObject:[UIColor clearColor] forKey:@"backgroundColor"];
    [row.cellConfig setObject:YXBColor_titleText forKey:@"titleLabel.textColor"];
    [row.cellConfig setObject:YXBColor_placeholder forKey:@"textField.placeholderColor"];
    [row.cellConfig setObject:YXBColor_titleText forKey:@"textField.textColor"];
    [row.cellConfig setObject:NTVLocalized(@"确认登录密码") forKey:@"textField.placeholder"];
    [row.cellConfig setObject:@(YES) forKey:@"textField.secureTextEntry"];
    [section addFormRow:row];
        
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"9" rowType:YXBFormRowDescriptorTypeLeftRightCell];
    row.title = NTVLocalized(@"支付密码");
    row.height = 70;
    [row.cellConfig setObject:[UIColor clearColor] forKey:@"backgroundColor"];
    [row.cellConfig setObject:YXBColor_titleText forKey:@"titleLabel.textColor"];
    [row.cellConfig setObject:YXBColor_placeholder forKey:@"textField.placeholderColor"];
    [row.cellConfig setObject:YXBColor_titleText forKey:@"textField.textColor"];
    [row.cellConfig setObject:NTVLocalized(@"请设置支付密码") forKey:@"textField.placeholder"];
    [row.cellConfig setObject:@(UIKeyboardTypeNumberPad) forKey:@"keyboardType"];
    [row.cellConfig setObject:@(YES) forKey:@"textField.secureTextEntry"];
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"8" rowType:YXBFormRowDescriptorTypeLeftRightCell];
    row.title = NTVLocalized(@"邀请码");
    row.height = 70;
    [row.cellConfig setObject:[UIColor clearColor] forKey:@"backgroundColor"];
    [row.cellConfig setObject:YXBColor_titleText forKey:@"titleLabel.textColor"];
    [row.cellConfig setObject:YXBColor_placeholder forKey:@"textField.placeholderColor"];
    [row.cellConfig setObject:YXBColor_titleText forKey:@"textField.textColor"];
    [row.cellConfig setObject:NTVLocalized(@"请输入邀请码") forKey:@"textField.placeholder"];
    [row.cellConfig setObject:@(UIKeyboardTypeNumberPad) forKey:@"keyboardType"];
    [section addFormRow:row];
    
    [form addFormSection:section];
    
    self.form = form;
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 32);
//    self.tableView.separatorColor = YXBColor_separator;
    self.tableView.backgroundColor = YXBColor_background_light;
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(-kStatusBarHeight);
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

#pragma mark --------- 获取验证码 --------------
- (UIButton *)creatCodeButton {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:YXBColor_descriptionText forState:(UIControlStateNormal)];
    [button setTitle:NTVLocalized(@"获取验证码") forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(codeAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [button sizeToFit];
    return button;
}

- (void)codeAction:(UIButton *)button {
    [self.view endEditing:YES];
    XLFormRowDescriptor *userDescrip = [self.form formRowWithTag:@"1"];
    if (userDescrip.value == nil) {
        NSString *toastStr = NTVLocalized(@"请输入手机号码");
        ShowToast(toastStr);
        return;
    }
    
     PopDXCaptchaView * captchaView = [PopDXCaptchaView createPopDXCaptchaView];
     MJWeakSelf
     [captchaView setPopDXCaptchaViewSuccess:^(NSString * _Nonnull token) {
     [weakSelf DXCaptchaEventSuccess:token andBtn:button];
     }];
     [captchaView show];
     
//    [self DXCaptchaEventSuccess:@"" andBtn:button];
}

-(void)DXCaptchaEventSuccess:(NSString *)token andBtn:(UIButton *)btn{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    XLFormRowDescriptor *userDescrip = [self.form formRowWithTag:@"1"];
    MessageAPI *network = [[MessageAPI alloc] initWithPhone:userDescrip.value smsType:@"1" authToken:token];
    [network startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if([request isValidRequestData]){
            [btn setTheCountdownButton:btn startWithTime:59 title:NTVLocalized(@"获取验证码") countDownTitle:@"s"];
            [btn sizeToFit];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (UIView *)creatTableHeader {
    UIView *view = [[UIView alloc] init];
    
    UIImageView *bgImageView = [[UIImageView alloc] init];
    bgImageView.image = [UIImage imageNamed:@"ZS_logon_bg"];
    [view addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.image = [UIImage imageNamed:@"ZS_login_logo"];
    [view addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(37);
        make.top.mas_equalTo(70);
        make.width.height.mas_equalTo(62);
    }];
    
    UILabel *titileLalbel = [[UILabel alloc] init];
    titileLalbel.font = [UIFont boldSystemFontOfSize:25];
    titileLalbel.textColor = YXBColor_titleText;
    titileLalbel.text = NTVLocalized(@"注册 再生贝");
    [view addSubview:titileLalbel];
    [titileLalbel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconImageView.mas_right).mas_offset(18);
        make.top.mas_equalTo(iconImageView).mas_offset(10);
    }];
    
    UILabel *tipLalbel = [[UILabel alloc] init];
    tipLalbel.font = [UIFont systemFontOfSize:12];
    tipLalbel.textColor = YXBColor_subText;
    tipLalbel.text = NTVLocalized(@"手机号注册账号");
    [view addSubview:tipLalbel];
    [tipLalbel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconImageView.mas_right).mas_offset(18);
        make.top.mas_equalTo(titileLalbel.mas_bottom).mas_offset(8);
    }];
    
    return view;
}

#pragma mark ---------- 提交 ----------------
- (UIView *)creatTableFooter {
    UIView *view = [[UIView alloc] init];
    //    view.backgroundColor = YXBColor_tint_highLight;
    //    [self.view addSubview:view];
    //
    //    [view mas_remakeConstraints:^(MASConstraintMaker *make) {
    //        make.left.right.mas_equalTo(0);
    //        make.bottom.mas_equalTo(-96 - kSafeAreaBottomMargin - 44);
    //        make.height.mas_equalTo(1);
    //    }];
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    button.backgroundColor = YXBColor_descriptionText;
    button.backgroundColor =  YXBColor_tint;
    [button setTitleColor:YXBColor_descriptionText_light forState:(UIControlStateNormal)];
    [button setTitle:NTVLocalized(@"立即注册") forState:(UIControlStateNormal)];
    button.layer.cornerRadius = 25;
    [view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25);
        make.right.mas_equalTo(-25);
        make.top.mas_offset(50);
        make.height.mas_equalTo(50);
    }];
    [button addTarget:self action:@selector(confirmAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    YYLabel *ruleLabel = [[YYLabel alloc] init];
    //    ruleLabel.textAlignment = NSTextAlignmentCenter;
    NSMutableAttributedString *text  = [[NSMutableAttributedString alloc] initWithString: NTVLocalized(@"已有账号？    去登录")];
    text.yy_lineSpacing = 5;
    text.yy_font = [UIFont systemFontOfSize:14];
    text.yy_color = YXBColor_subText;
    text.yy_alignment = NSTextAlignmentCenter;
    __weak typeof(self) weakself = self;
    NSRange protocalRange = [text.string rangeOfString:NTVLocalized(@"去登录")];
    [text yy_setFont:[UIFont boldSystemFontOfSize:14] range:protocalRange];
    //设置下划线
    YYTextDecoration *deco = [YYTextDecoration decorationWithStyle:(YYTextLineStyleSingle) width:@(1) color:YXBColor_descriptionText];
    [text yy_setTextUnderline:deco range:protocalRange];
    
    [text yy_setTextHighlightRange:protocalRange color:YXBColor_descriptionText backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        POP;
    }];
    
    ruleLabel.attributedText = text;
    [view addSubview:ruleLabel];
    [ruleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(button.mas_bottom).mas_offset(30);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(20);
    }];
    
    return view;
}

- (void)confirmAction:(UIButton *)button {
    XLFormRowDescriptor *userDescrip = [self.form formRowWithTag:@"1"];
    XLFormRowDescriptor *bankNumberDescrip = [self.form formRowWithTag:@"2"];
    XLFormRowDescriptor *bankDescrip = [self.form formRowWithTag:@"3"];
    XLFormRowDescriptor *addressDescrip = [self.form formRowWithTag:@"4"];
    XLFormRowDescriptor *invateDescrip = [self.form formRowWithTag:@"8"];
    XLFormRowDescriptor *payDescrip = [self.form formRowWithTag:@"9"];
    
    if (userDescrip.value == nil) {
        NSString *toastStr = NTVLocalized(@"请输入短信验证码");
        ShowToast(toastStr);
        ShowToast(@"请输入手机号码");
        return;
    }
    
    if (bankNumberDescrip.value == nil) {
        NSString *toastStr = NTVLocalized(@"请输入短信验证码");
        ShowToast(toastStr);
        ShowToast(@"请设置登录密码");
        return;
    }
    
    if (bankDescrip.value == nil) {
        NSString *toastStr = NTVLocalized(@"请输入短信验证码");
        ShowToast(toastStr);
        ShowToast(@"请确认登录密码");
        return;
    }
    
    if (![bankNumberDescrip.value isEqualToString:bankDescrip.value]) {
        NSString *toastStr = NTVLocalized(@"请输入短信验证码");
        ShowToast(toastStr);
        ShowToast(@"新密码与确认密码不一致");
        return;
    }
    
    if (addressDescrip.value == nil) {
        NSString *toastStr = NTVLocalized(@"请输入短信验证码");
        ShowToast(toastStr);
        return;
    }
    
    if (invateDescrip.value == nil) {
        NSString *toastStr = NTVLocalized(@"请输入邀请码");
        ShowToast(toastStr);
        return;
    }
    
    if (payDescrip.value == nil) {
        NSString *toastStr = NTVLocalized(@"请设置支付密码");
        ShowToast(toastStr);
        return;
    }
    
    RegisterAPI *network = [[RegisterAPI alloc] initWithPhone:userDescrip.value messageCode:addressDescrip.value password:bankDescrip.value shareCode:invateDescrip.value paypass:payDescrip.value];
    [network startWithCompletionBlockWithSuccess:^(__kindof RegisterAPI * _Nonnull request) {
        if ([request isValidRequestData]) {
            NSString *toastStr = NTVLocalized(@"注册成功");
            ShowToast(toastStr);
            POP;
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
