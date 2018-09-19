//
//  relativeUsersRequest.m
//  Help
//
//  Created by GM on 2018/9/19.
//  Copyright © 2018年 Ugliest. All rights reserved.
//

#import "relativeUsersRequest.h"

@implementation relativeUsersRequest
+(void)profileRelativeUsersSuccess:(void(^)(NSDictionary * dic))success
                           failure:(void(^)(NSError * error))failure{
    [RequestManager requestWithType:HttpRequestTypeGet
                          urlString:URL_relative_user
                         parameters:nil
                       successBlock:^(id response) {
        success(response);
    }
                       failureBlock:^(NSError *error) {
        failure(error);
    }
                           progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
}
@end
