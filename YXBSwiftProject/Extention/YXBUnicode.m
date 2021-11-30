//
//  YXBUnicode.m
//  YingXingBoss
//
//  Created by 杨 on 2018/4/14.
//  Copyright © 2018年 杨. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

static inline void yxb_swizzleSelector(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    if (class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@implementation NSString (YXBUnicode)

- (NSString *)stringByReplaceUnicode {
    NSMutableString *convertedString = [self mutableCopy];
    [convertedString replaceOccurrencesOfString:@"\\U"
                                     withString:@"\\u"
                                        options:0
                                          range:NSMakeRange(0, convertedString.length)];
    
    CFStringRef transform = CFSTR("Any-Hex/Java");
    CFStringTransform((__bridge CFMutableStringRef)convertedString, NULL, transform, YES);
    return convertedString;
}

@end

@implementation NSArray (YXBUnicode)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        yxb_swizzleSelector(class, @selector(description), @selector(yxb_description));
        yxb_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(yxb_descriptionWithLocale:));
        yxb_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(yxb_descriptionWithLocale:indent:));
    });
}

/**
 *  我觉得
 *  可以把以下的方法放到一个NSObject的category中
 *  然后在需要的类中进行swizzle
 *  但是又觉得这样太粗暴了。。。。
 */

- (NSString *)yxb_description {
    return [[self yxb_description] stringByReplaceUnicode];
}

- (NSString *)yxb_descriptionWithLocale:(nullable id)locale {
    return [[self yxb_descriptionWithLocale:locale] stringByReplaceUnicode];
}

- (NSString *)yxb_descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [[self yxb_descriptionWithLocale:locale indent:level] stringByReplaceUnicode];
}

@end

@implementation NSDictionary (YXBUnicode)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        yxb_swizzleSelector(class, @selector(description), @selector(yxb_description));
        yxb_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(yxb_descriptionWithLocale:));
        yxb_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(yxb_descriptionWithLocale:indent:));
    });
}

- (NSString *)yxb_description {
    return [[self yxb_description] stringByReplaceUnicode];
}

- (NSString *)yxb_descriptionWithLocale:(nullable id)locale {
    return [[self yxb_descriptionWithLocale:locale] stringByReplaceUnicode];
}

- (NSString *)yxb_descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [[self yxb_descriptionWithLocale:locale indent:level] stringByReplaceUnicode];
}

@end

@implementation NSSet (YXBUnicode)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        yxb_swizzleSelector(class, @selector(description), @selector(yxb_description));
        yxb_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(yxb_descriptionWithLocale:));
        yxb_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(yxb_descriptionWithLocale:indent:));
    });
}

- (NSString *)yxb_description {
    return [[self yxb_description] stringByReplaceUnicode];
}

- (NSString *)yxb_descriptionWithLocale:(nullable id)locale {
    return [[self yxb_descriptionWithLocale:locale] stringByReplaceUnicode];
}

- (NSString *)yxb_descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [[self yxb_descriptionWithLocale:locale indent:level] stringByReplaceUnicode];
}

@end

