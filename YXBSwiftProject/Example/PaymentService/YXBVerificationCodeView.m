//
//  YXBVerificationCodeView.m
//  GJHospitalProject
//
//  Created by yang on 2022/1/14.
//  Copyright © 2022 GJNativeTeam. All rights reserved.
//

#import "YXBVerificationCodeView.h"

#define kFlickerAnimation @"kFlickerAnimation"

@implementation YXBVCConfig

- (instancetype)init {
    if (self = [super init]) {
        _inputBoxBorderWidth = 1.0/[UIScreen mainScreen].scale;
        _inputBoxSpacing = 5;
        _inputBoxColor = [UIColor lightGrayColor];
        _tintColor = [UIColor blueColor];
        _font = [UIFont boldSystemFontOfSize:16];
        _textColor = [UIColor blackColor];
        _showFlickerAnimation = YES;
        _underLineColor = [UIColor lightGrayColor];
        _autoShowKeyboardDelay = 0.5;
    }
    return self;
}

@end

@interface YXBVerificationCodeView() <UITextFieldDelegate>
@property (nonatomic, strong) YXBVCConfig               *config;
@property (nonatomic, strong) UITextField              *textView;
@property (nonatomic, assign) BOOL                      inputFinish;
@property (nonatomic, assign) NSUInteger                inputFinishIndex;
@property (nonatomic, strong) NSMutableArray<UITextField *> *textArray;
@property (nonatomic, strong) NSMutableArray<UIView *> *flickerArray;
@end

