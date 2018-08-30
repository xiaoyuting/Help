//
//  ugliestTools.h
//  ugliestSDK
//
//  Created by ugliest on 2018/3/23.
//  Copyright © 2018年 ugliest. All rights reserved.
//

#import <Foundation/Foundation.h>
 
#import <UIKit/UIKit.h>

@interface ugliestTools : NSObject

 


/**
 删除列表中的数据
 
 @param index 需要删除账户的位置
 @return 返回值YES 代表 证明本地还有账户  返回值NO  代表 证明本地已经没有账户了
 */
+ (BOOL) userNameDeleteToPlist:(NSInteger ) index;

/**
 设置下次是否自动登录
 
 @param isFast YES自动登录，NO不自动登录
 */
+(void)setFastLogin:(BOOL)isFast;

/**
 判断是否自动登录
 
 @return YES自动登录，NO不自动登录
 */
+(BOOL)getFastLogin;


/**
 获取设备唯一标示
 
 @return 设备唯一标示
 */
+(NSString*)getDeviceId;

/**
 获取设备存储路径
 
 @return 设备存储路径
 */
+(NSString*)getSDCardPath;


/**
 获取随机字符串（字符串包含字母，数字）
 
 @param randomlength 字符串长度
 @return 随机数
 */
+(NSString*)getRandomStr:(int)randomlength;

/**
 MD5加密算法(secretkey 没有改变，也就是常说的没有加盐)
 
 @param secretKey 需要MD5的string
 @return 加密后的字符串
 */
+(NSString*)md5:(NSString*)secretKey;

/**
 获取当前游戏方向
 
 @return 返回的方向
 */
+(UIInterfaceOrientation)getOrientation;

/**
 判断是否是手机号码
 
 @param str 手机号
 @return  NO 不是手机号，YES 是手机号
 */
+(Boolean)isPhone:(NSString*)str;

/**
 判断是否是邮箱
 
 @param str 输入的邮箱
 @return NO不是邮箱，YES是邮箱
 */
+(Boolean)isEmail:(NSString*)str;

/**
 获取versionCode
 
 @return 返回游戏当前版本
 */
+(float)getVersionCode;

/**
 获取当前的应用名字
 
 @return 应用的名字
 */
+(NSString*)getApplicationName;

/**
 获取当前应用的bundleID
 
 @return 应用的bundleID
 */
+(NSString*)getBundleID;
/**
 获取手机系统版本
 
 @return 手机系统
 */
+(NSString *)phoneVersion;

/**
 判断 String 是否为空
 
 @param str 需要判断的String
 @return  YES 为空，NO 不为空
 */
+(Boolean)isStrEmpty:(NSString*)str;


/**
 返回当前时间的时间戳
 
 @return 时间戳
 */
+ (NSString*) getNowTimes;

/**
 根据字典 计算自己的sign值
 
 @param keyDic 字典数据
 @param key 签名的key
 @return 返回的签名数据
 */
+ (NSString*) transformSighKey:(NSDictionary *)keyDic Key:(NSString*)key;

/**
 把格式化的JSON格式的字符串转换成字典
 
 @param jsonString json 格式的 String
 @return 返回的字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/**
 字典转换为json字符串
 
 @param dic 需要转换的字典
 @return json 类型的字符串
 */
+ (NSString *) dictionaryToString:(NSDictionary *)dic;

/**
 判断是否由数字和26个英文字母组成的字符串
 
 @param data 数据
 @return  YES 是，NO 不是
 */
+ (BOOL) checkForNumberAndCase:(NSString *)data;


/**
 判断是否由26位小写字母
 
 @param data 数据
 @return YES 是，NO 不是
 */
+ (BOOL) checkForLowerCase:(NSString *)data;

/**
 判断是否由26位大写字母
 
 @param data 数据
 @return YES 是，NO 不是
 */
+ (BOOL) checkForUpperCase:(NSString *)data;

/**
 判断是否由26个小写英文字母组成的字符串
 
 @param data 字符串
 @return YES 是，NO 不是
 */
+ (BOOL) checkForLowerAndUpperCase:(NSString *)data;


/**
 判断是否含有特殊字符
 
 @param data 数据
 @return  YES 有，NO 没有
 */
+ (BOOL) checkForSpecialChar:(NSString *)data;

/**
 判断是否是全部数字
 
 @param number 数字
 @return  YES 是，NO 否
 */
+ (BOOL) checkForNumber:(NSString *)number;

/**
 判断是否是指定长度的数字
 
 @param length 长度
 @param number 数字
 @return YES 是，NO 否
 */
+ (BOOL) checkForNumberWithLength:(NSString *)length number:(NSString *)number;

/**
 判断是否是字母开通
 
 @param username 字符串
 @return YES 是，NO 否
 */
+ (BOOL) checkForUsername:(NSString *)username;

/**
 判断是否含有空格
 
 @param username 需要判断的 String
 @return YES 有，NO 没有
 */
+ (BOOL) checkForBlank:(NSString *)username;

/**
 获取指定 bundle 内的图片
 

 @param imageName 图片名字
 @return 读取后的图片资源
 */
+(UIImage*)getImageFromBundleImage:(NSString*)imageName;

/**
 删除 View 的所有子节点
 
 @param mView 需要删除子节点的 view
 */
+(void)removeAllViewChildren:(UIView*)mView;

/**
 View 自动适配大小
 
 @param mView 需要缩放的View
 */
+(void)viewFit:(UIView*)mView;

/**
 取消缩放适配
 
 @param mView 需要取消缩放的View
 */
+(void)viewFitCancel:(UIView*)mView;

/**
 获取网络状态
 
 @return 网络状态
 */
+(NSString *)getNetWorkStates;

/**
 读取配置表的 String
 
 @param str key 键
 @return 读取到的 String
 */
+(NSString*)getString:(NSString*)str;

/**
 获取系统语言设置
 */
+ (void)setLangueage;

/**
 判断是否能连接到指定的服务器
 
 @param Url 服务器地址
 @return  YES 能，NO 不能
 */
+(Boolean)isNetWork:(NSString*)Url;


/**
 Dictionary转成 url 用的 String
 
 @param dictionary  需要转换的Dictionary
 @return 转换后的 String
 */
+(NSString*)DictionaryTOUrlString:(NSDictionary*)dictionary;

/**
 读取配置表的 String
 
 @param color key 键
 @return 读取到的颜色
 */
+(UIColor *)getColor:(NSString *)color;

/**
 读取配置表的 String
 
 @param sender key 键
 */
+ (void)setButton:(UIButton *)sender  CAGradientLayer:(CGRect)rect;
/**
 提示显示
 
 */

@end
