//
//  YXBTextField.m
//  YingXingBoss
//
//  Created by 杨 on 2018/3/26.
//  Copyright © 2018年 杨. All rights reserved.
//

#import "YXBTextField.h"
#import <CoreText/CoreText.h>
#import <YYCategories.h>


@interface YXBTextField()

//@property (nonatomic, strong) UIView *codeStringView;
@property (nonatomic , strong) NSMutableArray *layerArray;

@end

@implementation YXBTextField

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (self.lineColor)
    {
        [self.lineColor set];
    }
    else
    {
        [[UIColor redColor] set];//设置下划线颜色 这里是红色 可以自定义
    }
    CGFloat y = CGRectGetHeight(self.frame);
    CGContextMoveToPoint(context, 0, y);
    CGContextAddLineToPoint(context, CGRectGetWidth(self.frame), y);
    //设置线的宽度
    CGContextSetLineWidth(context, 1);
    //渲染 显示到self上
    CGContextStrokePath(context);
    
    
    
    if (!self.imageCodeString) return;
    [[UIColor yellowColor] set];
    
    CGContextAddRect(context, self.rightViewFrame);
    CGContextSetFillColorWithColor(context, self.codeBackgroundColor == nil ? [UIColor grayColor].CGColor : self.codeBackgroundColor.CGColor);
    CGContextDrawPath(context, kCGPathFill);  // 无边框，带填充 。 还有其他选项如 带边框带填充,  有边框,无填充
    
    //4.设置绘制内容
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:
                                            self.imageCodeString attributes:nil];
    
    
    // 为了保证 富文本 在 绘图框里
    CGRect attStringRect;
    do {
        [self arribute:attString];
        attStringRect = [self boundsWithAttributeString:attString needWidth:self.rightViewFrame.size.width - 3];
    } while (attStringRect.size.width > self.rightViewFrame.size.width - 3);
    YXBLOG(@"计算宽度 %f",attStringRect.size.width - self.rightViewFrame.size.width);
    
    
    [attString drawInRect:CGRectMake(self.rightViewFrame.origin.x + 3,self.rightViewFrame.origin.y  + self.rightViewFrame.size.height / 5, self.rightViewFrame.size.width - 3, self.rightViewFrame.size.height / 4 * 3)];
    
    /*
     //1.获取当前绘图上下文
     //        CGContextRef context = UIGraphicsGetCurrentContext();
     
     //然后在context上绘画。。。
     //2.旋转坐坐标系(默认和UIKit坐标是相反的)
     CGContextSetTextMatrix(context, CGAffineTransformIdentity);
     CGContextTranslateCTM(context, 0, self.rightViewFrame.size.height);
     CGContextScaleCTM(context, 1.0, -1.0);
     
     //3.创建绘制局域
     CGMutablePathRef path = CGPathCreateMutable();
     //    CGSize fontSize = [self fontSize];
     CGPathAddRect(path, NULL, CGRectMake(self.rightViewFrame.origin.x,self.rightViewFrame.origin.y , 50, 30));
     
     //4.设置绘制内容
     NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:
     self.imageCodeString attributes:nil];
     NSRange range = NSMakeRange(0, attString.length);
     //    [attString addAttribute:NSUnderlineStyleAttributeName value:@1 range:range];
     //    [attString addAttribute:NSForegroundColorAttributeName value:COLOR(18, 186, 250, 1) range:range];
     //    [attString addAttribute:NSBackgroundColorAttributeName value:[UIColor redColor] range:range];
     //    [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:22] range:range];
     [attString addAttribute:NSVerticalGlyphFormAttributeName value:@0 range:range];
     [attString addAttribute:NSObliquenessAttributeName value:@(1) range:range];
     
     
     CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
     CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, [attString length]), path, NULL);
     
     //5.开始绘制
     CTFrameDraw(frame, context);
     
     //6.释放资源
     CFRelease(frame);
     CFRelease(path);
     CFRelease(framesetter);
     */
}

