//
//  userPicRequest.m
//  Help
//
//  Created by GM on 2018/10/8.
//  Copyright © 2018年 Ugliest. All rights reserved.
//

#import "userPicRequest.h"

@implementation userPicRequest
+ (void)userPicRequestInfo:(NSDictionary *)dic
                   Success:(void(^)(NSDictionary *info))success
                   failure:(void(^)(NSError *error))failure{
    [RequestManager requestWithType:HttpRequestTypeGet
                          urlString:URL_user_pic
                         parameters:dic
                       successBlock:^(id response) {
                           success(response);
    } failureBlock:^(NSError *error) {
        failure(error);
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}
@end
