//
//  getPersonInfoRequest.h
//  Help
//
//  Created by GM on 2018/9/19.
//  Copyright © 2018年 Ugliest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface getPersonInfoRequest : NSObject
+ (void)getPersonInfoSuccess:(void(^)(NSDictionary * dic))success
                              failure:(void(^)(NSError * error ))failure;
@end
