//
//  infoModel.m
//  Help
//
//  Created by GM on 2018/8/30.
//  Copyright © 2018年 Ugliest. All rights reserved.
//

#import "infoModel.h"
#import "usermedModel.h"
@implementation infoModel
// 数组变量
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"data"        : [usermedModel class]
             
             };
}

@end
