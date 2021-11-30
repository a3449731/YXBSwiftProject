//
//  QMUIConfigurationTemplateWhite.m
//  MyProject
//
//  Created by YangXiaoBin on 2020/6/12.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "QMUIConfigurationTemplateWhite.h"

@implementation QMUIConfigurationTemplateWhite

/// 应用配置表的设置
- (void)applyConfigurationTemplate {
    [super applyConfigurationTemplate];
    
    QMUICMI.keyboardAppearance = UIKeyboardAppearanceDark;
    
    QMUICMI.navBarBackgroundImage = nil;
    QMUICMI.navBarStyle = UIBarStyleDefault;
    
    QMUICMI.tabBarBackgroundImage = nil;
    QMUICMI.tabBarStyle = UIBarStyleDefault;
    
    QMUICMI.toolBarStyle = UIBarStyleDefault;
    
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
    return YXBThemeIndetifierWhite;
}

- (UIColor *)themeBackgroundColor {
    return [UIColor qmui_colorWithHexString:@"#FFFFFF"];
}

- (UIColor *)themeTitleTextColor {
    return [UIColor qmui_colorWithHexString:@"#333333"];
}

//- (UIColor *)themeBackgroundColor {
//    return [UIColor redColor];
//}
//- (UIColor *)themeBackgroundColor_light {
//
//}
//- (UIColor *)themeBackgroundColor_HighLight {
//
//}
//
//
//- (UIColor *)themeTintColor {
//
//}
//- (UIColor *)themeTintColor_light {
//
//}
//- (UIColor *)themeTintColor_HighLight {
//
//}
//
//- (UIColor *)themeTitleTextColor {
//
//}
//- (UIColor *)themeTitleTextColor_light {
//
//}
//- (UIColor *)themeTitleTextColor_HighLight {
//
//}
//
//- (UIColor *)themeSubTextColor {
//
//}
//- (UIColor *)themeSubTextColor_light {
//
//}
//- (UIColor *)themeSubTextColor_HighLight {
//
//}
//
//- (UIColor *)themeDescriptionTextColor {
//
//}
//- (UIColor *)themeDescriptionTextColor_light {
//
//}
//- (UIColor *)themeDescriptionTextColor_HighLight {
//
//}
//
//- (UIColor *)themeTipTextColor {
//
//}
//- (UIColor *)themeTipTextColor_light {
//
//}
//- (UIColor *)themeTipTextColor_HighLight {
//
//}
//
//- (UIColor *)themePlaceholderColor {
//
//}
//- (UIColor *)themePlaceholderColor_light {
//
//}
//- (UIColor *)themePlaceholderColor_HighLight {
//
//}
//
//- (UIColor *)themeSeparatorColor {
//
//}
//- (UIColor *)themeSeparatorColor_light {
//
//}
//- (UIColor *)themeSeparatorColor_HighLight {
//
//}

@end
