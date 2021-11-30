//
//  LoginViewController.m
//  MyProject
//
//  Created by 杨 on 10/1/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "LoginViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "YXBFormTopBottomCell.h"
#import "RegisterAPI.h"
#import <QMUIKit/QMUIAlertController.h>
#import <QMUIKit/QMUIDialogViewController.h>
#import <QMUIKit/QMUITextField.h>
#import <NSString+QMUI.h>
#import <UIView+QMUI.h>
#import "PopDXCaptchaView.h"
#import "MessageAPI.h"
#import "UIButton+YXBAdd.h"
#import <YYText/YYText.h>
#import "ForgetSecretViewController.h"
#import "RegistViewController.h"
#import "YXBFormLeftRightCell.h"
#import "CaptchaAPI.h"

#import "LoginAPI.h"
#import "YXBLanchManager.h"
#import <SVProgressHUD.h>
#import "YXBCaptchaView.h"
#import "UIColor+YXBGradient.h"


@interface LoginViewController ()

@property (nonatomic, copy) NSString *imageKey;
@property (nonatomic, strong) UIButton *codeButton;

@property (nonatomic, strong) YXBCaptchaView *captchaView;

@end

@implementation LoginViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

AC_SETUP_NAVIGATION_ITEM(@"");

- (void)setupUI {
    self.view.backgroundColor = YXBColor_background_light;
    [self setupNavigationItem];
    [self creatTableView];
    UIView *headerView = [self creatTableHeader];
    headerView.frame = CGRectMake(0, 0, kScreenWidth, 234);
    self.tableView.tableHeaderView = headerView;
    UIView *footerView = [self creatConfirmButton];
    footerView.frame = CGRectMake(0, 0, kScreenWidth, 300);
    self.tableView.tableFooterView = footerView;
    [self creatConfirmButton];
    
//    self.tableView.backgroundView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"ZS_logon_bg"]];
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
    [self requestCaptcha];
    
    PersonalModel *model = [UserManager sharedManager].personalInfo;
    if (model) {
        XLFormRowDescriptor *userDescrip = [self.form formRowWithTag:@"1"];
        userDescrip.value = model.account;
        XLFormRowDescriptor *bankNumberDescrip = [self.form formRowWithTag:@"2"];
        bankNumberDescrip.value = model.password;
    }
}

