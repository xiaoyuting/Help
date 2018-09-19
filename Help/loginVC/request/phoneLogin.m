//
//  phoneLogin.m
//  Help
//
//  Created by GM on 2018/9/19.
//  Copyright © 2018年 Ugliest. All rights reserved.
//

#import "phoneLogin.h"

@implementation phoneLogin
+ (void)phoneInfo:(NSDictionary *)dic
        LoginSuccess:(void(^)(NSDictionary * dic))success
             failure:(void(^)(NSError *error))failure{
    [RequestManager requestWithType:HttpRequestTypePost
                          urlString:URL_loginPhone
                         parameters:dic successBlock:^(id response) {
                             success(response);
                         } failureBlock:^(NSError *error) {
                             failure(error);
                         } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                             
                         }];
}
@end
