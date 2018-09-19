//
//  AppDelegate+AppService.m
//  HELPXY
//
//  Created by GM on 2018/5/16.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "AppDelegate+AppService.h"
#import "DBInfo.h"
#define LOG_EXPIRE_TIME -7 * 24 * 60 * 60
@implementation AppDelegate (AppService)
-(void)initServiceapplication:(UIApplication *)application  didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    [self cinViewLogin];
    if([DBInfo getLoginStatus]==1){
        [self cinViewTabbar];
    }else{
        [self cinViewLogin];
    }
    
}
- (void) cinViewLogin{
    loginVC  * login = [[loginVC alloc]init];
    RootBaseNav * nav = [[RootBaseNav alloc]initWithRootViewController:login ];
    self.window.rootViewController = nav ;
}
- (void) cinViewTabbar{
    self.window.rootViewController =[[RootBaseBar alloc]init];
}
@end
