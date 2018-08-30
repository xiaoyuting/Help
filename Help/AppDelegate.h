//
//  AppDelegate.h
//  Help
//
//  Created by GM on 2018/8/30.
//  Copyright © 2018年 Ugliest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (instancetype)sharedAppDelegate;

@end

