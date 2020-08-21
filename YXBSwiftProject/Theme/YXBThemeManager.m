//
//  YXBThemeManager.m
//  MyProject
//
//  Created by YangXiaoBin on 2020/6/11.
//  Copyright © 2020 YangXiaoBin. All rights reserved.
//

#import "YXBThemeManager.h"

NSString *const YXBSelectedThemeIdentifiert = @"selectedThemeIdentifier";
NSString *const YXBThemeIndetifierWhite = @"Common";
NSString *const YXBThemeIndetifierDark = @"Dark";

@interface YXBThemeManager ()

@property(nonatomic, strong) UIColor *backgroundColor;
@property(nonatomic, strong) UIColor *backgroundColor_light;
@property(nonatomic, strong) UIColor *backgroundColor_HighLight;

@property(nonatomic, strong) UIColor *tintColor;
@property(nonatomic, strong) UIColor *tintColor_light;
@property(nonatomic, strong) UIColor *tintColor_HighLight;

@property(nonatomic, strong) UIColor *titleTextColor;
@property(nonatomic, strong) UIColor *titleTextColor_light;
@property(nonatomic, strong) UIColor *titleTextColor_HighLight;

@property(nonatomic, strong) UIColor *subTextColor;
@property(nonatomic, strong) UIColor *subTextColor_light;
@property(nonatomic, strong) UIColor *subTextColor_HighLight;

@property(nonatomic, strong) UIColor *descriptionTextColor;
@property(nonatomic, strong) UIColor *descriptionTextColor_light;
@property(nonatomic, strong) UIColor *descriptionTextColor_HighLight;

@property(nonatomic, strong) UIColor *tipTextColor;
@property(nonatomic, strong) UIColor *tipTextColor_light;
@property(nonatomic, strong) UIColor *tipTextColor_HighLight;

@property(nonatomic, strong) UIColor *placeholderColor;
@property(nonatomic, strong) UIColor *placeholderColor_light;
@property(nonatomic, strong) UIColor *placeholderColor_HighLight;

@property(nonatomic, strong) UIColor *separatorColor;
@property(nonatomic, strong) UIColor *separatorColor_light;
@property(nonatomic, strong) UIColor *separatorColor_HighLight;

@end

@implementation YXBThemeManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static YXBThemeManager *instance = nil;
    dispatch_once(&onceToken,^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self creatBackgroundColor];
        [self creatTintColor];
        [self creatTextColor];
        [self creatSubTextColor];
        [self creatDescriptionTextColor];
        [self creatTipTextColor];
        [self creatPlaceholderColor];
        [self creatSeparatorColor];
    }
    return self;
}

- (NSObject<YXBThemeProtocol> *)currentTheme {
    return QMUIThemeManagerCenter.defaultThemeManager.currentTheme;
}

- (NSString *)currentThemeIdentifier {
    return QMUIThemeManagerCenter.defaultThemeManager.currentThemeIdentifier;
}

/// QMUIThemeManagerCenter.defaultThemeManager.currentThemeIdentifier = @"Dark";// 切换到名为 Dark 的主题
// 或 QMUIThemeManagerCenter.defaultThemeManager.currentTheme = darkTheme;// 切换到 darkTheme 主题对象
// 可通过修改 QMUIThemeManager 的 currentThemeIdentifier、currentTheme 属性来切换当前 App 的主题，修改这两个属性的其中一个属性，内部都会同时自动修改另外一个属性，以保证两者匹配。
- (void)setCurrentThemeIdentifier:(NSString *)currentThemeIdentifier {
    QMUIThemeManagerCenter.defaultThemeManager.currentThemeIdentifier = currentThemeIdentifier;
}

#pragma mark ------------- 取色 --------------------
// 实质上的颜色配置 再每个主题中单独配置。

- (void)creatBackgroundColor {
    self.backgroundColor = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, __kindof NSObject<YXBThemeProtocol> * _Nullable theme) {
        UIColor *color = theme.themeBackgroundColor;
        return color;
    }];
    
    self.backgroundColor_light = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, __kindof NSObject<YXBThemeProtocol> * _Nullable theme) {
        UIColor *color = theme.themeBackgroundColor_light;
        return color;
    }];
    
    self.backgroundColor_HighLight = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, __kindof NSObject<YXBThemeProtocol> * _Nullable theme) {
        UIColor *color = theme.themeBackgroundColor_HighLight;
        return color;
    }];
}

- (void)creatTintColor {
    self.tintColor = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, __kindof NSObject<YXBThemeProtocol> * _Nullable theme) {
        UIColor *color = theme.themeTintColor;
        return color;
    }];
    
    self.tintColor_light = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, __kindof NSObject<YXBThemeProtocol> * _Nullable theme) {
        UIColor *color = theme.themeTintColor_light;
        return color;
    }];
    
    self.tintColor_HighLight = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, __kindof NSObject<YXBThemeProtocol> * _Nullable theme) {
        UIColor *color = theme.themeTintColor_HighLight;
        return color;
    }];
}