- (void)arribute:(NSMutableAttributedString *)attString
{
    //    NSMutableParagraphStyle *muParagraph = [[NSMutableParagraphStyle alloc]init];
    //    muParagraph.lineBreakMode = NSLineBreakByCharWrapping; // 设置换行模式.  以字符为显示单位显示，后面部分省略不显示
    //    [attString addAttribute:NSParagraphStyleAttributeName value:muParagraph range:NSMakeRange(0, attString.length)];
    
    for (NSInteger i = 0; i < attString.length; i++)
    {
        NSRange range = NSMakeRange(i, 1);
        
        [attString addAttribute:NSForegroundColorAttributeName value:RGBAColor(0, 0, 0, 1) range:range]; // 设置字体颜色
        
        NSInteger fontRandom = arc4random()%10 + 12;
        [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontRandom] range:range];  // 设置字体
        
        NSNumber *obloquenessRandom =[NSNumber numberWithFloat:[self high:0.5 low:-0.5]];
        [attString addAttribute:NSObliquenessAttributeName value:obloquenessRandom range:range]; // 设置倾斜
        
        NSNumber *kernRandom = [NSNumber numberWithFloat:[self high:10 low:3]];
        [attString addAttribute:NSKernAttributeName value:kernRandom range:range]; // 设置字符间隔
        
        NSNumber *lineOffsetRandom = [NSNumber numberWithFloat:[self high:self.rightViewFrame.size.height / 5 low: 0]];
        [attString addAttribute:NSBaselineOffsetAttributeName value:lineOffsetRandom range:range];// 基准线偏移
    }
    
}

- (CGFloat)high:(CGFloat)high low:(CGFloat)low
{
    float diff = high - low;
    return (((float) rand() / RAND_MAX) * diff) + low;
}


//- (CGSize)fontSize
//{
//    CGFloat width = [self.imageCodeString widthForFont:[UIFont systemFontOfSize:15]];
//    CGFloat height = [self.imageCodeString heightForFont:[UIFont systemFontOfSize:15] width:width];
//    CGSize size = CGSizeMake(width, height);
//    return size;
//
//}


// 接下来自定义textField的leftView， 这里因为要显示文字，所以用一个label来实现， 也可以使用自定义的view
// 。在初始化的时候设置label为leftView， 并设置leftView的mode
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIButton *leftButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.leftView = leftButton;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.leftButton = leftButton;
        
        UIButton *rightButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.rightView = rightButton;
        self.rightViewMode = UITextFieldViewModeAlways;
        self.rightButton = rightButton;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        UIButton *leftButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.leftView = leftButton;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.leftButton = leftButton;
        
        UIButton *rightButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.rightView = rightButton;
        self.rightViewMode = UITextFieldViewModeAlways; // ***重要 , 点击按钮不去触发 输入键盘。
        self.rightButton = rightButton;
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}


- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    [super leftViewRectForBounds:bounds];
    CGRect frame = bounds;
    //这里设置为leftView的宽是textField的0.3倍，
    frame.size.width = bounds.size.width * 0;
    if (self.leftViewFrame.size.width)
    {
        frame = self.leftViewFrame;
    }
    
    return frame;
}

- (void)setLeftViewFrame:(CGRect)leftViewFrame
{
    _leftViewFrame = leftViewFrame;
    
    [self leftViewRectForBounds:self.frame];
}


- (void)setLeftText:(NSString *)leftText
{
    _leftText = leftText;
    if (leftText)
    {
        [self.leftButton setTitle:leftText forState:(UIControlStateNormal)];
    }
    
    if (!self.leftViewFrame.size.width) // 如果没有设置，右边的frame，先设置
    {
        CGFloat width = [leftText widthForFont:self.leftTextFont ? self.leftTextFont : [UIFont systemFontOfSize:15]];
        [self setLeftViewFrame:CGRectMake(15 , 2, width + 20, self.height - 4)];
    }
    
}
- (void)setLeftTextColor:(UIColor *)leftTextColor
{
    _leftTextColor = leftTextColor;
    if (leftTextColor)
    {
        [self.leftButton setTitleColor:leftTextColor forState:(UIControlStateNormal)];
    }
    
}

- (void)setLeftTextFont:(UIFont *)leftTextFont
{
    _leftTextFont = leftTextFont;
    if (leftTextFont)
    {
        self.leftButton.titleLabel.font = leftTextFont;
    }
}


- (void)setLeftImage:(UIImage *)leftImage
{
    _leftImage = leftImage;
    if (leftImage)
    {
        [self.leftButton setImage:leftImage forState:(UIControlStateNormal)];
    }
}


#pragma mark -------- rightView ----------------
- (CGRect)rightViewRectForBounds:(CGRect)bounds
{
    [super rightViewRectForBounds:bounds];
    CGRect frame = bounds;
    //这里设置为leftView的宽是textField的0.3倍，
    frame.size.width = bounds.size.width * 0;
    if (self.rightViewFrame.size.width)
    {
        frame = self.rightViewFrame;
    }
    return frame;
}

