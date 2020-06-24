//
//  NSLayoutConstraint+AutoScale.m
//  SmartCity
//
//  Created by ZCGC on 2017/8/22.
//  Copyright © 2017年 NRH. All rights reserved.
//

#import "NSLayoutConstraint+AutoScale.h"
#import <objc/runtime.h>


@implementation NSLayoutConstraint (AutoScale)

+ (void)load{
    NSArray *originalSelectors = @[@"setConstant:"];
    
    for (NSString *selectorName in originalSelectors) {
        SEL originalSelector = NSSelectorFromString(selectorName);
        SEL swizzledSelector = NSSelectorFromString([@"sp_" stringByAppendingString:selectorName]);
        
        Method originalMethod = class_getInstanceMethod(self, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(self,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(self,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
            
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    }
}

- (void)sp_setConstant:(CGFloat)constant {
    if (self.autoScale) {
        constant *= screenWidthScaleBase375();
    }
    return [self sp_setConstant:constant];
}

- (void)setAutoScale:(BOOL)autoScale {
    if (autoScale == self.autoScale)
        return;
    
    objc_setAssociatedObject(self, "autoScale", @(autoScale), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    if (self.constant == 0)
        return;
    
    if (autoScale) {
        return [self sp_setConstant:self.constant * screenWidthScaleBase375()];
    }else{
        return [self sp_setConstant:self.constant / screenWidthScaleBase375()];
    }
}
- (BOOL)autoScale {
    return [objc_getAssociatedObject(self, "autoScale") boolValue];
}

@end