- (void)requestCaptcha {
    MJWeakSelf;
    CaptchaAPI *network = [[CaptchaAPI alloc] init];
    [network startWithCompletionBlockWithSuccess:^(__kindof CaptchaAPI * _Nonnull request) {
        UIImage *image = [request jsonForImage];
        if (image) {
            [weakSelf.codeButton setBackgroundImage:image forState:(UIControlStateNormal)];
        }
        
        NSString *imageKey = [request jsonForKey];
        if (imageKey) {
            weakSelf.imageKey = imageKey;
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

#pragma mark --------- xlform ----
- (void)creatTableView {
    XLFormDescriptor *form;
    XLFormSectionDescriptor *section;
    XLFormRowDescriptor *row;
    
    form = [XLFormDescriptor formDescriptor];
    section = [XLFormSectionDescriptor formSection];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"1" rowType:YXBFormRowDescriptorTypeLeftRightCell];
    row.title = NTVLocalized(@"账    号");
    row.height = 64;
    [row.cellConfig setObject:[UIColor clearColor] forKey:@"backgroundColor"];
    [row.cellConfig setObject:YXBColor_titleText forKey:@"titleLabel.textColor"];
    [row.cellConfig setObject:YXBColor_placeholder forKey:@"textField.placeholderColor"];
    [row.cellConfig setObject:YXBColor_titleText forKey:@"textField.textColor"];
    [row.cellConfig setObject:NTVLocalized(@"请输入手机号码或邮箱") forKey:@"textField.placeholder"];
//    [row.cellConfig setObject:@(UIKeyboardTypeNumberPad) forKey:@"keyboardType"];
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"2" rowType:YXBFormRowDescriptorTypeLeftRightCell];
    row.title = NTVLocalized(@"密    码");
    row.height = 64;
    [row.cellConfig setObject:[UIColor clearColor] forKey:@"backgroundColor"];
    [row.cellConfig setObject:YXBColor_titleText forKey:@"titleLabel.textColor"];
    [row.cellConfig setObject:YXBColor_placeholder forKey:@"textField.placeholderColor"];
    [row.cellConfig setObject:YXBColor_titleText forKey:@"textField.textColor"];
    [row.cellConfig setObject:NTVLocalized(@"请输入密码") forKey:@"textField.placeholder"];
    [row.cellConfig setObject:@(YES) forKey:@"textField.secureTextEntry"];
    [section addFormRow:row];
    
    
    /*
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"4" rowType:YXBFormRowDescriptorTypeLeftRightCell];
    row.title = NTVLocalized(@"验证码");
    row.height = 64;
    [row.cellConfig setObject:[UIColor clearColor] forKey:@"backgroundColor"];
    [row.cellConfig setObject:YXBColor_titleText forKey:@"titleLabel.textColor"];
    [row.cellConfig setObject:YXBColor_placeholder forKey:@"textField.placeholderColor"];
    [row.cellConfig setObject:YXBColor_titleText forKey:@"textField.textColor"];
    [row.cellConfig setObject:NTVLocalized(@"请输入验证码") forKey:@"textField.placeholder"];
//    [row.cellConfig setObject:@(UIKeyboardTypeNumberPad) forKey:@"keyboardType"];
    // 右视图
    [row.cellConfig setObject:@(UITextFieldViewModeAlways) forKey:@"textField.rightViewMode"];
    [row.cellConfig setObject:[self creatNewCodeButton] forKey:@"textField.rightView"];
    [section addFormRow:row];
    */
    
    [form addFormSection:section];
    
    self.form = form;
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableView.backgroundColor = YXBColor_background_light;
    //    self.tableView.separatorInset = UIEdgeInsetsMake(0, 12, 0, 12);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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

#pragma mark --------- 获取验证码 --------------
- (UIView *)creatNewCodeButton {
    /*
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, 100, 40);
    view.backgroundColor = YXBColor_descriptionText;
    
    if (_codeButton == nil) {
        _codeButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _codeButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_codeButton setTitleColor:YXBColor_descriptionText forState:(UIControlStateNormal)];
        _codeButton.frame = CGRectMake(0, 0, 100, 40);
//        [_codeButton setTitle:NTVLocalized(@"获取验证码") forState:(UIControlStateNormal)];
     [button sizeToFit];
        [_codeButton addTarget:self action:@selector(refeshCodeAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    [view addSubview:_codeButton];
//    [_codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(0);
//    }];
    
    return view;
     */
    
    self.captchaView = [[YXBCaptchaView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    return self.captchaView;
}

- (void)refeshCodeAction:(UIButton *)button {
    [self requestCaptcha];
}

//- (UIButton *)creatCodeButton {
//    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    button.titleLabel.font = [UIFont systemFontOfSize:14];
//    [button setTitleColor:YXBColor_descriptionText forState:(UIControlStateNormal)];
//    [button setTitle:NTVLocalized(@"获取验证码") forState:(UIControlStateNormal)];
//    [button addTarget:self action:@selector(codeAction:) forControlEvents:(UIControlEventTouchUpInside)];
//    [button sizeToFit];
//    return button;
//}

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
}

-(void)DXCaptchaEventSuccess:(NSString *)token andBtn:(UIButton *)btn{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    XLFormRowDescriptor *userDescrip = [self.form formRowWithTag:@"1"];
    MessageAPI *network = [[MessageAPI alloc] initWithPhone:userDescrip.value smsType:@"1" authToken:token];
    [network startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if([request isValidRequestData]){
            [btn setTheCountdownButton:btn startWithTime:59 title:NTVLocalized(@"获取验证码")  countDownTitle:@"s"];
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
        make.center.mas_equalTo(0);
    }];
    
    UILabel *titileLalbel = [[UILabel alloc] init];
    titileLalbel.font = [UIFont boldSystemFontOfSize:20];
    titileLalbel.textColor = YXBColor_titleText;
    titileLalbel.text = NTVLocalized(@"欢迎登录 再生贝");
    [view addSubview:titileLalbel];
    [titileLalbel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(iconImageView.mas_bottom).mas_offset(20);
    }];
    
    return view;
}


#pragma mark ---------- 提交 ----------------
- (UIView *)creatConfirmButton {
    UIView *view = [[UIView alloc] init];
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.backgroundColor = YXBColor_tint;
//    button.backgroundColor =  [UIColor bm_colorGradientChangeWithSize:CGSizeMake(kScreenWidth, 55) direction:(ZQGradientChangeDirectionLevel) startColor:UIColorFromHex(#21D3FB) endColor:UIColorFromHex(#05A7FE)];
    [button setTitleColor:YXBColor_descriptionText_light forState:(UIControlStateNormal)];
    [button setTitle:NTVLocalized(@"登录") forState:(UIControlStateNormal)];
    button.layer.cornerRadius = 25;
    [view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25);
        make.right.mas_equalTo(-25);
        make.top.mas_equalTo(60);
        make.height.mas_equalTo(50);
    }];
    [button addTarget:self action:@selector(confirmAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *forgetButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    forgetButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [forgetButton setTitleColor:YXBColor_titleText forState:(UIControlStateNormal)];
    [forgetButton setTitle:NTVLocalized(@"忘记密码？") forState:(UIControlStateNormal)];
    [view addSubview:forgetButton];
    [forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-36);
        make.top.mas_equalTo(15);
        make.height.mas_equalTo(20);
    }];
    [forgetButton addTarget:self action:@selector(forgetAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *registButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    registButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [registButton setTitleColor:YXBColor_descriptionText forState:(UIControlStateNormal)];
    [registButton setTitle:NTVLocalized(@"没有账号？去注册") forState:(UIControlStateNormal)];
    [view addSubview:registButton];
    [registButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-26);
        make.top.mas_equalTo(button.mas_bottom).mas_offset(35);
        make.height.mas_equalTo(20);
        make.centerX.mas_equalTo(0);
    }];
    [registButton addTarget:self action:@selector(registAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
     YYLabel *ruleLabel = [[YYLabel alloc] init];
     NSMutableAttributedString *text  = [[NSMutableAttributedString alloc] initWithString: @"登录即同意 用户协议"];
     text.yy_lineSpacing = 5;
     text.yy_font = [UIFont systemFontOfSize:12];
     text.yy_color = YXBColor_subText;
     __weak typeof(self) weakself = self;
     NSRange protocalRange = [text.string rangeOfString:@"用户协议"];
     [text yy_setFont:[UIFont boldSystemFontOfSize:12] range:protocalRange];
     //设置下划线
     YYTextDecoration *deco = [YYTextDecoration decorationWithStyle:(YYTextLineStyleSingle) width:@(1) color:YXBColor_descriptionText];
     [text yy_setTextUnderline:deco range:protocalRange];
    
     [text yy_setTextHighlightRange:protocalRange color:YXBColor_descriptionText backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
     ShowToast(@"用户服务协议");
     }];
     
    /*
     NSRange secretRange = [text.string rangeOfString:@"《隐私政策》"];
     [text yy_setFont:[UIFont boldSystemFontOfSize:12] range:secretRange];
     [text yy_setTextHighlightRange:secretRange color:YXBColor_descriptionText_highLight backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
     ShowToast(@"隐私政策");
     }];
     */
     
     ruleLabel.attributedText = text;
     ruleLabel.textAlignment = NSTextAlignmentCenter;
     [self.view addSubview:ruleLabel];
     [ruleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//     make.top.mas_equalTo(button.mas_bottom).mas_offset(10);
     make.bottom.mas_equalTo(-30);
     make.left.mas_equalTo(16);
     make.right.mas_equalTo(-16);
     make.height.mas_equalTo(20);
     }];
     
    
    return view;
}

- (void)forgetAction:(UIButton *)button {
    ForgetSecretViewController *vc = [ForgetSecretViewController new];
    PUSH(vc);
}

- (void)registAction:(UIButton *)button {
    RegistViewController *vc = [RegistViewController new];
    PUSH(vc);
}


#pragma mark ----------- 登录 ------------------
// 1.先登录app服务器
// 2.再登录云信服务器
// 3.两者都登录成功才算登录成功
- (void)confirmAction:(UIButton *)button {
    XLFormRowDescriptor *userDescrip = [self.form formRowWithTag:@"1"];
    XLFormRowDescriptor *bankNumberDescrip = [self.form formRowWithTag:@"2"];
//    XLFormRowDescriptor *bankDescrip = [self.form formRowWithTag:@"3"];
    XLFormRowDescriptor *codeDescrip = [self.form formRowWithTag:@"4"];
//    XLFormRowDescriptor *invateDescrip = [self.form formRowWithTag:@"8"];
    
    if (userDescrip.value == nil) {
        NSString *toastStr = NTVLocalized(@"请输入手机号码");
        ShowToast(toastStr);
        return;
    }
    
    if (bankNumberDescrip.value == nil) {
        NSString *toastStr = NTVLocalized(@"请输入登录密码");
        ShowToast(toastStr);
        return;
    }
    
    /*
    if (codeDescrip.value == nil) {
        ShowToast(@"请输入验证码");
        return;
    }
    NSString *codeString = [(NSString *)codeDescrip.value qmui_trim];
    // 验证码比较应该不区分大小写
    NSComparisonResult result = [codeString compare:self.captchaView.CatString options:NSCaseInsensitiveSearch];
    NSLog(@"%ld",(long)result);
    //正确弹出警告款提示正确
    if (result == 0) {
        
    }else {
        // 验证码不正确 -> 模拟点击，刷新验证码
        ShowToast(@"验证码错误");
        [self.captchaView touchesBegan:nil withEvent:nil];
        return;
    }
     */
    
    
    /*
     if (bankDescrip.value == nil) {
     ShowToast(@"请确认登录密码");
     return;
     }
     
     if (![bankNumberDescrip.value isEqualToString:bankDescrip.value]) {
     ShowToast(@"新密码与确认密码不一致");
     return;
     }
     
     if (addressDescrip.value == nil) {
     ShowToast(@"请输入短信验证码");
     return;
     }
     
     if (invateDescrip.value == nil) {
     ShowToast(@"请输入邀请码");
     return;
     }
     */
    
    // 1.先登录app服务器
    // 2.再登录云信服务器
    // 3.两者都登录成功才算登录成功
    
    [SVProgressHUD show];
    // 去掉首尾空格
//    NSString *codeString = [(NSString *)codeDescrip.value qmui_trim];
    MJWeakSelf
    LoginAPI *network = [[LoginAPI alloc] initWithAccount:userDescrip.value password:bankNumberDescrip.value authToken:nil key:nil];
    [network startWithCompletionBlockWithSuccess:^(__kindof LoginAPI * _Nonnull request) {
        [SVProgressHUD dismiss];
        PersonalModel *model = [request jsonForModel];
        if (model) {
            
            [[UserManager sharedManager] loginSuceess];
            
        } else {
//            [weakSelf requestCaptcha];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [SVProgressHUD dismiss];
        NSString *toastStr = NTVLocalized(@"登录超时,请重试");
        ShowToast(toastStr);
    }];
}

/*
- (void)doYunXinSeverLogin:(PersonalModel *)model {
    
    //    NSString *username = @"yang1993";
    //    NSString *password = @"123456";
    [SVProgressHUD show];
    
    NSString *loginAccount = model.accID;
    NSString *loginToken   = [model.neteaseToken tokenByPassword];
    
    //    BOOL isPrivate = NO;
    //    id setting = nil;
    //    setting = [[NSUserDefaults standardUserDefaults] valueForKey:@"privatization_enabled"];
    //    if(setting) {
    //        isPrivate = [setting boolValue];
    //    }
    //
    //    if(isPrivate) {
    //        setting = [[NSUserDefaults standardUserDefaults] valueForKey:@"privatization_password_md5_enabled"];
    //        BOOL md5Enable = NO;
    //        if(setting) {
    //            md5Enable = [setting boolValue];
    //        }
    //        if(md5Enable) {
    //            loginToken = [password MD5String];
    //        }
    //    }
    
    //NIM SDK 只提供消息通道，并不依赖用户业务逻辑，开发者需要为每个APP用户指定一个NIM帐号，NIM只负责验证NIM的帐号即可(在服务器端集成)
    //用户APP的帐号体系和 NIM SDK 并没有直接关系
    //DEMO中使用 username 作为 NIM 的account ，md5(password) 作为 token
    //开发者需要根据自己的实际情况配置自身用户系统和 NIM 用户系统的关系
    
    [[[NIMSDK sharedSDK] loginManager] login:loginAccount
                                       token:loginToken
                                  completion:^(NSError *error) {
        [SVProgressHUD dismiss];
        if (error == nil)
        {
            NTESLoginData *sdkData = [[NTESLoginData alloc] init];
            sdkData.account   = loginAccount;
            sdkData.token     = loginToken;
            [[NTESLoginManager sharedManager] setCurrentLoginData:sdkData];
            
            [[NTESServiceManager sharedManager] start];
            NTESMainTabController * mainTab = [[NTESMainTabController alloc] initWithNibName:nil bundle:nil];
            [UIApplication sharedApplication].keyWindow.rootViewController = mainTab;
        }
        else
        {
            NSString *toast = [NSString stringWithFormat:@"%@ code: %zd",@"登录失败".ntes_localized, error.code];
            [self.view makeToast:toast duration:2.0 position:CSToastPositionCenter];
        }
    }];
}
 */

@end
