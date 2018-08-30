//
//  AppDelegate+AppService.h
//  HELPXY
//
//  Created by GM on 2018/5/16.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "AppDelegate.h"
#import "RootBaseBar.h"
#import "RootBaseNav.h"
#import "loginVC.h"
@interface AppDelegate (AppService) 
//初始化服务
-(void)initServiceapplication:(UIApplication *)application  didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

//初始化 window
-(void)initWindow;

//初始化 UMeng
-(void)initUMeng;

//初始化用户系统
-(void)initUserManager;

//监听网络状态
- (void)monitorNetworkStatus;

//键盘
-(void)setKeyboardManager;

//引导图
-(void)setLaunchfirst;

- (void) cinViewLogin;
- (void) cinViewTabbar;
@end