- (void)setRightViewFrame:(CGRect)rightViewFrame
{
    _rightViewFrame = rightViewFrame;
    [self rightViewRectForBounds:self.frame];
}

- (void)setRightText:(NSString *)rightText
{
    _rightText = rightText;
    if (rightText)
    {
        [self.rightButton setTitle:rightText forState:(UIControlStateNormal)];
    }
    
    if (!self.rightViewFrame.size.width) // 如果没有设置，右边的frame，先设置
    {
        CGFloat width = [rightText widthForFont:self.rightTextFont ? self.rightTextFont : [UIFont systemFontOfSize:15]];
        [self setRightViewFrame:CGRectMake(self.width - 70 , 2, width + 20, self.height - 4)];
    }
}

- (void)setRightTextColor:(UIColor *)rightTextColor
{
    _rightTextColor = rightTextColor;
    if (rightTextColor)
    {
        [self.rightButton setTitleColor:rightTextColor forState:(UIControlStateNormal)];
    }
}

- (void)setRightTextFont:(UIFont *)rightTextFont
{
    _rightTextFont = rightTextFont;
    if (rightTextFont)
    {
        self.rightButton.titleLabel.font = rightTextFont;
    }
}

- (void)setRightImage:(UIImage *)rightImage
{
    _rightImage = rightImage;
    if (rightImage)
    {
        [self.rightButton setImage:rightImage forState:(UIControlStateNormal)];
    }
}


#pragma mark ---------- 线 和 占位 ------------
- (void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    if (lineColor)
    {
        [self setNeedsDisplay];
    }
}


- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    [self setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
}
- (void)setPlaceholderFont:(UIFont *)placeholderFont
{
    [self setValue:placeholderFont forKeyPath:@"_placeholderLabel.font"];
}

#pragma mark ------- 制作图形验证码 ----------------
- (void)refreshImageWithString:(NSString *)codeString
{
    
    _imageCodeString = codeString;
    if (!self.rightViewFrame.size.width) // 如果没有设置，右边的frame，先设置
    {
        [self setRightViewFrame:CGRectMake(self.width - 70 , 0, 70, self.height)];
    }
    // 这里会去调用 drawRect
    [self setNeedsDisplay];
    
    if (self.layerArray)
    {
        for (CALayer *layer in self.layerArray)
        {
            [layer removeFromSuperlayer];
        }
    }
    self.layerArray = [NSMutableArray array];
    
    for (int i = 0; i<10; i++)
    {
        UIBezierPath *path = [UIBezierPath bezierPath];
        CGFloat pX = arc4random() % (int)CGRectGetWidth(self.rightViewFrame);
        CGFloat pY = arc4random() % (int)CGRectGetHeight(self.rightViewFrame);
        [path moveToPoint:CGPointMake(pX, pY)];
        CGFloat ptX = arc4random() % (int)CGRectGetWidth(self.rightViewFrame);
        CGFloat ptY = arc4random() % (int)CGRectGetHeight(self.rightViewFrame);
        [path addLineToPoint:CGPointMake(ptX, ptY)];
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.strokeColor = [[self getRandomBgColorWithAlpha:0.5] CGColor];//layer的边框色
        layer.lineWidth = 1.0f;
        layer.strokeEnd = 1;
        layer.fillColor = [UIColor redColor].CGColor;
        layer.path = path.CGPath;
        [_layerArray addObject:layer];
        [self.rightView.layer addSublayer:layer];
        
    }
    
}

-(UIColor *)getRandomBgColorWithAlpha:(CGFloat)alpha{
    float red = arc4random() % 100 / 100.0;
    float green = arc4random() % 100 / 100.0;
    float blue = arc4random() % 100 / 100.0;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    return color;
}

#pragma mark --------- 设置背景色 --------------
-  (void)setCodeBackgroundColor:(UIColor *)codeBackgroundColor
{
    _codeBackgroundColor = codeBackgroundColor;
    if (codeBackgroundColor)
    {
        [self setNeedsDisplay];
    }
}


/**
 计算富文本的宽高。
 
 @boundsWithAttributeString  : 富文本信息
 @needWidth ：将要计算的最大宽度
 @return 富文本的宽高
 
 */
- (CGRect)boundsWithAttributeString:(NSMutableAttributedString *)attributeString  needWidth:(CGFloat)needWidth
{
    
    CGRect rect = [attributeString boundingRectWithSize:CGSizeMake(needWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    return rect;
}

@end

