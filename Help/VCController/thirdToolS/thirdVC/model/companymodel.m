//
//  companymodel.m
//  Help
//
//  Created by GM on 2018/9/10.
//  Copyright © 2018年 Ugliest. All rights reserved.
//

#import "companymodel.h"

@implementation companymodel
//变量名转换
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{
    
    return @{
             @"comid":@"id",
             @"descrip":@"description"
             
             };
}
// Dic -> model
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    self.comid = dic[@"id"];
    self.descrip =dic[@"description"];
    
    return YES;
}

// model -> Dic
- (BOOL)modelCustomTransformToDictionary:(NSMutableDictionary *)dic {
    
    dic[@"id"] =self.comid;
    dic[@"description"]=self.descrip;
    
    return YES;
}
@end
