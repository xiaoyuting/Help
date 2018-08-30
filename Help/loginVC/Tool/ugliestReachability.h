/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 Basic demonstration of how to use the SystemConfiguration Reachablity APIs.
 */

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>
 


/**
 网络状态

 - ugliestNotReachable: 没有网络
 - ugliestReachableViaWiFi:  WiFi 网络
 - ugliestReachableViaWWAN: 手机网络
 */
typedef NS_ENUM(NSInteger, ugliestNetworkStatus) {
    /** 没有网络 */
	ugliestNotReachable = 0,
    /** WiFi 网络 */
	ugliestReachableViaWiFi,
    /** 手机网络 */
	ugliestReachableViaWWAN
};

#pragma mark IPv6 Support

extern NSString *kugliestReachabilityChangedNotification;


/**
 获取链接指定服务器的网络状态
 */
@interface ugliestReachability : NSObject

/**
 初始化并设置服务器地址

 @param hostName 地址
 @return 返回实例
 */
+ (instancetype)reachabilityWithHostName:(NSString *)hostName;

/**
 初始化并设置服务器地址

 @param hostAddress 地址
 @return 返回实例
 */
+ (instancetype)reachabilityWithAddress:(const struct sockaddr *)hostAddress;

/*!
 * Checks whether the default route is available. Should be used by applications that do not connect to a particular host.
 */
+ (instancetype)reachabilityForInternetConnection;


#pragma mark reachabilityForLocalWiFi
//reachabilityForLocalWiFi has been removed from the sample.  See ReadMe.md for more information.
//+ (instancetype)reachabilityForLocalWiFi;

/*!
 * Start listening for reachability notifications on the current run loop.
 */
- (BOOL)startNotifier;
- (void)stopNotifier;

- (ugliestNetworkStatus)currentReachabilityStatus;

/*!
 * WWAN may be available, but not active until a connection has been established. WiFi may require a connection for VPN on Demand.
 */
- (BOOL)connectionRequired;

@end


