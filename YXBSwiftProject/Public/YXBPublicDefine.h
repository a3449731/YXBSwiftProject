//
//  YXBPublicDefine.h
//  MyProject
//
//  Created by YangXiaoBin on 2019/11/17.
//  Copyright © 2019 YangXiaoBin. All rights reserved.
//

#ifndef YXBPublicDefine_h
#define YXBPublicDefine_h

#import <Toast/UIView+Toast.h>
#import <UIImage+QMUI.h>
#import "NSObject+YXBAdd.h"
#import "YXBConstDefine.h"

#define ShowToast(msg) [[UIApplication sharedApplication].keyWindow makeToast:msg duration:(MIN(5, MAX(0, msg.length * 0.06 + 0.5))) position:CSToastPositionCenter];


/// 修补字符串 小数位
/// @param original 原字符串
/// @param scale 几位小数
/// @param AddString 小数位补什么. 一般补0
NS_INLINE NSString *stringRepairScaleWithString(NSString *original, NSInteger scale, NSString *AddString) {
    if ((original == nil || [original yxb_isNull])  || (AddString == nil || [AddString yxb_isNull])) {
        return @"";
    }
    
    if ([original containsString:@"."]) {
        NSString *before = [original componentsSeparatedByString:@"."].firstObject;
        NSString *behind = [original componentsSeparatedByString:@"."].lastObject;
        if (behind.length < scale) {
            NSString *ret = [[NSString alloc] init];
            ret = behind;
            for(int y =0; y < (scale - behind.length); y++ ){
                ret = [NSString stringWithFormat:@"%@%@",ret,AddString];
            }
            return [@[before,ret] componentsJoinedByString:@"."];
        } else {
            NSString *ret = [[NSString alloc] init];
            ret = [behind substringToIndex:scale];
            if (ret.length == 0) {
                return before;
            } else {
                return [@[before,ret] componentsJoinedByString:@"."];
            }
        }
    } else {
        NSString *ret = [[NSString alloc] init];
        for(int y =0; y < scale; y++ ){
            ret = [NSString stringWithFormat:@"%@%@",ret,AddString];
        }
        if (ret.length == 0) {
            return original;
        } else {
            return [@[original,ret] componentsJoinedByString:@"."];
        }
    }
}

/// 字符串精度, (去尾)
/// @param original 原字符串
/// @param scale 精度几位小数
NS_INLINE NSString *stringAccuracyRoundDown(NSString *original, NSInteger scale) {
    if (original == nil || [original yxb_isNull]) {
        original = @"0";
    }
    if (original.length == 0) {
        original = @"0";
    }
    NSString *revisetring = [NSString stringWithFormat:@"%@", original];
    NSDecimalNumber *input = [NSDecimalNumber decimalNumberWithString:revisetring];
    NSDecimalNumberHandler *handel = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:scale raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *outPut = [input decimalNumberByRoundingAccordingToBehavior:handel];
    return stringRepairScaleWithString([outPut stringValue], scale, @"0");
//    return [outPut stringValue];
}

/**
修正数据精度丢失
@param original 传入接口取到的数据
@return 修正精度后的数据
**/
NS_INLINE NSString *getReviseNumberData(NSString *original) {
//    double originalValue = [original doubleValue];
    if (original == nil || [original yxb_isNull]) {
        return @"";
    }
    NSString *revisetring = [NSString stringWithFormat:@"%@", original];
    NSDecimalNumber *input = [NSDecimalNumber decimalNumberWithString:revisetring];
    // 精度处理
    /*
    typedef NS_ENUM(NSUInteger, NSRoundingMode) {
        NSRoundPlain,   // Round up on a tie(四舍五入)
        NSRoundDown,    // Always down == truncate(只舍不入)
        NSRoundUp,      // Always up(只入不舍)
        NSRoundBankers  // on a tie round so last digit is even(也是四舍五入,这是和NSRoundPlain不一样,如果精确的哪位是5,
    它要看精确度的前一位是偶数还是奇数,如果是奇数,则入,偶数则舍,例如scale=1,表示精确到小数点后一位, NSDecimalNumber 为1.25时,
    NSRoundPlain结果为1.3,而NSRoundBankers则是1.2),下面是例子:
    };
    */
    NSDecimalNumberHandler *handel = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers scale:8 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *outPut = [input decimalNumberByRoundingAccordingToBehavior:handel];
//    NSString *string = stringAccuracyRoundDown([outPut stringValue], YXBAccuracyFour);
    return [outPut stringValue];
}

