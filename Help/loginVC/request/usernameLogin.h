//
//  usernameLogin.h
//  Help
//
//  Created by GM on 2018/9/19.
//  Copyright © 2018年 Ugliest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface usernameLogin : NSObject
+ (void)usernameInfo:(NSDictionary *)dic
        LoginSuccess:(void(^)(NSDictionary * dic))success
             failure:(void(^)(NSError *error))failure;
@end
