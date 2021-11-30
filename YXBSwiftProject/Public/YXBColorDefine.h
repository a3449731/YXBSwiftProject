//
//  YXBColorDefine.h
//  MyProject
//
//  Created by YangXiaoBin on 2019/11/11.
//  Copyright © 2019 YangXiaoBin. All rights reserved.
//

#ifndef YXBColorDefine_h
#define YXBColorDefine_h

#import <UIKit/UIKit.h>

#define YXBThemeImage(imageName) [YXBThemeManager.sharedInstance themeImage:imageName]
#define YXBThemeImageName(imageName) [YXBThemeManager.sharedInstance themeImageName:imageName]

///color
#define RGBColor(r,g,b)         [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBAColor(r,g,b,a)      [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define UIColorFromHex(hex)  RGBAColorWithHEXString(@#hex, 1.0f)
#define UIImageFromHex(hex)  UIImageWithColor(UIColorFromHex(hex))


#define YXBColor_background                     YXBThemeManager.sharedInstance.backgroundColor
#define YXBColor_background_light               YXBThemeManager.sharedInstance.backgroundColor_light
#define YXBColor_background_highLight           YXBThemeManager.sharedInstance.backgroundColor_HighLight

#define YXBColor_tint                           YXBThemeManager.sharedInstance.tintColor
#define YXBColor_tint_light                     YXBThemeManager.sharedInstance.tintColor_light
#define YXBColor_tint_highLight                 YXBThemeManager.sharedInstance.tintColor_HighLight

#define YXBColor_titleText                      YXBThemeManager.sharedInstance.titleTextColor
#define YXBColor_titleText_light                YXBThemeManager.sharedInstance.titleTextColor_light
#define YXBColor_titleText_highLight            YXBThemeManager.sharedInstance.titleTextColor_HighLight

#define YXBColor_subText                        YXBThemeManager.sharedInstance.subTextColor
#define YXBColor_subText_light                  YXBThemeManager.sharedInstance.subTextColor_light
#define YXBColor_subText_highLight              YXBThemeManager.sharedInstance.subTextColor_HighLight

#define YXBColor_descriptionText                YXBThemeManager.sharedInstance.descriptionTextColor
#define YXBColor_descriptionText_light          YXBThemeManager.sharedInstance.descriptionTextColor_light
#define YXBColor_descriptionText_highLight      YXBThemeManager.sharedInstance.descriptionTextColor_HighLight

#define YXBColor_tipText                        YXBThemeManager.sharedInstance.tipTextColor
#define YXBColor_tipText_light                  YXBThemeManager.sharedInstance.tipTextColor_light
#define YXBColor_tipText_highLight              YXBThemeManager.sharedInstance.tipTextColor_HighLight

#define YXBColor_placeholder                    YXBThemeManager.sharedInstance.placeholderColor
#define YXBColor_placeholder_light              YXBThemeManager.sharedInstance.placeholderColor_light
#define YXBColor_placeholder_highLight          YXBThemeManager.sharedInstance.placeholderColor_HighLight

#define YXBColor_separator                      YXBThemeManager.sharedInstance.separatorColor
#define YXBColor_separator_light                YXBThemeManager.sharedInstance.separatorColor_light
#define YXBColor_separator_highLight            YXBThemeManager.sharedInstance.separatorColor_HighLight


//颜色转换图片
NS_INLINE UIImage *UIImageWithColor(UIColor *color) {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

//字符串转颜色
NS_INLINE UIColor *RGBAColorWithHEXString(NSString *hexString, CGFloat alpha) {
    hexString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    UIColor *defaultColor = [UIColor clearColor];
    
    if (hexString.length < 6) return defaultColor;
    if ([hexString hasPrefix:@"#"]) hexString = [hexString substringFromIndex:1];
    if ([hexString hasPrefix:@"0X"]) hexString = [hexString substringFromIndex:2];
    if (hexString.length != 6) return defaultColor;
    
    //method1
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    unsigned int hexNumber;
    if (![scanner scanHexInt:&hexNumber]) return defaultColor;
    
//    //method2
//    const char *char_str = [hexString cStringUsingEncoding:NSASCIIStringEncoding];
//    int hexNum;
//    sscanf(char_str, "%x", &hexNum);
    
    if (hexNumber > 0xFFFFFF) return defaultColor;
    
    CGFloat red   = ((hexNumber >> 16) & 0xFF);
    CGFloat green = ((hexNumber >> 8) & 0xFF);
    CGFloat blue  = (hexNumber & 0xFF);
    
    return RGBAColor(red, green, blue, alpha);
}


#endif /* YXBColorDefine_h */


