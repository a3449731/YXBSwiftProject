//
//  YXBPublicDefine.h
//  MyProject
//
//  Created by YangXiaoBin on 2019/11/17.
//  Copyright © 2019 YangXiaoBin. All rights reserved.
//

#ifndef YXBPublicDefine_h
#define YXBPublicDefine_h

//#import <Toast/UIView+Toast.h> // 引入了toast_swift, -Swift.h与pch互相导入toast会引发问题. 所有把taost导入放到了pch中
#import <DateTools/DateTools.h>
#import <UIImage+QMUI.h>
#import <QMUIKit/QMUIKit.h>
#import "NSObject+YXBAdd.h"
#import "YXBConstDefine.h"
#import "GetVersionAPI.h"
#import "ForceUpdateView.h"

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
    if ([secondString floatValue] == 0) {
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
                               
                               "body {"
    //                           "font-family: Helvetica, Arial, sans-serif;"
    //                           "font-size: 15px;"
    //                           "line-height: 1.428571429;"
//                               "color: #F6F6F6;"
    //                           "background-color: #000000;"
                               "}"
                               
                               "img {"
                               "display: inline-block;"
                               "max-width: 100%%;"
                               "}"
                               
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
    //    "window.onload = function(){\n"
    //    "var $img = document.getElementsByTagName('img');\n"
    //    "for(var p in  $img){\n"
    //    " $img[p].style.width = '100%%';\n"
    //    "$img[p].style.height ='auto'\n"
    //    "}\n"
    //    "}"
        "</script>%@"
        "</body>"
        "</html>",text];
        
        return htmlstring;
    
//    NSString *string = HTMLStringWithXMLString(model);
//    // 当内容很少时, webview会给自己一个倔强的a高度，这个缺省值可能比真实高度要高出很多，强行置一下0,让document.body.scrollHeight计算出真实高度
//    self.webView.webView.qmui_height = 0;
//    [self.webView.webView loadHTMLString:string baseURL:nil];
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

// 拨号 打电话
NS_INLINE void callPhoneNumber(NSString *phoneString) {
    if (phoneString) {
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",phoneString];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:nil];
    }
}

NS_INLINE NSString *compareCurrentTime(NSDate *compareDate) {
    NSTimeInterval timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    } else if ((temp = timeInterval / 60) < 60) {
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    } else if ((temp = temp / 60) < 24) {
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    } else if ((temp = temp / 24) < 30) {
        result = [NSString stringWithFormat:@"%ld天前",temp];
    } else if ((temp = temp / 30) < 12) {
        result = [NSString stringWithFormat:@"%ld月前",temp];
    } else {
        temp = temp / 12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    return  result;
}

/// 计算时间过去了多久
/// @param dateString 时间字符串,  如果是时间戳自行转换一下，注意后台的时间戳要除1000
/// @param formatString 时间格式 例:yyyy-MM-dd HH:mm:ss
/// @param timeZoneName 传nil的话 可能默认的是本机时区，美国@"America/New_York"  中国@"Asia/Shanghai"
NS_INLINE NSString *timeAgoCovert(NSString *dateString, NSString *formatString, NSString *timeZoneName) {
    NSTimeZone *timeZone = nil;
    if (timeZoneName != nil) {
       timeZone = [NSTimeZone timeZoneWithName:timeZoneName];
    }
    NSDate *inputDate = [NSDate dateWithString:dateString formatString:formatString timeZone:timeZone];
    return compareCurrentTime(inputDate);
}


