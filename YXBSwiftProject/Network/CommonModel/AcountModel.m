//
//  AcountModel.m
//  PKSQProject
//
//  Created by ShengChang on 2019/11/22.
//  Copyright © 2019 ShengChang. All rights reserved.
//

#import "AcountModel.h"

@implementation AcountModel

//// 当 JSON 转为 Model 完成后，该方法会被调用。
//// 你可以在这里对数据进行校验，如果校验不通过，可以返回 NO，则该 Model 会被忽略。
//// 你也可以在这里做一些自动转换不能完成的工作。
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _useCoin = getReviseNumberData(dic[@"useCoin"]);
    _useMoney = getReviseNumberData(dic[@"useMoney"]);
    _usePoint = getReviseNumberData(dic[@"usePoint"]);
    _useUsdt = getReviseNumberData(dic[@"useUsdt"]);
    _lockUsdt = getReviseNumberData(dic[@"lockUsdt"]);
    _lockMoney = getReviseNumberData(dic[@"lockMoney"]);
    return YES;
}

@end
