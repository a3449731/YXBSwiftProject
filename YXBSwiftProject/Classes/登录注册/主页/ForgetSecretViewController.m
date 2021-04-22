//
//  ForgetSecretViewController.m
//  MyProject
//
//  Created by YangXiaoBin on 2019/12/18.
//  Copyright © 2019 YangXiaoBin. All rights reserved.
//

#import "ForgetSecretViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "YXBFormLeftRightCell.h"
#import "ForgetPassAPI.h"
#import <QMUIKit/QMUIAlertController.h>
#import <QMUIKit/QMUIDialogViewController.h>
#import <QMUIKit/QMUITextField.h>
#import "PopDXCaptchaView.h"
#import "MessageAPI.h"
#import "UIButton+YXBAdd.h"

@interface ForgetSecretViewController ()

@end

@implementation ForgetSecretViewController

- (UIStatusBarStyle)preferredStatusBarStyle  {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self setupTool];
    [self setupData];
}

AC_SETUP_NAVIGATION_ITEM(NTVLocalized(@"忘记密码"));

- (void)setupUI {
    self.view.backgroundColor = YXBColor_background;
    [self setupNavigationItem];
    [self creatTableView];
    [self creatConfirmButton];
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"LX_LX_signIn_bg"]];
}

- (void)setupTool {
    
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
    row.title = NTVLocalized(@"账    号");
    row.height = 60;
    [row.cellConfig setObject:[UIColor clearColor] forKey:@"backgroundColor"];
    [row.cellConfig setObject:YXBColor_titleText forKey:@"titleLabel.textColor"];
    [row.cellConfig setObject:YXBColor_placeholder forKey:@"textField.placeholderColor"];
    [row.cellConfig setObject:YXBColor_titleText forKey:@"textField.textColor"];
    [row.cellConfig setObject:NTVLocalized(@"请输入手机号码") forKey:@"textField.placeholder"];
    [row.cellConfig setObject:@(UIKeyboardTypeNumberPad) forKey:@"keyboardType"];
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"4" rowType:YXBFormRowDescriptorTypeLeftRightCell];
    row.title = NTVLocalized(@"验 证 码");
    row.height = 60;
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
    row.title = NTVLocalized(@"新密码");
    row.height = 60;
    [row.cellConfig setObject:[UIColor clearColor] forKey:@"backgroundColor"];
    [row.cellConfig setObject:YXBColor_titleText forKey:@"titleLabel.textColor"];
    [row.cellConfig setObject:YXBColor_placeholder forKey:@"textField.placeholderColor"];
    [row.cellConfig setObject:YXBColor_titleText forKey:@"textField.textColor"];
    [row.cellConfig setObject:NTVLocalized(@"请输入新的登录密码") forKey:@"textField.placeholder"];
    [row.cellConfig setObject:@(YES) forKey:@"textField.secureTextEntry"];
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"3" rowType:YXBFormRowDescriptorTypeLeftRightCell];
    row.title = NTVLocalized(@"确认密码");
    row.height = 60;
    [row.cellConfig setObject:[UIColor clearColor] forKey:@"backgroundColor"];
    [row.cellConfig setObject:YXBColor_titleText forKey:@"titleLabel.textColor"];
    [row.cellConfig setObject:YXBColor_placeholder forKey:@"textField.placeholderColor"];
    [row.cellConfig setObject:YXBColor_titleText forKey:@"textField.textColor"];
    [row.cellConfig setObject:NTVLocalized(@"确认登录密码") forKey:@"textField.placeholder"];
    [row.cellConfig setObject:@(YES) forKey:@"textField.secureTextEntry"];
    [section addFormRow:row];
       
    [form addFormSection:section];
    
    self.form = form;
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableView.backgroundColor = YXBColor_background;
    self.tableView.separatorColor = YXBColor_separator;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 32, 0, 32);
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
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
    MessageAPI *network = [[MessageAPI alloc] initWithPhone:userDescrip.value smsType:@"2" authToken:token];
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

#pragma mark ---------- 提交 ----------------
- (void)creatConfirmButton {

    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, kScreenWidth, 60);
    self.tableView.tableFooterView = view;
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.backgroundColor = YXBColor_descriptionText;
    [button setTitleColor:YXBColor_descriptionText_light forState:(UIControlStateNormal)];
    [button setTitle:NTVLocalized(@"提交") forState:(UIControlStateNormal)];
    button.layer.cornerRadius = 4;
    [view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.bottom.mas_equalTo(-8);
        make.top.mas_equalTo(8);
    }];
    [button addTarget:self action:@selector(confirmAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)confirmAction:(UIButton *)button {
    XLFormRowDescriptor *userDescrip = [self.form formRowWithTag:@"1"];
    XLFormRowDescriptor *bankNumberDescrip = [self.form formRowWithTag:@"2"];
    XLFormRowDescriptor *bankDescrip = [self.form formRowWithTag:@"3"];
    XLFormRowDescriptor *addressDescrip = [self.form formRowWithTag:@"4"];
    
    if (userDescrip.value == nil) {
        NSString *toastStr = NTVLocalized(@"请输入手机号码");
        ShowToast(toastStr);
        return;
    }
    
    if (bankNumberDescrip.value == nil) {
        NSString *toastStr = NTVLocalized(@"请输入新密码");
        ShowToast(toastStr);
        return;
    }
    
    if (bankDescrip.value == nil) {
        NSString *toastStr = NTVLocalized(@"请输入确认密码");
        ShowToast(toastStr);
        return;
    }
    
    if (![bankNumberDescrip.value isEqualToString:bankDescrip.value]) {
        NSString *toastStr = NTVLocalized(@"新密码与确认密码不一致");
        ShowToast(toastStr);
        return;
    }
    
    if (addressDescrip.value == nil) {
        NSString *toastStr = NTVLocalized(@"请输入短信验证码");
        ShowToast(toastStr);
        return;
    }
    
    ForgetPassAPI *network = [[ForgetPassAPI alloc] initWithAccount:userDescrip.value password:bankDescrip.value code:addressDescrip.value];
    [network startWithCompletionBlockWithSuccess:^(__kindof ForgetPassAPI * _Nonnull request) {
        if ([request isValidRequestData]) {
            NSString *toastStr = NTVLocalized(@"找回密码成功,请重新登录");
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