/// 检测版本更新
NS_INLINE void checkAPPVersion() {
    GetVersionAPI *network = [[GetVersionAPI alloc] init];
    [network startWithCompletionBlockWithSuccess:^(__kindof GetVersionAPI * _Nonnull request) {
        VersionModel *model = [request jsonForModel];
        if (model == nil) {
            return ;
        }
        
        BOOL isLatest = ([model.versionNum compare:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]] < NSOrderedDescending);
        if (isLatest) return;
        
        bool isForce = true;
        NSString *updateLink = model.versionUrl;
        
        ForceUpdateView *updateView = [NSBundle.mainBundle loadNibNamed:@"ForceUpdateView" owner:nil options:nil].firstObject;
        QMUIModalPresentationViewController *modalVC = QMUIModalPresentationViewController.new;
        
        updateView.lblTitle.text = [NSString stringWithFormat:@"发现新版本V%@", model.versionNum];
        updateView.textContent.text = model.content;
        
        //            @weakify(modalVC);
        updateView.btnClose.qmui_tapBlock = ^(__kindof UIControl *sender) {
            [modalVC hideWithAnimated:true completion:nil];
        };
        updateView.btnClose.hidden = isForce;
        
        
        updateView.btnUpdateNow.qmui_tapBlock = ^(__kindof UIControl *sender) {
            NSURL *url = [NSURL URLWithString:updateLink];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
        };
        
        modalVC.contentView = updateView;
        modalVC.modal = YES;
        [QMUIModalPresentationViewController hideAllVisibleModalPresentationViewControllerIfCan];
        [modalVC showWithAnimated:true completion:nil];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}


//- (void)checkAPPVersion {
//    GetVersionAPI *network = [[GetVersionAPI alloc] init];
//    [network startWithCompletionBlockWithSuccess:^(__kindof GetVersionAPI * _Nonnull request) {
//        VersionModel *model = [request jsonForModel];
//        if (model == nil) {
//            return ;
//        }
//
//        BOOL isLatest = ([model.versionNum compare:APP_VERSION options:(NSNumericSearch)] < NSOrderedDescending);
//        if (isLatest) return;
//
//        bool isForce = true;
//        NSString *updateLink = model.versionUrl;
//
//        ForceUpdateView *updateView = [NSBundle.mainBundle loadNibNamed:@"ForceUpdateView" owner:nil options:nil].firstObject;
//        QMUIModalPresentationViewController *modalVC = QMUIModalPresentationViewController.new;
//
//        updateView.lblTitle.text = [NSString stringWithFormat:@"发现新版本V%@", model.versionNum];
//        updateView.textContent.text = model.content;
//
//        @weakify(modalVC);
//        updateView.btnClose.qmui_tapBlock = ^(__kindof UIControl *sender) {
//            [weak_modalVC hideWithAnimated:true completion:nil];
//        };
//        updateView.btnClose.hidden = isForce;
//
//        updateView.btnUpdateNow.qmui_tapBlock = ^(__kindof UIControl *sender) {
//            NSURL *url = [NSURL URLWithString:updateLink];
//            if ([[UIApplication sharedApplication] canOpenURL:url]) {
//                [[UIApplication sharedApplication] openURL:url];
//            }
//        };
//
//        modalVC.contentView = updateView;
//        modalVC.modal = YES;
//        [QMUIModalPresentationViewController hideAllVisibleModalPresentationViewControllerIfCan];
//        [modalVC showWithAnimated:true completion:nil];
//
//        //        UIAlertController * alertCon = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"有新版本更新，请点击确定重新下载！" preferredStyle:UIAlertControllerStyleAlert];
//        //        UIAlertAction * ACAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        //            NSURL *url = [NSURL URLWithString:updateLink];
//        //            if ([[UIApplication sharedApplication] canOpenURL:url]) {
//        //                [[UIApplication sharedApplication] openURL:url];
//        //            }
//        //        }];
//        //        [alertCon addAction:ACAction];
//        //        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertCon animated:YES completion:nil];
//
//    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//
//    }];
//}

#endif /* YXBPublicDefine_h */

// 模态弹窗
/*
JYDTHomeBuyViewController *vc = [[JYDTHomeBuyViewController alloc] init];
CGRect frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 420, [UIScreen mainScreen].bounds.size.width, 420);
QMUIModalPresentationViewController *modalVC = [QMUIModalPresentationViewController new];
// 背景色
modalVC.dimmingView.backgroundColor = [UIColorFromHex(#000000) colorWithAlphaComponent:0.6];
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


// 分享到微信
/*
-(void)share:(NSString *)url{
    //分享的标题
    NSString *textToShare = @"下载地址 Download address";
    //分享的图片
    UIImage *imageToShare = [UIImage imageNamed:@"图层4"];
    //分享的url
    NSURL *urlToShare = [NSURL URLWithString:url];
    //在这里呢 如果想分享图片 就把图片添加进去  文字什么的通上
    NSArray *activityItems = @[textToShare,imageToShare, urlToShare];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    //不出现在活动项目
    activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
    [self presentViewController:activityVC animated:YES completion:nil];
    // 分享之后的回调
    activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        if (completed) {
            NSLog(@"completed");
            //分享 成功
        } else  {
            NSLog(@"cancelled");
            //分享 取消
        }
    };
}
*/

// IQKeyboardManager 键盘禁用 禁用键盘
/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
}
*/
