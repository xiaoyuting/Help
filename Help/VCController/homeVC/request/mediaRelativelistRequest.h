//
//  mediaRelativelistRequest.h
//  Help
//
//  Created by GM on 2018/9/20.
//  Copyright © 2018年 Ugliest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface mediaRelativelistRequest : NSObject
+ (void)mediaRelativelistRequestInfo:(NSDictionary *)dic
                             Success:(void(^)(NSDictionary * dic))success
                             failure:(void(^)(NSError * error))failure;
@end
