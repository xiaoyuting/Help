//
//  DBInfo.m
//  Help
//
//  Created by GM on 2018/9/19.
//  Copyright © 2018年 Ugliest. All rights reserved.
//

#import "DBInfo.h"

@implementation DBInfo
+ (void)saveToken:(NSString *)token{
    NSString * path  =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString * filepath = [path stringByAppendingPathComponent:@"token.txt"];

    [token writeToFile:filepath  atomically:YES encoding:NSUTF8StringEncoding error:nil];
 
    
}
+ (NSString *)getToken{
    NSString * path  =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString * filepath = [path stringByAppendingPathComponent:@"token.txt"];
    NSString * str = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:nil];

    if (str){
        return  str;
    
    }
    return nil;
}

+ (void)saveInfo:(NSDictionary *)dic{
    NSString * path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES).lastObject;
    NSString * filePath =[path stringByAppendingPathComponent:@"info.plist"];
    [dic writeToFile:filePath atomically:YES];
}

+ (NSDictionary *)getInfo{
    NSString * path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES).lastObject;
    NSString * filePath =[path stringByAppendingPathComponent:@"info.plist"];
    NSDictionary * dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    if (dic){
        return dic;
    }
    
    return nil;
}
#pragma  mark status 0 未登录 1 已登录
+ (void)saveLoadStatus:(int)status {
    NSString * path  =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString * filepath = [path stringByAppendingPathComponent:@"loginstatus.txt"];
    
    [[NSString stringWithFormat:@"%d",status] writeToFile:filepath  atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
}

+ (int)getLoginStatus{
    NSString * path  =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString * filepath = [path stringByAppendingPathComponent:@"loginstatus.txt"];
    NSString * str = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:nil];
    
    if (str){
        return  [str intValue];
        
    }
    return 0;
}


+ (void)savePersonInfo:(NSDictionary *)dic{
    NSString * path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES).lastObject;
    NSString * filePath =[path stringByAppendingPathComponent:@"personinfo.plist"];
    [dic writeToFile:filePath atomically:YES];
}

+ (NSDictionary *)getPersonInfo{
    NSString * path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES).lastObject;
    NSString * filePath =[path stringByAppendingPathComponent:@"personinfo.plist"];
    NSDictionary * dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    if (dic){
        return dic;
    }
    
    return nil;
}
@end