- (void)creatTextColor {
    self.titleTextColor = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, __kindof NSObject<YXBThemeProtocol> * _Nullable theme) {
        UIColor *color = theme.themeTitleTextColor;
        return color;
    }];
    
    self.titleTextColor_light = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, __kindof NSObject<YXBThemeProtocol> * _Nullable theme) {
        UIColor *color = theme.themeTitleTextColor_light;
        return color;
    }];
    
    self.titleTextColor_HighLight = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, __kindof NSObject<YXBThemeProtocol> * _Nullable theme) {
        UIColor *color = theme.themeTitleTextColor_HighLight;
        return color;
    }];
}

- (void)creatSubTextColor {
    self.subTextColor = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, __kindof NSObject<YXBThemeProtocol> * _Nullable theme) {
        UIColor *color = theme.themeSubTextColor;
        return color;
    }];
    
    self.subTextColor_light = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, __kindof NSObject<YXBThemeProtocol> * _Nullable theme) {
        UIColor *color = theme.themeSubTextColor_light;
        return color;
    }];
    
    self.subTextColor_HighLight = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, __kindof NSObject<YXBThemeProtocol> * _Nullable theme) {
        UIColor *color = theme.themeSubTextColor_HighLight;
        return color;
    }];
}

- (void)creatDescriptionTextColor {
    self.descriptionTextColor = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, __kindof NSObject<YXBThemeProtocol> * _Nullable theme) {
        UIColor *color = theme.themeDescriptionTextColor;
        return color;
    }];
    
    self.descriptionTextColor_light = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, __kindof NSObject<YXBThemeProtocol> * _Nullable theme) {
        UIColor *color = theme.themeDescriptionTextColor_light;
        return color;
    }];
    
    self.descriptionTextColor_HighLight = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, __kindof NSObject<YXBThemeProtocol> * _Nullable theme) {
        UIColor *color = theme.themeDescriptionTextColor_HighLight;
        return color;
    }];
}

- (void)creatTipTextColor {
    self.tipTextColor = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, __kindof NSObject<YXBThemeProtocol> * _Nullable theme) {
        UIColor *color = theme.themeTipTextColor;
        return color;
    }];
    
    self.tipTextColor_light = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, __kindof NSObject<YXBThemeProtocol> * _Nullable theme) {
        UIColor *color = theme.themeTipTextColor_light;
        return color;
    }];
    
    self.tipTextColor_HighLight = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, __kindof NSObject<YXBThemeProtocol> * _Nullable theme) {
        UIColor *color = theme.themeTipTextColor_HighLight;
        return color;
    }];
}

- (void)creatPlaceholderColor {
    self.placeholderColor = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, __kindof NSObject<YXBThemeProtocol> * _Nullable theme) {
        UIColor *color = theme.themePlaceholderColor;
        return color;
    }];
    
    self.placeholderColor_light = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, __kindof NSObject<YXBThemeProtocol> * _Nullable theme) {
        UIColor *color = theme.themePlaceholderColor_light;
        return color;
    }];
    
    self.placeholderColor_HighLight = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, __kindof NSObject<YXBThemeProtocol> * _Nullable theme) {
        UIColor *color = theme.themePlaceholderColor_HighLight;
        return color;
    }];
}

- (void)creatSeparatorColor {
    self.separatorColor = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, __kindof NSObject<YXBThemeProtocol> * _Nullable theme) {
        UIColor *color = theme.themeSeparatorColor;
        return color;
    }];
    
    self.separatorColor_light = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, __kindof NSObject<YXBThemeProtocol> * _Nullable theme) {
        UIColor *color = theme.themeSeparatorColor_light;
        return color;
    }];
    
    self.separatorColor_HighLight = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, __kindof NSObject<YXBThemeProtocol> * _Nullable theme) {
        UIColor *color = theme.themeSeparatorColor_HighLight;
        return color;
    }];
}

- (UIImage *)themeImage:(NSString *)imageName {
    // 用来判断主题，链信没有引入主题框架，所以就这么判断了。
    UIImage *backImage = nil;
    if ([self.currentThemeIdentifier isEqualToString:YXBThemeIndetifierWhite]) {
        NSString *newName = [imageName stringByAppendingString:@"_themeWhite"];
        backImage = [UIImage imageNamed:newName];
    }
    
    if ([self.currentThemeIdentifier isEqualToString:YXBThemeIndetifierDark]) {
        NSString *newName = [imageName stringByAppendingString:@"_themeDark"];
        backImage = [UIImage imageNamed:newName];
    }
    
    // 如果不存在主题图片 就取默认图片。
    if (backImage == nil) {
        backImage = [UIImage imageNamed:imageName];
    }
    
    // 还是没图就去他妈的.
    return backImage;
}

- (NSString *)themeImageName:(NSString *)imageName {
    // 用来判断主题，链信没有引入主题框架，所以就这么判断了。
    NSString *backImageName = nil;
    if ([self.currentThemeIdentifier isEqualToString:YXBThemeIndetifierWhite]) {
        backImageName = [imageName stringByAppendingString:@"_themeWhite"];
    }
    
    if (([self.currentThemeIdentifier isEqualToString:YXBThemeIndetifierDark])) {
        backImageName = [imageName stringByAppendingString:@"_themeDark"];
    }
    
    // 如果不存在主题图片 就取默认图片。
    if (backImageName == nil) {
        backImageName = imageName;
    }
    
    // 还是没图就去他妈的.
    return backImageName;
}


@end
