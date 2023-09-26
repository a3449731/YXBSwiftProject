//
//  TUIBubbleMessageCellData.m
//  TXIMSDK_TUIKit_iOS
//
//  Created by annidyfeng on 2019/5/30.
//

#import "TUIBubbleMessageCellData.h"
#import "TUIDefine.h"
#import "TUIThemeManager.h"

@implementation TUIBubbleMessageCellData

+ (void)initialize
{
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(onThemeChanged:) name:TUIDidApplyingThemeChangedNotfication object:nil];
}

- (instancetype)initWithDirection:(TMsgDirection)direction
{
    self = [super initWithDirection:direction];
    if (self) {
        if (direction == MsgDirectionIncoming) {
            _bubble = [[self class] incommingBubble];
            _highlightedBubble = [[self class] incommingHighlightedBubble];
            _bubbleTop = [[self class] incommingBubbleTop];
            UIImage *alpha50 = [[TUIImageCache sharedInstance] getResourceFromCache:TUIChatImagePath(@"ReceiverTextNodeBkg_alpha50")];
            alpha50 = [self imageChangeColor:[UIColor whiteColor] withImage:alpha50];
            _animateHighlightBubble_alpha50 = [TUIChatDynamicImage(@"chat_bubble_receive_alpha50_img", alpha50) resizableImageWithCapInsets:UIEdgeInsetsFromString(@"{12,12,12,12}")
                                                                                                resizingMode:UIImageResizingModeStretch];
            UIImage *alpha20 = [[TUIImageCache sharedInstance] getResourceFromCache:TUIChatImagePath(@"ReceiverTextNodeBkg_alpha20")];
            alpha20 = [self imageChangeColor:[UIColor whiteColor] withImage:alpha20];
            _animateHighlightBubble_alpha20 = [TUIChatDynamicImage(@"chat_bubble_receive_alpha20_img", alpha20) resizableImageWithCapInsets:UIEdgeInsetsFromString(@"{12,12,12,12}")
                                                                                                resizingMode:UIImageResizingModeStretch];
            
        } else {
            _bubble = [[self class] outgoingBubble];
            _highlightedBubble = [[self class] outgoingHighlightedBubble];
            _bubbleTop = [[self class] outgoingBubbleTop];
            
            UIImage *alpha50 = [[TUIImageCache sharedInstance] getResourceFromCache:TUIChatImagePath(@"SenderTextNodeBkg_alpha50")];
//            alpha50 = [self imageChangeColor:[UIColor colorWithRed:255/255.0 green:79/255.0 blue:115/255.0 alpha:1.0] withImage:alpha50];
            _animateHighlightBubble_alpha50 = [TUIChatDynamicImage(@"chat_bubble_send_alpha50_img", alpha50) resizableImageWithCapInsets:UIEdgeInsetsFromString(@"{12,12,12,12}")
                                                                                                resizingMode:UIImageResizingModeStretch];
            
            UIImage *alpha20 = [[TUIImageCache sharedInstance] getResourceFromCache:TUIChatImagePath(@"SenderTextNodeBkg_alpha20")];
//            alpha20 = [self imageChangeColor:[UIColor colorWithRed:255/255.0 green:79/255.0 blue:115/255.0 alpha:1.0] withImage:alpha20];
            _animateHighlightBubble_alpha20 = [TUIChatDynamicImage(@"chat_bubble_send_alpha20_img", alpha20) resizableImageWithCapInsets:UIEdgeInsetsFromString(@"{12,12,12,12}")
                                                                                                resizingMode:UIImageResizingModeStretch];
        }
    }
    return self;
}


