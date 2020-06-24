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

///color
#define RGBColor(r,g,b)         [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBAColor(r,g,b,a)      [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define UIColorFromHex(hex)  RGBAColorWithHEXString(@#hex, 1.0f)
#define UIImageFromHex(hex)  UIImageWithColor(UIColorFromHex(hex))

// 背景_灰
#define YXBColorBG_gray UIColorFromHex(#F3F3F3)

// 背景_白
#define YXBColorBG_white UIColorFromHex(#FFFFFF)

// 背景_黑
#define YXBColorBG_Black UIColorFromHex(#1E2528)

// 黑色字体
#define YXBColorBlack UIColorFromHex(#333333)

// 灰色字体
#define YXBColorGray UIColorFromHex(#A5A7BA)

// 灰色字体
#define YXBColorGray_999 UIColorFromHex(#999999)

// 白色字体
#define YXBColorWhite UIColorFromHex(#FFFFFF)

// 蓝色字体
#define YXBColorBlue UIColorFromHex(#418efb)

// 红色字体
#define YXBColorRed UIColorFromHex(#FF5551)

// 绿色字体
#define YXBColorGreen UIColorFromHex(#03D598)

// 橙色
#define YXBColorOrange UIColorFromHex(#F8B34B)


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


