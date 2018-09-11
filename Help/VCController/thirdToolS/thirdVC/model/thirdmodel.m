//
//  thirdmodel.m
//  Help
//
//  Created by GM on 2018/9/10.
//  Copyright © 2018年 Ugliest. All rights reserved.
//

#import "thirdmodel.h"
#import "companymodel.h"
@implementation thirdmodel
// 数组变量
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"data"        : [companymodel class]
             };
}

@end
