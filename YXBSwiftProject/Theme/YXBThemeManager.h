//
//  YXBThemeManager.h
//  MyProject
//
//  Created by YangXiaoBin on 2020/6/11.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YXBThemeProtocol.h"

NS_ASSUME_NONNULL_BEGIN
// 不要使用default作为标识，已经被QMUITheme中使用了。
//NSString *const QMUIThemeManagerNameDefault = @"Default";
extern NSString *const YXBSelectedThemeIdentifiert;
extern NSString *const YXBThemeIndetifierWhite;
extern NSString *const YXBThemeIndetifierDark;

/**
主题管理组件，可添加自定义的主题对象，并为每个对象指定一个专门的 identifier，当主题发生变化时，会遍历 UIViewController 和 UIView，调用每个 viewController 和每个可视 view 的 qmui_themeDidChangeByManager:identifier:theme: 方法，在里面由业务去自行根据当前主题设置不同的外观（color、image 等）。借助 QMUIThemeManagerCenter，可实现一个项目里同时存在多个维度的主题（例如全局维度存在 light/dark 2套主题，局部的某个界面存在 white/yellow/green/black 4套主题），各自互不影响，如果业务项目只需要一个维度的主题，则全都使用 QMUIThemeManagerCenter.defaultThemeManager 来获取 QMUIThemeManager 即可，如果业务有多维度主题的需求，可使用 +[QMUIThemeManagerCenter themeManagerWithName:] 生成不同的 QMUIThemeManager。

详细文档请查看 GitHub Wiki
@link https://github.com/Tencent/QMUI_iOS/wiki/%E4%BD%BF%E7%94%A8-QMUITheme-%E5%AE%9E%E7%8E%B0%E6%8D%A2%E8%82%A4%E5%B9%B6%E9%80%82%E9%85%8D-iOS-13-Dark-Mode

 标准场景下的使用流程：
 1.将AppDelegate+YXBTheme中的initYXBThemeConfig方法在  AppDelegate.m中初始化即可.
 2.若需要添加 新的主题模式. 创建QMUIConfigurationTemplate的子类。 且类命名要求包含QMUIConfigurationTemplate。 例QMUIConfigurationTemplateGrass.h
 3.为主题添加一个唯一标识. 在AppDelegate+YXBTheme.m中 添加新的主题.
 @code
 QMUIThemeManagerCenter.defaultThemeManager.themeGenerator = ^__kindof NSObject * _Nonnull(NSString * _Nonnull identifier) {
     if ([identifier isEqualToString:QMUIThemeManagerNameDefault]) return [QMUIConfigurationTemplate new];
     if ([identifier isEqualToString:YXBThemeIndetifierWhite]) return [QMUIConfigurationTemplateWhite new];
     if ([identifier isEqualToString:YXBThemeIndetifierDark]) return [QMUIConfigurationTemplateDark new];
     return nil;
 };
 @endcode
 
 4.切换主题.做了本地化存储。主题的加载在shouldApplyTemplateAutomatically方法中,自动调用此方法，主题的类名必须包含QMUIConfigurationTemplate。理由见YXBThemeProtocol.h。
 @code
 [YXBThemeManager sharedInstance].currentThemeIdentifier = YXBThemeIndetifierDark;
 @endcode
*/

@interface YXBThemeManager : NSObject

+ (instancetype)sharedInstance;

@property(nonatomic, readonly, nullable) NSObject<YXBThemeProtocol> *currentTheme;
// 切换主题。
@property(nonatomic, copy, readwrite) NSString *currentThemeIdentifier;


@property(nonatomic, strong, readonly) UIColor *backgroundColor;
@property(nonatomic, strong, readonly) UIColor *backgroundColor_light;
@property(nonatomic, strong, readonly) UIColor *backgroundColor_HighLight;

@property(nonatomic, strong, readonly) UIColor *tintColor;
@property(nonatomic, strong, readonly) UIColor *tintColor_light;
@property(nonatomic, strong, readonly) UIColor *tintColor_HighLight;

@property(nonatomic, strong, readonly) UIColor *titleTextColor;
@property(nonatomic, strong, readonly) UIColor *titleTextColor_light;
@property(nonatomic, strong, readonly) UIColor *titleTextColor_HighLight;

@property(nonatomic, strong, readonly) UIColor *subTextColor;
@property(nonatomic, strong, readonly) UIColor *subTextColor_light;
@property(nonatomic, strong, readonly) UIColor *subTextColor_HighLight;

@property(nonatomic, strong, readonly) UIColor *descriptionTextColor;
@property(nonatomic, strong, readonly) UIColor *descriptionTextColor_light;
@property(nonatomic, strong, readonly) UIColor *descriptionTextColor_HighLight;

@property(nonatomic, strong, readonly) UIColor *tipTextColor;
@property(nonatomic, strong, readonly) UIColor *tipTextColor_light;
@property(nonatomic, strong, readonly) UIColor *tipTextColor_HighLight;

@property(nonatomic, strong, readonly) UIColor *placeholderColor;
@property(nonatomic, strong, readonly) UIColor *placeholderColor_light;
@property(nonatomic, strong, readonly) UIColor *placeholderColor_HighLight;

@property(nonatomic, strong, readonly) UIColor *separatorColor;
@property(nonatomic, strong, readonly) UIColor *separatorColor_light;
@property(nonatomic, strong, readonly) UIColor *separatorColor_HighLight;

- (UIImage *)themeImage:(NSString *)imageName;

- (NSString *)themeImageName:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
