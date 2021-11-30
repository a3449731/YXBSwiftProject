//
//  PSSLoginPassViewController.m
//  MyProject
//
//  Created by 杨 on 18/1/2020.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "PSSLoginPassViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "YXBFormTopBottomCell.h"
#import "YXBFormLeftRightCell.h"
#import "ModifyLoginPassAPI.h"
#import <QMUIKit/QMUIAlertController.h>
#import <QMUIKit/QMUIDialogViewController.h>
#import <QMUIKit/QMUITextField.h>
#import "PopDXCaptchaView.h"
#import "MessageAPI.h"
#import "UIButton+YXBAdd.h"
#import "UIColor+YXBGradient.h"

@interface PSSLoginPassViewController ()

@end

@implementation PSSLoginPassViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self setupTool];
    [self setupData];
}

AC_SETUP_NAVIGATION_ITEM(NTVLocalized(@"修改登录密码"));

- (void)setupUI {
    self.view.backgroundColor = YXBColor_background;
    [self setupNavigationItem];
    [self creatTableView];
    UIView *footerView = [self creatConfirmButton];
//    self.tableView.tableFooterView = footerView;
    [self.view addSubview:footerView];
    [footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-kSafeAreaBottomMargin);
        make.height.mas_equalTo(55);
    }];
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
    row.height = 60;
    row.title = NTVLocalized(@"手机号");
    [row.cellConfig setObject:YXBColor_background_light forKey:@"backgroundColor"];
    [row.cellConfig setObject:YXBColor_titleText forKey:@"titleLabel.textColor"];
    [row.cellConfig setObject:YXBColor_placeholder forKey:@"textField.placeholderColor"];
    [row.cellConfig setObject:YXBColor_titleText forKey:@"textField.textColor"];
    [row.cellConfig setObject:NTVLocalized(@"请输入手机号") forKey:@"textField.placeholder"];
//    [row.cellConfig setObject:@(YES) forKey:@"textField.secureTextEntry"];
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"oldPass" rowType:YXBFormRowDescriptorTypeLeftRightCell];
    row.height = 60;
    row.title = NTVLocalized(@"旧密码");
    [row.cellConfig setObject:YXBColor_background_light forKey:@"backgroundColor"];
    [row.cellConfig setObject:YXBColor_titleText forKey:@"titleLabel.textColor"];
    [row.cellConfig setObject:YXBColor_placeholder forKey:@"textField.placeholderColor"];
    [row.cellConfig setObject:YXBColor_titleText forKey:@"textField.textColor"];
    [row.cellConfig setObject:NTVLocalized(@"请输入旧密码") forKey:@"textField.placeholder"];
    [row.cellConfig setObject:@(YES) forKey:@"textField.secureTextEntry"];
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"4" rowType:YXBFormRowDescriptorTypeLeftRightCell];
    row.height = 60;
    row.title = NTVLocalized(@"验证码");
    [row.cellConfig setObject:YXBColor_background_light forKey:@"backgroundColor"];
    [row.cellConfig setObject:YXBColor_titleText forKey:@"titleLabel.textColor"];
    [row.cellConfig setObject:YXBColor_placeholder forKey:@"textField.placeholderColor"];
    [row.cellConfig setObject:YXBColor_titleText forKey:@"textField.textColor"];
    [row.cellConfig setObject:NTVLocalized(@"请输入短信验证码") forKey:@"textField.placeholder"];
    [row.cellConfig setObject:@(UIKeyboardTypeNumberPad) forKey:@"keyboardType"];
    // 右视图
    [row.cellConfig setObject:@(UITextFieldViewModeAlways) forKey:@"textField.rightViewMode"];
    [row.cellConfig setObject:[self creatCodeButton] forKey:@"textField.rightView"];
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"2" rowType:YXBFormRowDescriptorTypeLeftRightCell];
    row.height = 60;
    row.title = NTVLocalized(@"新密码");
    [row.cellConfig setObject:YXBColor_background_light forKey:@"backgroundColor"];
    [row.cellConfig setObject:YXBColor_titleText forKey:@"titleLabel.textColor"];
    [row.cellConfig setObject:YXBColor_placeholder forKey:@"textField.placeholderColor"];
    [row.cellConfig setObject:YXBColor_titleText forKey:@"textField.textColor"];
    [row.cellConfig setObject:NTVLocalized(@"请输入新密码") forKey:@"textField.placeholder"];
    [row.cellConfig setObject:@(YES) forKey:@"textField.secureTextEntry"];
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"3" rowType:YXBFormRowDescriptorTypeLeftRightCell];
    row.height = 60;
    row.title = NTVLocalized(@"确认密码");
    [row.cellConfig setObject:YXBColor_background_light forKey:@"backgroundColor"];
    [row.cellConfig setObject:YXBColor_titleText forKey:@"titleLabel.textColor"];
    [row.cellConfig setObject:YXBColor_placeholder forKey:@"textField.placeholderColor"];
    [row.cellConfig setObject:YXBColor_titleText forKey:@"textField.textColor"];
    [row.cellConfig setObject:NTVLocalized(@"请再次输入密码") forKey:@"textField.placeholder"];
    [row.cellConfig setObject:@(YES) forKey:@"textField.secureTextEntry"];
    [section addFormRow:row];
    
    
    
    [form addFormSection:section];
    
    self.form = form;
    
    self.tableView.backgroundColor = YXBColor_background;
    self.tableView.separatorColor = YXBColor_separator;
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
    
    PopDXCaptchaView * captchaView = [PopDXCaptchaView createPopDXCaptchaView];
    MJWeakSelf
    [captchaView setPopDXCaptchaViewSuccess:^(NSString * _Nonnull token) {
        [weakSelf DXCaptchaEventSuccess:token andBtn:button];
    }];
    [captchaView show];
    
