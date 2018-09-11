//
//  userModel.m
//  Help
//
//  Created by GM on 2018/8/30.
//  Copyright © 2018年 Ugliest. All rights reserved.
//

#import "userModel.h"

@implementation userModel
//变量名转换
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{
    
    return @{
             @"userid":@"id"
             
             };
}
// Dic -> model
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    self.userid = dic[@"id"];
    
    
    return YES;
}

// model -> Dic
- (BOOL)modelCustomTransformToDictionary:(NSMutableDictionary *)dic {
    
    dic[@"id"] =self.userid;
    
    
    return YES;
}
@end
