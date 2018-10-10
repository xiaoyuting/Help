//
//  userPicRequest.h
//  Help
//
//  Created by GM on 2018/10/8.
//  Copyright © 2018年 Ugliest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface userPicRequest : NSObject
+ (void)userPicRequestInfo:(NSDictionary *)dic
                   Success:(void(^)(NSDictionary *info))success
                      failure:(void(^)(NSError *error))failure;
@end