//    [self DXCaptchaEventSuccess:@"" andBtn:button];
}

-(void)DXCaptchaEventSuccess:(NSString *)token andBtn:(UIButton *)btn{
    XLFormRowDescriptor *userDescrip = [self.form formRowWithTag:@"1"];
    if (userDescrip.value == nil) {
        NSString *toastStr = NTVLocalized(@"请输入手机号");
        ShowToast(toastStr);
        return;
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    MemberModel *model = [UserManager sharedManager].memberInfo;
    MessageAPI *network = [[MessageAPI alloc] initWithPhone:userDescrip.value smsType:@"3" authToken:token];
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
- (UIView *)creatConfirmButton {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    view.frame = CGRectMake(0, 0, kScreenWidth, 60);
//    [self.view addSubview:view];
//    [view mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.mas_equalTo(0);
//        make.bottom.mas_equalTo(-70 - kSafeAreaBottomMargin);
//        make.height.mas_equalTo(60);
//    }];

    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.layer.cornerRadius = 25;
    button.layer.masksToBounds = YES;
//    button.backgroundColor = YXBColor_descriptionText;
    button.backgroundColor =  YXBColor_tint;
    [button setTitleColor:YXBColor_descriptionText_light forState:(UIControlStateNormal)];
    [button setTitle:NTVLocalized(@"提交") forState:(UIControlStateNormal)];
//    button.layer.cornerRadius = 4;
    [view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(50);
        make.centerY.mas_equalTo(0);
    }];
    [button addTarget:self action:@selector(confirmAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    return view;
}

- (void)confirmAction:(UIButton *)button {
    XLFormRowDescriptor *userDescrip = [self.form formRowWithTag:@"1"];
    XLFormRowDescriptor *bankNumberDescrip = [self.form formRowWithTag:@"2"];
    XLFormRowDescriptor *bankDescrip = [self.form formRowWithTag:@"3"];
    XLFormRowDescriptor *addressDescrip = [self.form formRowWithTag:@"4"];
    XLFormRowDescriptor *oldPassDescrip = [self.form formRowWithTag:@"oldPass"];
    
    if (userDescrip.value == nil) {
        NSString *toastStr = NTVLocalized(@"请输入手机号");
        ShowToast(toastStr);
        return;
    }
    
    if (oldPassDescrip.value == nil) {
        NSString *toastStr = NTVLocalized(@"请输入旧密码");
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
    
    ModifyLoginPassAPI *network = [[ModifyLoginPassAPI alloc] initWithOldPass:oldPassDescrip.value newsPass:bankNumberDescrip.value code:addressDescrip.value];
    [network startWithCompletionBlockWithSuccess:^(__kindof ModifyLoginPassAPI * _Nonnull request) {
        if ([request isValidRequestData]) {
            NSString *toastStr = NTVLocalized(@"修改成功,请重新登录");
            ShowToast(toastStr);
            [[UserManager sharedManager] logoutApp];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
