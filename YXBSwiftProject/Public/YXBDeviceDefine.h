//
//  YXBDeviceDefine.h
//  MyProject
//
//  Created by YangXiaoBin on 2019/11/11.
//  Copyright © 2019 YangXiaoBin. All rights reserved.
//

#ifndef YXBDeviceDefine_h
#define YXBDeviceDefine_h

//NSLog(@"\n kSafeAreaTopMargin =%f,\n kSafeAreaBottomMargin = %f,\n kNavigationBarHeight = %f ,\n kStatusBarHeight = %f ,\n kTabbarHeight = %f,\n kStatusBarAndNavigationBarHeight = %f",kSafeAreaTopMargin,kSafeAreaBottomMargin,kNavigationBarHeight,kStatusBarHeight,kTabbarHeight,kStatusBarAndNavigationBarHeight);

//屏幕宽度
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

//屏幕高度
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

// 是否iphoneX
#define kIsIphoneX isIPhoneXSeries()

//  顶部安全区高度
#define kSafeAreaTopMargin SafeAreaTopMargin()

/// 状态栏 + 导航栏  高度
#define kStatusBarAndNavigationBarHeight StatusBarAndNavigationBarHeight()

/// 状态栏高度
#define kStatusBarHeight yxb_StatusBarHeight()

///  导航栏高度
#define kNavigationBarHeight yxb_NavigationBarHeight()

///  tabbar 高度
#define kTabbarHeight TabbarHeight()

///  底部安全区高度
#define kSafeAreaBottomMargin SafeAreaBottomMargin()


// 打印
#ifdef __OBJC__
#ifdef DEBUG
#define YXBLOG(...) NSLog(__VA_ARGS__)
#else
#define YXBLOG(...)
#endif
#endif

#define APP_INFO_DICTIONARY [[NSBundle mainBundle] infoDictionary]
// app版本
#define APP_VERSION [APP_INFO_DICTIONARY objectForKey:@"CFBundleShortVersionString"]

//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]
//检查系统版本
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


/// 是否 刘海屏
NS_INLINE BOOL isIPhoneXSeries() {
    static BOOL isIPhoneX = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([UIScreen instancesRespondToSelector:@selector(currentMode)]) {
            CGSize size = UIScreen.mainScreen.currentMode.size;
            isIPhoneX =
            CGSizeEqualToSize(size, CGSizeMake(1125, 2436)) ||  // X, XS
            CGSizeEqualToSize(size, CGSizeMake(1242, 2688)) ||  // XS Max
            CGSizeEqualToSize(size, CGSizeMake( 828, 1792)) ||  // XR
            CGSizeEqualToSize(size, CGSizeMake(1284, 2778)) ||  // 12 Pro Max
            CGSizeEqualToSize(size, CGSizeMake(1170, 2532)) ||  // 12 Pro, 12
            CGSizeEqualToSize(size, CGSizeMake(1080, 2340));    // 12 mini
        }
    });
    return isIPhoneX;
}

///  顶部安全区高度
//#define  SafeAreaTopMargin   (iPhoneX ? 34.f : 0.f)
NS_INLINE CGFloat SafeAreaTopMargin() {
    static CGFloat m = 0.0;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (isIPhoneXSeries()) {
            m = 44.0;
        }
    });
    return m;
}

///  状态栏 高度
//#define  StatusBarHeight  (iPhoneX ? 44.f : 20.f)
NS_INLINE CGFloat yxb_StatusBarHeight() {
    static CGFloat sbh = 20.0;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (isIPhoneXSeries()) {
            sbh = 44.0;
        }
    });
    return sbh;
}

///  导航栏高度
//#define  NavigationBarHeight    44.f
NS_INLINE CGFloat yxb_NavigationBarHeight() {
    static CGFloat nbh = 44.f;
    return nbh;
}

/// 状态栏 + 导航栏  高度
NS_INLINE CGFloat StatusBarAndNavigationBarHeight() {
    static CGFloat nbh = 64.0;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (isIPhoneXSeries()) {
            nbh = 88.0;
        }
    });
    return nbh;
}

///  tabbar 高度
//#define  TabbarHeight   (iPhoneX ? (83.f) : 49.f)
NS_INLINE CGFloat TabbarHeight() {
    static CGFloat th = 49.0;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (isIPhoneXSeries()) {
            th = 83.0;
        }
    });
    return th;
}

///  底部安全区高度
//#define  SafeAreaBottomMargin   (iPhoneX ? 34.f : 0.f)
NS_INLINE CGFloat SafeAreaBottomMargin() {
    static CGFloat m = 0.0;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (isIPhoneXSeries()) {
            m = 34.0;
        }
    });
    return m;
}

/**
 *  以iPhone6屏幕宽度375与当前设备屏幕宽度的比例来缩放。
 *
 *  @param value 在375宽度下的尺寸。
 *  @return 经缩放后在当前设备上的尺寸。
 */
NS_INLINE CGFloat scaleBase375(CGFloat value) {
    static CGFloat currentWidth = 0;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIInterfaceOrientation o = [UIApplication sharedApplication].statusBarOrientation;
        if (UIInterfaceOrientationIsPortrait(o)) {
            currentWidth = [UIScreen mainScreen].bounds.size.width;
        }else if (UIInterfaceOrientationIsLandscape(o)) {
            currentWidth = [UIScreen mainScreen].bounds.size.width;
        }
    });
    
    if (currentWidth == 0.0 ||
        currentWidth == 375.) {
        return value;
    }
    return value * (currentWidth / 375.);
}

NS_INLINE CGFloat screenWidthScaleBase375() {
    static CGFloat scale = 1;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIInterfaceOrientation o = [UIApplication sharedApplication].statusBarOrientation;
        if (UIInterfaceOrientationIsPortrait(o)) {
            scale = [UIScreen mainScreen].bounds.size.width / 375.;
        }else if (UIInterfaceOrientationIsLandscape(o)) {
            scale = [UIScreen mainScreen].bounds.size.height / 375.;
        }
    });
    return scale;
}

#endif /* YXBDeviceDefine_h */