@implementation YXBVerificationCodeView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithFrame:(CGRect)frame config:(YXBVCConfig *)config {
    if (self = [super initWithFrame:frame]) {
        _config = config;
        self.textArray = [NSMutableArray array];
        self.flickerArray = [NSMutableArray array];
        [self jhSetupViews:frame];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect frame = self.frame;
    //优先考虑 inputBoxWidth
    CGFloat inputBoxSpacing = _config.inputBoxSpacing;
    
    CGFloat inputBoxWidth = 0;
    if (_config.inputBoxWidth > 0) {
        inputBoxWidth = _config.inputBoxWidth;
    }
    
    CGFloat leftMargin = 0;
    if (inputBoxWidth > 0) {
        leftMargin = (CGRectGetWidth(frame)-inputBoxWidth*_config.inputBoxNumber-inputBoxSpacing*(_config.inputBoxNumber-1))*0.5;
    }else{
        inputBoxWidth = (CGRectGetWidth(frame)-inputBoxSpacing*(_config.inputBoxNumber-1)-_config.leftMargin*2)/_config.inputBoxNumber;
    }
    
    if (_config.leftMargin < 0) {
        _config.leftMargin = 0;
        leftMargin = _config.leftMargin;
        inputBoxWidth = (CGRectGetWidth(frame)-inputBoxSpacing*(_config.inputBoxNumber-1)-_config.leftMargin*2)/_config.inputBoxNumber;
    }
    
    CGFloat inputBoxHeight = 0;
    inputBoxHeight = _config.inputBoxHeight;
    if (_config.inputBoxHeight > CGRectGetHeight(frame)) {
        inputBoxHeight = CGRectGetHeight(frame);
    }

    
    if (_config.showUnderLine) {
        if (_config.underLineSize.width <= 0) {
            CGSize size = _config.underLineSize;
            size.width = inputBoxWidth;
            _config.underLineSize = size;
        }
        if (_config.underLineSize.height <= 0) {
            CGSize size = _config.underLineSize;
            size.height = 1;
            _config.underLineSize = size;
        }
    }
    
    for (NSInteger i = 0; i < self.textArray.count; i++) {
        UITextField *textField = self.textArray[i];
        CGFloat x = _config.leftMargin + (inputBoxWidth + inputBoxSpacing) * i;
        CGFloat y = (CGRectGetHeight(self.frame) - inputBoxHeight) * 0.5;
        textField.frame = CGRectMake(x, y, inputBoxWidth, inputBoxHeight);
    }
    
    for (NSInteger i = 0; i < self.flickerArray.count; i++) {
        UIView *view = self.flickerArray[i];
        CGFloat width = 2;
        CGFloat x = (inputBoxWidth - width) / 2;
        CGFloat y = 4;
        CGFloat height = inputBoxHeight - (2 * y);
        view.frame = CGRectMake(x, y, width, height);
    }
    
    self.textView.frame = CGRectMake(0, CGRectGetHeight(frame), 0, 0);
}

- (void)jhSetupViews:(CGRect)frame {
    //优先考虑 inputBoxWidth
    CGFloat inputBoxSpacing = _config.inputBoxSpacing;
    
    CGFloat inputBoxWidth = 0;
    if (_config.inputBoxWidth > 0) {
        inputBoxWidth = _config.inputBoxWidth;
    }
    
    CGFloat leftMargin = 0;
    if (inputBoxWidth > 0) {
        leftMargin = (CGRectGetWidth(frame)-inputBoxWidth*_config.inputBoxNumber-inputBoxSpacing*(_config.inputBoxNumber-1))*0.5;
    }else{
        inputBoxWidth = (CGRectGetWidth(frame)-inputBoxSpacing*(_config.inputBoxNumber-1)-_config.leftMargin*2)/_config.inputBoxNumber;
    }
    
    if (_config.leftMargin < 0) {
        _config.leftMargin = 0;
        leftMargin = _config.leftMargin;
        inputBoxWidth = (CGRectGetWidth(frame)-inputBoxSpacing*(_config.inputBoxNumber-1)-_config.leftMargin*2)/_config.inputBoxNumber;
    }
    
    CGFloat inputBoxHeight = 0;
    inputBoxHeight = _config.inputBoxHeight;
    if (_config.inputBoxHeight > CGRectGetHeight(frame)) {
        inputBoxHeight = CGRectGetHeight(frame);
    }
    
    // 下划线的位置，配上masonry的话会有点问题，没时间处理了，倒也用不上下划线
    if (_config.showUnderLine) {
        if (_config.underLineSize.width <= 0) {
            CGSize size = _config.underLineSize;
            size.width = inputBoxWidth;
            _config.underLineSize = size;
        }
        if (_config.underLineSize.height <= 0) {
            CGSize size = _config.underLineSize;
            size.height = 1;
            _config.underLineSize = size;
        }
    }
    
    for (int i = 0; i < _config.inputBoxNumber; ++i) {
        UITextField *textField = [[UITextField alloc] init];
        CGFloat x = _config.leftMargin + (inputBoxWidth + inputBoxSpacing) * i;
        CGFloat y = (CGRectGetHeight(self.frame) - inputBoxHeight) * 0.5;
        textField.frame = CGRectMake(x, y, inputBoxWidth, inputBoxHeight);
        textField.textAlignment = 1;
        if (_config.inputBoxBorderWidth) {
            textField.layer.borderWidth = _config.inputBoxBorderWidth;
        }
        if (_config.inputBoxCornerRadius) {
            textField.layer.cornerRadius = _config.inputBoxCornerRadius;
        }
        if (_config.inputBoxColor) {
            textField.layer.borderColor = _config.inputBoxColor.CGColor;
        }
        if (_config.tintColor) {
            CGFloat w = 2, y = 4, x = (inputBoxWidth-w)/2, h = inputBoxHeight-2*y;
            // 添加的闪烁图层
            UIView *view = [[UIView alloc] init];
            view.frame = CGRectMake(x, y, w, h);
            view.backgroundColor = _config.tintColor;
            [view.layer addAnimation:[self xx_alphaAnimation] forKey:kFlickerAnimation];
            view.hidden = YES;
            [textField addSubview:view];
            [self.flickerArray addObject:view];
        }
        if (_config.secureTextEntry) {
            textField.secureTextEntry = _config.secureTextEntry;
        }
        if (_config.font){
            textField.font = _config.font;
        }
        if (_config.textColor) {
            textField.textColor = _config.textColor;
        }
        if (_config.showUnderLine) {
            CGFloat x = (inputBoxWidth-_config.underLineSize.width)/2.0;
            CGFloat y = (inputBoxHeight-_config.underLineSize.height);
            CGRect frame = CGRectMake(x, y, _config.underLineSize.width, _config.underLineSize.height);
            
            UIView *underLine = [[UIView alloc] init];
            underLine.tag = 100;
            underLine.frame = frame;
            underLine.backgroundColor = _config.underLineColor;
            [textField addSubview:underLine];
            
        }
        
        textField.tag = i;
        textField.userInteractionEnabled = NO;
        [self addSubview:textField];
        [self.textArray addObject:textField];
    }
    
    [self addGestureRecognizer:({
        [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(xx_tap)];
    })];
    
    _textView = [[UITextField alloc] init];
    _textView.frame = CGRectMake(0, CGRectGetHeight(frame), 0, 0);
    _textView.keyboardType = _config.keyboardType;
    _textView.hidden = YES;
    if (@available(iOS 12.0, *)) {
        // 读取短信
        _textView.textContentType = UITextContentTypeOneTimeCode;
    }
    [self addSubview:_textView];
    _textView.delegate = self;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(xx_textChange:) name:UITextFieldTextDidChangeNotification object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(xx_didBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    if (_config.autoShowKeyboard) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_config.autoShowKeyboardDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.textView becomeFirstResponder];
        });
    }
}

- (CABasicAnimation *)xx_alphaAnimation {
    CABasicAnimation *alpha = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alpha.fromValue = @(1.0);
    alpha.toValue = @(0.0);
    alpha.duration = 1.0;
    alpha.repeatCount = CGFLOAT_MAX;
    alpha.removedOnCompletion = NO;
    alpha.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    return alpha;
}

- (void)xx_tap {
    [_textView becomeFirstResponder];
}

- (void)xx_didBecomeActive {
    // restart Flicker Animation
    if (_config.showFlickerAnimation && _textView.text.length < self.textArray.count) {
        
        if (self.flickerArray.count && _textView.text.length < self.flickerArray.count) {
            UIView *view = self.flickerArray[_textView.text.length];
            [view.layer removeAnimationForKey:kFlickerAnimation];
            [view.layer addAnimation:[self xx_alphaAnimation] forKey:kFlickerAnimation];
        }
    }
}

