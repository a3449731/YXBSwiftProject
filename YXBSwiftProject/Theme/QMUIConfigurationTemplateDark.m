//
//  QMUIConfigurationTemplateDark.m
//  MyProject
//
//  Created by YangXiaoBin on 2020/6/12.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "QMUIConfigurationTemplateDark.h"

@implementation QMUIConfigurationTemplateDark

/// 应用配置表的设置
- (void)applyConfigurationTemplate {
    [super applyConfigurationTemplate];
    
    QMUICMI.keyboardAppearance = UIKeyboardAppearanceDark;
    
    QMUICMI.navBarBackgroundImage = nil;
    QMUICMI.navBarStyle = UIBarStyleBlack;
    
    QMUICMI.tabBarBackgroundImage = nil;
    QMUICMI.tabBarStyle = UIBarStyleBlack;
    
    QMUICMI.toolBarStyle = UIBarStyleBlack;
}

- (BOOL)shouldApplyTemplateAutomatically {
    // 在这里 将主题以及identifier 添加到  QMUI的主题管理去
    [QMUIThemeManagerCenter.defaultThemeManager addThemeIdentifier:self.themeName theme:self];
    NSString *selectedThemeIdentifier = [[NSUserDefaults standardUserDefaults] stringForKey:YXBSelectedThemeIdentifiert];
    BOOL result = [selectedThemeIdentifier isEqualToString:self.themeName] || (!selectedThemeIdentifier && !QMUIThemeManagerCenter.defaultThemeManager.currentThemeIdentifier);
    if (result) {
        QMUIThemeManagerCenter.defaultThemeManager.currentTheme = self;
    }
    return result;
}

- (NSString *)themeName {
    return YXBThemeIndetifierDark;
}

- (UIColor *)themeBackgroundColor {
    return [UIColor qmui_colorWithHexString:@"#121725"];
}

- (UIColor *)themeTitleTextColor {
    return [UIColor qmui_colorWithHexString:@"#FFFFFF"];
}

@end