//绘图
-(UIImage*)imageChangeColor:(UIColor*)color withImage:(UIImage *)image
{
    //获取画布
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    //画笔沾取颜色
    [color setFill];
    
    CGRect bounds = CGRectMake(0, 0, image.size.width, image.size.height);
    UIRectFill(bounds);
    //绘制一次
    [image drawInRect:bounds blendMode:kCGBlendModeOverlay alpha:1.0f];
    //再绘制一次
    [image drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    //获取图片
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

//绘图
+ (UIImage*)classimageChangeColor:(UIColor*)color withImage:(UIImage *)image
{
    //获取画布
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    //画笔沾取颜色
    [color setFill];
    
    CGRect bounds = CGRectMake(0, 0, image.size.width, image.size.height);
    UIRectFill(bounds);
    //绘制一次
    [image drawInRect:bounds blendMode:kCGBlendModeOverlay alpha:1.0f];
    //再绘制一次
    [image drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    //获取图片
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


static UIImage *sOutgoingBubble;

+ (UIImage *)outgoingBubble
{
    if (!sOutgoingBubble) {
        UIImage *defaultImage = [[TUIImageCache sharedInstance] getResourceFromCache:TUIChatImagePath(@"SenderTextNodeBkg")];
//        defaultImage = [TUIBubbleMessageCellData classimageChangeColor:[UIColor colorWithRed:255/255.0 green:79/255.0 blue:115/255.0 alpha:1.0] withImage:defaultImage];
        sOutgoingBubble = [TUIChatDynamicImage(@"chat_bubble_send_img", defaultImage) resizableImageWithCapInsets:UIEdgeInsetsFromString(@"{12,12,12,12}") resizingMode:UIImageResizingModeStretch];
    }
    return sOutgoingBubble;
}

+ (void)setOutgoingBubble:(UIImage *)outgoingBubble
{
    sOutgoingBubble = outgoingBubble;
}

static UIImage *sOutgoingHighlightedBubble;
+ (UIImage *)outgoingHighlightedBubble
{
    if (!sOutgoingHighlightedBubble) {
        UIImage *defaultImage = [[TUIImageCache sharedInstance] getResourceFromCache:TUIChatImagePath(@"SenderTextNodeBkgHL")];
//        defaultImage = [TUIBubbleMessageCellData classimageChangeColor:[UIColor colorWithRed:255/255.0 green:79/255.0 blue:115/255.0 alpha:1.0] withImage:defaultImage];
        sOutgoingHighlightedBubble = [TUIChatDynamicImage(@"chat_bubble_send_img", defaultImage) resizableImageWithCapInsets:UIEdgeInsetsFromString(@"{12,12,12,12}") resizingMode:UIImageResizingModeStretch];
    }
    return sOutgoingHighlightedBubble;
}

+ (void)setOutgoingHighlightedBubble:(UIImage *)outgoingHighlightedBubble
{
    sOutgoingHighlightedBubble = outgoingHighlightedBubble;
}

static UIImage *sIncommingBubble;
+ (UIImage *)incommingBubble
{
    if (!sIncommingBubble) {
        UIImage *defaultImage = [[TUIImageCache sharedInstance] getResourceFromCache:TUIChatImagePath(@"ReceiverTextNodeBkg")];
        defaultImage = [TUIBubbleMessageCellData classimageChangeColor:[UIColor whiteColor] withImage:defaultImage];
        sIncommingBubble = [TUIChatDynamicImage(@"chat_bubble_receive_img", defaultImage) resizableImageWithCapInsets:UIEdgeInsetsFromString(@"{12,12,12,12}") resizingMode:UIImageResizingModeStretch];
    }
    return sIncommingBubble;
}

+ (void)setIncommingBubble:(UIImage *)incommingBubble
{
    sIncommingBubble = incommingBubble;
}

static UIImage *sIncommingHighlightedBubble;
+ (UIImage *)incommingHighlightedBubble
{
    if (!sIncommingHighlightedBubble) {
        UIImage *defaultImage = [[TUIImageCache sharedInstance] getResourceFromCache:TUIChatImagePath(@"ReceiverTextNodeBkgHL")];
        defaultImage = [TUIBubbleMessageCellData classimageChangeColor:[UIColor whiteColor] withImage:defaultImage];
        sIncommingHighlightedBubble =[TUIChatDynamicImage(@"chat_bubble_receive_img", defaultImage) resizableImageWithCapInsets:UIEdgeInsetsFromString(@"{12,12,12,12}") resizingMode:UIImageResizingModeStretch];
    }
    return sIncommingHighlightedBubble;
}

+ (void)setIncommingHighlightedBubble:(UIImage *)incommingHighlightedBubble
{
    sIncommingHighlightedBubble = incommingHighlightedBubble;
}


static CGFloat sOutgoingBubbleTop = 0;

+ (CGFloat)outgoingBubbleTop
{
    return sOutgoingBubbleTop;
}

+ (void)setOutgoingBubbleTop:(CGFloat)outgoingBubble
{
    sOutgoingBubbleTop = outgoingBubble;
}

static CGFloat sIncommingBubbleTop = 0;

+ (CGFloat)incommingBubbleTop
{
    return sIncommingBubbleTop;
}

+ (void)setIncommingBubbleTop:(CGFloat)incommingBubbleTop
{
    sIncommingBubbleTop = incommingBubbleTop;
}

+ (void)onThemeChanged:(NSNotification *)notice
{
    sOutgoingBubble = nil;
    sOutgoingHighlightedBubble = nil;
    
    sIncommingBubble = nil;
    sIncommingHighlightedBubble = nil;
}

@end
