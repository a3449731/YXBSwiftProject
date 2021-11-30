//
//  YXBFormTopBottomCell.m
//  MyProject
//
//  Created by YangXiaoBin on 2019/12/6.
//  Copyright © 2019 YangXiaoBin. All rights reserved.
//

#import "YXBFormTopBottomCell.h"


NSString *const YXBFormRowDescriptorTypeTopBottomCell = @"YXBFormRowDescriptorTypeTopBottomCell";

@interface YXBFormTopBottomCell () <QMUITextFieldDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) QMUITextField *textField;
@property (nonatomic, assign) UIKeyboardType keyboardType;

@property (nonatomic, assign) CGFloat textFieldHeight;

@end

@implementation YXBFormTopBottomCell

+ (void)load {
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:[YXBFormTopBottomCell class] forKey:YXBFormRowDescriptorTypeTopBottomCell];
}

- (void)configure {
    [super configure];
    [self creatUI];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.textField.keyboardType = self.keyboardType;
}

- (void)creatUI {
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    self.titleLabel.textColor = YXBColor_descriptionText_highLight;
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        
    }];
    
    self.textField = [[QMUITextField alloc] init];
    self.textField.delegate = self;
    self.textField.font = [UIFont systemFontOfSize:14];
    self.textField.textColor = YXBColor_descriptionText_highLight;
    [self.contentView addSubview:self.textField];
    [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_equalTo(10);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(-5);
    }];
    
    [self.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)update {
    [super update];
    // 设置占位符颜色
    self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.textField.placeholder attributes:@{NSForegroundColorAttributeName:YXBColor_subText}];
    self.titleLabel.text = self.rowDescriptor.title;
    self.textField.text = self.rowDescriptor.value ? [self.rowDescriptor displayTextValue] : self.rowDescriptor.noValueDisplayText;
}

// 修改键盘
- (void)setKeyboardType:(UIKeyboardType)keyboardType {
    if (_keyboardType != keyboardType) {
        _keyboardType = keyboardType;
        self.textField.keyboardType = keyboardType;
    }
}

- (void)setTextFieldHeight:(CGFloat)textFieldHeight {
    if (_textFieldHeight != textFieldHeight) {
        _textFieldHeight = textFieldHeight;
        [self.textField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(textFieldHeight);
        }];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [self.formViewController textField:textField shouldChangeCharactersInRange:range replacementString:string];
}

- (void)textFieldDidChange:(UITextField *)textField {
    if([self.textField.text length] > 0) {
        BOOL didUseFormatter = NO;
        
        if (self.rowDescriptor.valueFormatter && self.rowDescriptor.useValueFormatterDuringInput)
        {
            // use generic getObjectValue:forString:errorDescription and stringForObjectValue
            NSString *errorDescription = nil;
            NSString *objectValue = nil;
            
            if ([ self.rowDescriptor.valueFormatter getObjectValue:&objectValue forString:textField.text errorDescription:&errorDescription]) {
                NSString *formattedValue = [self.rowDescriptor.valueFormatter stringForObjectValue:objectValue];
                
                self.rowDescriptor.value = objectValue;
                textField.text = formattedValue;
                didUseFormatter = YES;
            }
        }
        
        // only do this conversion if we didn't use the formatter
        if (!didUseFormatter)
        {
            if ([self.rowDescriptor.rowType isEqualToString:XLFormRowDescriptorTypeNumber] || [self.rowDescriptor.rowType isEqualToString:XLFormRowDescriptorTypeDecimal]){
                self.rowDescriptor.value =  [NSDecimalNumber decimalNumberWithString:self.textField.text locale:NSLocale.currentLocale];
            } else if ([self.rowDescriptor.rowType isEqualToString:XLFormRowDescriptorTypeInteger]){
                self.rowDescriptor.value = @([self.textField.text integerValue]);
            } else {
                self.rowDescriptor.value = self.textField.text;
            }
        }
    } else {
        self.rowDescriptor.value = nil;
    }
}

-(void)dealloc {
    [self.textField removeTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.textField.delegate = nil;
}

@end
