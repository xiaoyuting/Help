//
//  DBInfo.h
//  Help
//
//  Created by GM on 2018/9/19.
//  Copyright © 2018年 Ugliest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBInfo : NSObject
+ (void)saveToken:(NSString *)token ;
 
+ (NSString *)getToken ;

+ (void)saveInfo:(NSDictionary *) Dic;

+ (NSDictionary *)getInfo ;

+ (void)saveLoadStatus:(int)status ;

+ (int)getLoginStatus;

+ (void)savePersonInfo:(NSDictionary *)dic;

+ (NSDictionary *)getPersonInfo;

@end
