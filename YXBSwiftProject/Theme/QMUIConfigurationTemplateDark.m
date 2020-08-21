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
    QMUICMI.tabBarShadowImageColor = YXBColor_separator;
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
    return [UIColor qmui_colorWithHexString:@"#091024"]; // 黑
}
- (UIColor *)themeBackgroundColor_light {
    return [UIColor qmui_colorWithHexString:@"#131D35"]; // 臧黑
}
- (UIColor *)themeBackgroundColor_HighLight {
    return [UIColor qmui_colorWithHexString:@"#1A2338"]; // 浅黑
}


- (UIColor *)themeTintColor {
    return [UIColor qmui_colorWithHexString:@"#D14B64"]; // 红
}
- (UIColor *)themeTintColor_light {
    return [UIColor qmui_colorWithHexString:@"#213052"]; // 蓝黑
}
- (UIColor *)themeTintColor_HighLight {
    return [UIColor qmui_colorWithHexString:@"#F3F3F3"];
}

- (UIColor *)themeTitleTextColor {
    return [UIColor qmui_colorWithHexString:@"#FFFFFF"];
}
- (UIColor *)themeTitleTextColor_light {
    return [UIColor qmui_colorWithHexString:@"#CCCCCC"];
}
- (UIColor *)themeTitleTextColor_HighLight {
    return [UIColor qmui_colorWithHexString:@"#F9C100"]; // 黄
}

- (UIColor *)themeSubTextColor {
    return [UIColor qmui_colorWithHexString:@"#7E93A8"]; // 灰
}
- (UIColor *)themeSubTextColor_light {
    return [UIColor qmui_colorWithHexString:@"#545D78"]; // 灰
}
- (UIColor *)themeSubTextColor_HighLight {
    return [UIColor qmui_colorWithHexString:@"#CCCCCC"]; // 灰
}

- (UIColor *)themeDescriptionTextColor {
    return [UIColor qmui_colorWithHexString:@"#0BC2C0"]; // 青色
}
- (UIColor *)themeDescriptionTextColor_light {
    return [UIColor qmui_colorWithHexString:@"#12D7D5"]; // 青
}
- (UIColor *)themeDescriptionTextColor_HighLight {
    return [UIColor qmui_colorWithHexString:@"#333333"]; // 黑色
}

- (UIColor *)themeTipTextColor {
    return [UIColor redColor];
}
- (UIColor *)themeTipTextColor_light {
    return [UIColor redColor];
}
- (UIColor *)themeTipTextColor_HighLight {
    return [UIColor redColor];
}

- (UIColor *)themePlaceholderColor {
    return [UIColor qmui_colorWithHexString:@"#5E6F82"];
}
- (UIColor *)themePlaceholderColor_light {
    return [UIColor redColor];
}
- (UIColor *)themePlaceholderColor_HighLight {
    return [UIColor redColor];
}

- (UIColor *)themeSeparatorColor {
    return [UIColor qmui_colorWithHexString:@"#455270"];
}
- (UIColor *)themeSeparatorColor_light {
    return [UIColor qmui_colorWithHexString:@"#2C3750"];
}
- (UIColor *)themeSeparatorColor_HighLight {
    return [UIColor qmui_colorWithHexString:@"#495571"]; // 灰白 边框
}

@end
