//
//  usermedModel.m
//  Help
//
//  Created by GM on 2018/8/30.
//  Copyright © 2018年 Ugliest. All rights reserved.
//

#import "usermedModel.h"
#import "mediaModel.h"
@implementation usermedModel
//变量名转换
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{
    
    return @{
             @"mediaid":@"id"
             
             };
}
// Dic -> model
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    self.mediaid = dic[@"id"];
    
    
    return YES;
}

// model -> Dic
- (BOOL)modelCustomTransformToDictionary:(NSMutableDictionary *)dic {
    
    dic[@"id"] =self.mediaid;
    
    
    return YES;
}
// 数组变量
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"media"        : [mediaModel class]
             
             };
}

@end
