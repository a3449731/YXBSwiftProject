//
//  YXBFormButtonValueCell.m
//  NIM
//
//  Created by YangXiaoBin on 2020/4/15.
//  Copyright © 2020 Netease. All rights reserved.
//

#import "YXBFormButtonValueCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

NSString *const YXBFormRowDescriptorTypeButtonValueCell = @"YXBFormRowDescriptorTypeButtonValueCell";

@interface YXBFormButtonValueCell ()

@end

@implementation YXBFormButtonValueCell

+ (void)load {
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:[YXBFormButtonValueCell class] forKey:YXBFormRowDescriptorTypeButtonValueCell];
}

- (void)configure {
    [super configure];
    [self creatUI];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)creatUI {

}

- (void)update {
    [super update];
}

@end
