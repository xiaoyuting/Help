//
//  mediaRelativelistRequest.m
//  Help
//
//  Created by GM on 2018/9/20.
//  Copyright © 2018年 Ugliest. All rights reserved.
//

#import "mediaRelativelistRequest.h"

@implementation mediaRelativelistRequest
+ (void)mediaRelativelistRequestInfo:(NSDictionary *)dic
                             Success:(void(^)(NSDictionary * dic))success
                             failure:(void(^)(NSError * error))failure{
    [RequestManager requestWithType:HttpRequestTypeGet
                          urlString:URL_media_relative_list
                         parameters:dic
                       successBlock:^(id response) {
                           success(response);
                       } failureBlock:^(NSError *error) {
                           failure(error);
                       } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                           
                       }];
}
@end
