//
//  CDDetailHeaderView.m
//  MyProject
//
//  Created by 杨 on 23/12/2019.
//  Copyright © 2019 YangXiaoBin. All rights reserved.
//

#import "CDDetailHeaderView.h"
#import <DateTools/DateTools.h>

@interface CDDetailHeaderView ()

@end

@implementation CDDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    UIView *view =  [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    view.frame = self.bounds;
    [self addSubview:view];
    
    self.phoneButton.imagePosition = QMUIButtonImagePositionTop;
}

- (void)headerForModel:(id)model {
    
}

- (IBAction)phoneAction:(QMUIButton *)sender {
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"13812341234"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:nil];
}

@end
