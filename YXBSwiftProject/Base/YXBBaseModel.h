//
//  YXBBaseModel.h
//  YunXiaoZhi
//
//  Created by YangXiaoBin on 2019/10/17.
//  Copyright © 2019 YangXiaoBin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IGListKit/IGListKit.h>
#import <YYModel/YYModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXBBaseModel : NSObject <NSCoding, NSCopying, IGListDiffable>

@end

NS_ASSUME_NONNULL_END

//+ (NSDictionary *)modelCustomPropertyMapper {
//    return @{@"cutType" : @"cut_type"};
//}

//+ (NSDictionary *)modelContainerPropertyGenericClass {
//    return @{@"nowSeckillList" : [YXBBaseModel class]};
//}

//// 当 JSON 转为 Model 完成后，该方法会被调用。
//// 你可以在这里对数据进行校验，如果校验不通过，可以返回 NO，则该 Model 会被忽略。
//// 你也可以在这里做一些自动转换不能完成的工作。
//- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
//    NSNumber *timestamp = dic[@"timestamp"];
//    if (![timestamp isKindOfClass:[NSNumber class]]) return NO;
//    _createdAt = [NSDate dateWithTimeIntervalSince1970:timestamp.floatValue];
//    return YES;
//}
//
//// 当 Model 转为 JSON 完成后，该方法会被调用。
//// 你可以在这里对数据进行校验，如果校验不通过，可以返回 NO，则该 Model 会被忽略。
//// 你也可以在这里做一些自动转换不能完成的工作。
//- (BOOL)modelCustomTransformToDictionary:(NSMutableDictionary *)dic {
//    if (!_createdAt) return NO;
//    dic[@"timestamp"] = @(n.timeIntervalSince1970);
//    return YES;
//}