- (void)xx_textChange:(NSNotification *)noti {
    //NSLog(@"%@",noti.object);
    if (_textView != noti.object) {
        return;
    }
    
    // set default
    [self xx_setDefault];
    
    // trim space
    NSString *text = [_textView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    // number & alphabet
    NSMutableString *mstr = @"".mutableCopy;
    for (int i = 0; i < text.length; ++i) {
        unichar c = [text characterAtIndex:i];
        if (_config.inputType == YXBVCConfigInputType_Number_Alphabet) {
            if ((c >= '0' && c <= '9') ||
                (c >= 'A' && c <= 'Z') ||
                (c >= 'a' && c <= 'z')) {
                [mstr appendFormat:@"%c",c];
            }
        }else if (_config.inputType == YXBVCConfigInputType_Number) {
            if ((c >= '0' && c <= '9')) {
                [mstr appendFormat:@"%c",c];
            }
        }else if (_config.inputType == YXBVCConfigInputType_Alphabet) {
            if ((c >= 'A' && c <= 'Z') ||
                (c >= 'a' && c <= 'z')) {
                [mstr appendFormat:@"%c",c];
            }
        }
    }
    
    text = mstr;
    NSInteger count = _config.inputBoxNumber;
    if (text.length > count) {
        text = [text substringToIndex:count];
    }
    _textView.text = text;
    if (_inputBlock) {
        _inputBlock(text);
    }
    
    // set value
    [self xx_setValue:text];
    
    // Flicker Animation
    [self xx_flickerAnimation:text];
    
    if (_inputFinish) {
        [self xx_finish];
    }
}

- (void)xx_setDefault {
    for (int i = 0; i < _config.inputBoxNumber; ++i) {
        UITextField *textField = self.textArray[i];
        textField.text = @"";
        
        if (_config.inputBoxColor) {
            textField.layer.borderColor = _config.inputBoxColor.CGColor;
        }
        if (_config.showFlickerAnimation) {
            if (self.flickerArray.count && self.flickerArray.count > i) {
                UIView *view = self.flickerArray[i];
                view.hidden = YES;
                [view.layer removeAnimationForKey:kFlickerAnimation];
            }
        }
        if (_config.showUnderLine) {
            UIView *underLine = [textField viewWithTag:100];
            underLine.backgroundColor = _config.underLineColor;
        }
    }
}

// 闪烁动画，控制光标闪烁的
- (void)xx_flickerAnimation:(NSString *)text {
    if (_config.showFlickerAnimation && text.length < self.textArray.count) {
        
        if (self.flickerArray.count && text.length < self.flickerArray.count) {
            UIView *view = self.flickerArray[text.length];
            view.hidden = NO;
            [view.layer addAnimation:[self xx_alphaAnimation] forKey:kFlickerAnimation];
        }
    }
}

- (void)xx_setValue:(NSString *)text {
    _inputFinish = (text.length == _config.inputBoxNumber);
    
    for (int i = 0; i < text.length; ++i) {
        unichar c = [text characterAtIndex:i];
        UITextField *textField = self.textArray[i];
        textField.text = [NSString stringWithFormat:@"%c",c];
        if (!textField.secureTextEntry && _config.customInputHolder.length > 0) {
            textField.text = _config.customInputHolder;
        }
        
        // Input Status
        UIFont *font = _config.font;
        UIColor *color = _config.textColor;
        UIColor *inputBoxColor = _config.inputBoxHighlightedColor;
        UIColor *underLineColor = _config.underLineHighlightedColor;
        
        // Finish Status
        if (_inputFinish) {
            if (_inputFinishIndex < _config.finishFonts.count) {
                font = _config.finishFonts[_inputFinishIndex];
            }
            if (_inputFinishIndex <  _config.finishTextColors.count) {
                color = _config.finishTextColors[_inputFinishIndex];
            }
            if (_inputFinishIndex < _config.inputBoxFinishColors.count) {
                inputBoxColor = _config.inputBoxFinishColors[_inputFinishIndex];
            }
            if (_inputFinishIndex < _config.underLineFinishColors.count) {
                underLineColor = _config.underLineFinishColors[_inputFinishIndex];
            }
        }
        
        textField.font = font;
        textField.textColor = color;
        
        if (inputBoxColor) {
            textField.layer.borderColor = inputBoxColor.CGColor;
        }
        if (_config.showUnderLine && underLineColor) {
            UIView *underLine = [textField viewWithTag:100];
            underLine.backgroundColor = underLineColor;
        }
    }
}

- (void)xx_finish {
    if (_finishBlock) {
        _finishBlock(self, _textView.text);
    }
}

#pragma mark - public

- (NSString *)text {
    return _textView.text;
}

- (void)clear {
    _textView.text = @"";
    
    [self xx_setDefault];
    [self xx_flickerAnimation:_textView.text];
}

- (void)showInputFinishColorWithIndex:(NSUInteger)index {
    _inputFinishIndex = index;
    
    [self xx_setValue:_textView.text];
}

@end