#pragma mark --------- 由于floatVlaue精度失准，影响加减乘除的结果 ----------------

/// 加法
NS_INLINE NSString *stringAddString(NSString *firstString, NSString *secondString) {
    if ((firstString == nil || [firstString yxb_isNull])  || (secondString == nil || [secondString yxb_isNull])) {
        return @"";
    }
    if (firstString.length == 0) {
        firstString = @"0";
    }
    if (secondString.length == 0) {
        secondString = @"0";
    }
    NSDecimalNumber *oneNumber = [NSDecimalNumber decimalNumberWithString:firstString];
    NSDecimalNumber *twoNumber = [NSDecimalNumber decimalNumberWithString:secondString];
    NSDecimalNumber *resultNumber = [oneNumber decimalNumberByAdding:twoNumber];
    NSString *string = stringAccuracyRoundDown([resultNumber stringValue], YXBAccuracyFour);
    return string;
}

/// 减法
NS_INLINE NSString *stringSubtractString(NSString *firstString, NSString *secondString) {
    if ((firstString == nil || [firstString yxb_isNull])  || (secondString == nil || [secondString yxb_isNull])) {
        return @"";
    }
    if (firstString.length == 0) {
        firstString = @"0";
    }
    if (secondString.length == 0) {
        secondString = @"0";
    }
    NSDecimalNumber *oneNumber = [NSDecimalNumber decimalNumberWithString:firstString];
    NSDecimalNumber *twoNumber = [NSDecimalNumber decimalNumberWithString:secondString];
    NSDecimalNumber *resultNumber = [oneNumber decimalNumberBySubtracting:twoNumber];
    NSString *string = stringAccuracyRoundDown([resultNumber stringValue], YXBAccuracyFour);
    return string;
}

/// 乘法
NS_INLINE NSString *stringMultiplyString(NSString *firstString, NSString *secondString) {
    if ((firstString == nil || [firstString yxb_isNull])  || (secondString == nil || [secondString yxb_isNull])) {
        return @"";
    }
    if (firstString.length == 0) {
        firstString = @"0";
    }
    if (secondString.length == 0) {
        secondString = @"0";
    }
    NSDecimalNumber *oneNumber = [NSDecimalNumber decimalNumberWithString:firstString];
    NSDecimalNumber *twoNumber = [NSDecimalNumber decimalNumberWithString:secondString];
    NSDecimalNumber *resultNumber = [oneNumber decimalNumberByMultiplyingBy:twoNumber];
    NSString *string = stringAccuracyRoundDown([resultNumber stringValue], YXBAccuracyFour);
    return string;
}

/// 除法
NS_INLINE NSString *stringDivideString(NSString *firstString, NSString *secondString) {
    if ((firstString == nil || [firstString yxb_isNull])  || (secondString == nil || [secondString yxb_isNull])) {
        return @"";
    }
    if (firstString.length == 0) {
        firstString = @"0";
    }
    if (secondString.length == 0) {
        return @"0";
    }
    if ([secondString isEqualToString:@"0"]) {
        return @"0";
    }
    NSDecimalNumber *oneNumber = [NSDecimalNumber decimalNumberWithString:firstString];
    NSDecimalNumber *twoNumber = [NSDecimalNumber decimalNumberWithString:secondString];
    NSDecimalNumber *resultNumber = [oneNumber decimalNumberByDividingBy:twoNumber];
    NSString *string = stringAccuracyRoundDown([resultNumber stringValue], YXBAccuracyFour);
    return string;
}


