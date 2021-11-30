//
//  YXBThemeProtocol.h
//  MyProject
//
//  Created by YangXiaoBin on 2020/6/11.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 所有主题均应实现 <QMUIConfigurationTemplateProtocol> 这个协议，规定了 QMUI Demo 里常用的几个关键外观属性,
// 由于想使用 QMUI的全局配置表,所以对主题类的命名 必须包含"QMUIConfigurationTemplate",  因为在QMUIConfiguration.m中的applyInitialTemplate方法 对类名进行了判断。响应了这个shouldApplyTemplateAutomatically协议方法。
// 如果无需使用 统一配置表，直接遵守<NSObject>协议。
@protocol YXBThemeProtocol <QMUIConfigurationTemplateProtocol>

- (NSString *)themeName;

- (UIColor *)themeBackgroundColor;
- (UIColor *)themeBackgroundColor_light;
- (UIColor *)themeBackgroundColor_HighLight;

- (UIColor *)themeTintColor;
- (UIColor *)themeTintColor_light;
- (UIColor *)themeTintColor_HighLight;

- (UIColor *)themeTitleTextColor;
- (UIColor *)themeTitleTextColor_light;
- (UIColor *)themeTitleTextColor_HighLight;

- (UIColor *)themeSubTextColor;
- (UIColor *)themeSubTextColor_light;
- (UIColor *)themeSubTextColor_HighLight;

- (UIColor *)themeDescriptionTextColor;
- (UIColor *)themeDescriptionTextColor_light;
- (UIColor *)themeDescriptionTextColor_HighLight;

- (UIColor *)themeTipTextColor;
- (UIColor *)themeTipTextColor_light;
- (UIColor *)themeTipTextColor_HighLight;

- (UIColor *)themePlaceholderColor;
- (UIColor *)themePlaceholderColor_light;
- (UIColor *)themePlaceholderColor_HighLight;

- (UIColor *)themeSeparatorColor;
- (UIColor *)themeSeparatorColor_light;
- (UIColor *)themeSeparatorColor_HighLight;

@end

NS_ASSUME_NONNULL_END