/// 标签文本转为富文本
/// @param text 标签文本
NS_INLINE NSAttributedString *attributedStringWithHTMLString(NSString *text) {
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[text dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    if (attrStr == nil) {
        attrStr = [[NSAttributedString alloc] initWithString:@"                                                                                                                                 "];
    }
    if (attrStr.length < 30) {
        NSString *newString = [attrStr.string stringByAppendingString:@"                                                                                                                                 "];
        attrStr = [[NSAttributedString alloc] initWithString:newString];
    }
    return attrStr;
}


/// 为标签文本注入js，为了适配屏幕
/// @param text 带标签的文本
NS_INLINE NSString *HTMLStringWithXMLString(NSString *text) {
    if (text == nil || [text yxb_isNull]) {
        return @"";
    }
    
    NSString *htmlstring =[NSString stringWithFormat:@"<html> \n"
    "<head> \n"
    "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no\">"
    "<style type=\"text/css\"> \n"
    // "body {font-size:15px;}\n"
    "ul, li, p, h1, h2, h3, dl, dt, dd {"
    "margin: 0;"
    "padding: 0;"
    "  }"
    
    "  ul, li, dl, dt, dd {"
    " list-style: none;"
    "  }"
    "</style> \n"
    "</head> \n"
    "<body>"
    "<script type='text/javascript'>"
    "window.onload = function(){\n"
    "var $img = document.getElementsByTagName('img');\n"
    "for(var p in  $img){\n"
    " $img[p].style.width = '100%%';\n"
    "$img[p].style.height ='auto'\n"
    "}\n"
    "}"
    "</script>%@"
    "</body>"
    "</html>",text];
    
    return htmlstring;
}

// 手机号脱敏
NS_INLINE NSString *phoneDesensitization(NSString *phoneString, NSInteger fromIndex, NSInteger length) {
    if (phoneString && phoneString.length > fromIndex + length) {
        NSString *replaceString = @"";
        for (NSInteger i = 0; i < length; i++) {
            replaceString = [replaceString stringByAppendingString:@"*"];
        }
        phoneString = [phoneString stringByReplacingCharactersInRange:NSMakeRange(fromIndex, length) withString:replaceString];//防止号码有前缀所以使用倒数第8位开始替换
    }
    return phoneString;
}

// 对头像制作加一个等级外边框
NS_INLINE UIImage *headerImageLevelBorder(UIImage *image, NSString *memberLevel, CGSize headerSize, CGSize borderSize, CGPoint beginPosition) {
    CGFloat scale = [UIScreen mainScreen].scale;
    UIImage *headerImage = [image qmui_imageResizedInLimitedSize:CGSizeMake(headerSize.width * scale, headerSize.height * scale)];
    UIImage *borderImage = [[UIImage imageNamed:@"JY_Grade_frame_icon09"] qmui_imageResizedInLimitedSize:CGSizeMake(borderSize.width * scale, borderSize.height * scale)];
//    UIImage *newImage = [headerImage qmui_imageWithMaskImage:borderImage usingMaskImageMode:YES];
    
    UIImage *newImage = [headerImage qmui_imageWithImageAbove:borderImage atPoint:CGPointMake(beginPosition.x * scale, beginPosition.y * scale)];
    
    return newImage;
}

// 边框图片,根据等级返回
NS_INLINE UIImage *levelBorderImage(NSString *memberLevel) {
    UIImage *borderImage;
    if ([memberLevel integerValue] == 1) {
        borderImage = nil;
    } else if ([memberLevel integerValue] == 2) {
        borderImage = [UIImage imageNamed:@"JY_Grade_frame_icon01"];
    } else if ([memberLevel integerValue] == 3) {
        borderImage = [UIImage imageNamed:@"JY_Grade_frame_icon02"];
    } else if ([memberLevel integerValue] == 4) {
        borderImage = [UIImage imageNamed:@"JY_Grade_frame_icon03"];
    } else if ([memberLevel integerValue] == 5) {
        borderImage = [UIImage imageNamed:@"JY_Grade_frame_icon05"];
    } else if ([memberLevel integerValue] == 6) {
        borderImage = [UIImage imageNamed:@"JY_Grade_frame_icon06"];
    } else {
        borderImage = nil;
    }
    return borderImage;
}

#endif /* YXBPublicDefine_h */

// 模态弹窗
/*
JYDTHomeBuyViewController *vc = [[JYDTHomeBuyViewController alloc] init];
CGRect frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 420, [UIScreen mainScreen].bounds.size.width, 420);
QMUIModalPresentationViewController *modalVC = [QMUIModalPresentationViewController new];
modalVC.contentViewController = vc;
modalVC.layoutBlock = ^(CGRect containerBounds, CGFloat keyboardHeight, CGRect contentViewDefaultFrame) {
    vc.view.qmui_frameApplyTransform = frame;
};
 // 禁用点击背景消失
modalVC.modal = YES;
[self.qmui_viewController presentViewController:modalVC animated:NO completion:nil];
*/

// 密码输入框
/*
 MJWeakSelf;
 QMUIModalPresentationViewController *modalVC = QMUIModalPresentationViewController.new;
 PayPwdInputView *dialogView = [NSBundle.mainBundle loadNibNamed:@"PayPwdInputView" owner:nil options:nil].firstObject;
 QMUITextField *textField = dialogView.tfPwd;
 textField.maximumTextLength = 6;
 dialogView.btnConfirm.qmui_tapBlock = ^(__kindof UIControl *sender) {
     if (textField.text.length > 0) {
         [weakSelf requestWithPassword:textField.text orderId:model.orderId];
         [modalVC hideWithAnimated:true completion:nil];
     }
 };
 dialogView.btnClose.qmui_tapBlock = ^(__kindof UIControl *sender) {
     [modalVC hideWithAnimated:true completion:nil];
 };
 
 modalVC.contentView = dialogView;
 
 [modalVC showWithAnimated:true completion:nil];
 
 */

// 图片预览
/*
#pragma mark ------------- 预览图片 -------------------
- (void)previewImageWith:(NSString *)imageUrl {
    if (imageUrl) {
        self.previewImageUrl = imageUrl;
        QMUIImagePreviewViewController *vc = [[QMUIImagePreviewViewController alloc] init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPreviewImage:)];
        tap.numberOfTapsRequired = 1;
        tap.delegate = self;
        [vc.view addGestureRecognizer:tap];
        vc.imagePreviewView.delegate = self;
        vc.imagePreviewView.currentImageIndex = 0;
        [self presentViewController:vc animated:YES completion:nil];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    BOOL back = [otherGestureRecognizer isKindOfClass:[UITapGestureRecognizer class]] && otherGestureRecognizer.numberOfTouches == 1;
    return back;
}

- (void)dismissPreviewImage:(UITapGestureRecognizer *)tap {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSUInteger)numberOfImagesInImagePreviewView:(QMUIImagePreviewView *)imagePreviewView {
    return 1;
}

- (void)imagePreviewView:(QMUIImagePreviewView *)imagePreviewView renderZoomImageView:(QMUIZoomImageView *)zoomImageView atIndex:(NSUInteger)index {
    
    zoomImageView.reusedIdentifier = @(index);
    
    [zoomImageView.imageView sd_setImageWithURL:[NSURL URLWithString:self.previewImageUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        zoomImageView.image = image;
    }];
}
*/

// 缓存中取图，不存在就下载
/*
{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    NSString *imageKey = [manager cacheKeyForURL:[NSURL URLWithString:model.content]];
    UIImage *colletImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:imageKey];
    if (colletImage == nil) {
        SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
        [downloader downloadImageWithURL:[NSURL URLWithString:model.content] completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            if (image && finished) {
                NIMMessage *imageMessage = [NIMMessageMaker msgWithImage:image];
                [[NIMSDK sharedSDK].chatManager sendMessage:imageMessage toSession:self.session error:nil];
            } else {
                ShowToast(@"图片不存在");
            }
        }];
    } else {
        NIMMessage *imageMessage = [NIMMessageMaker msgWithImage:colletImage];
        [[NIMSDK sharedSDK].chatManager sendMessage:imageMessage toSession:self.session error:nil];
    }
}
*/
