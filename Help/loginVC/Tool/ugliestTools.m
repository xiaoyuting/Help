//
//  ugliestTools.m
//  ugliestSDK
//
//  Created by ugliest on 2018/3/23.
//  Copyright © 2018年 ugliest. All rights reserved.
//

#import "ugliestTools.h"

#import <CommonCrypto/CommonDigest.h>
#import "ugliestReachability.h"

static NSString *appLanguage = @"appLanguage";
#define ACCOUNTNUMBER 5 //账号数量
@implementation ugliestTools


/**
 设置下次是否自动登录
 
 @param isFast YES自动登录，NO不自动登录
 */
+(void)setFastLogin:(BOOL)isFast
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (isFast == NO) {
        [userDefaults removeObjectForKey:@"isFast"];
        
    }
    else
    {
        [userDefaults setBool:isFast forKey:@"isFast"];
    }
    [userDefaults synchronize];
}

/**
 判断是否自动登录
 
 @return YES自动登录，NO不自动登录
 */
+(BOOL)getFastLogin
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL isFast =[[userDefaults objectForKey:@"isFast"] boolValue];
    return isFast;
}


/**
 获取设备唯一标示
 
 @return 设备唯一标示
 */
+(NSString*)getDeviceId
{
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

/**
 获取设备存储路径
 
 @return 设备存储路径
 */
+(NSString*)getSDCardPath
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString* cachesDir = [paths objectAtIndex:0];
    return cachesDir;
}


+(NSString*)getRandomStr:(int)randomlength
{
    NSString *kRandomAlphabet = @"acCDd45efijF36HghlGnq12rs78xMNkyzAVWXBEIJKvwLOtuPQRSmopTUbYZ09";
    NSMutableString *randomStr = [NSMutableString stringWithCapacity:10];
    for (NSInteger i = 0; i<randomlength; i++) {
        [randomStr appendFormat: @"%C", [kRandomAlphabet characterAtIndex:arc4random_uniform((u_int32_t)[kRandomAlphabet length])]];
    }
    return randomStr;
}

/**
 MD5加密算法(secretkey 没有改变，也就是常说的没有加盐)
 
 @param secretKey 需要MD5的string
 @return 加密后的字符串
 */
+(NSString*)md5:(NSString*)secretKey
{
    const char *cStr = [secretKey UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

/**
 获取当前游戏方向
 
 @return 返回的方向
 */
+(UIInterfaceOrientation)getOrientation
{
    return [UIApplication sharedApplication].statusBarOrientation;
}

/**
 判断是否是手机号码
 
 @param str 手机号
 @return  NO 不是手机号，YES 是手机号
 */
+(Boolean)isPhone:(NSString*)str
{
    if ((Nil == str) ||(str.length == 0)) {
        return NO;
    }
    NSString *regEx = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    return [self baseCheckForRegEx:regEx data:str];
}
/**
 判断是否是邮箱
 
 @param str 输入的邮箱
 @return NO不是邮箱，YES是邮箱
 */
+(Boolean)isEmail:(NSString*)str
{
    if ((Nil == str) ||(str.length == 0)) {
        return NO;
    }
    NSString *regEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self baseCheckForRegEx:regEx data:str];
}

/**
 获取versionCode
 
 @return 返回游戏当前版本
 */
+(float)getVersionCode
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString* versioncode = [infoDictionary objectForKey:@"CFBundleVersion"];
    return versioncode.floatValue;
}

/**
 获取当前的应用名字
 
 @return 应用的名字
 */
+(NSString*)getApplicationName
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString* Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    if (nil == Name) {
        Name =[infoDictionary objectForKey:@"CFBundleName"];
    }
    
    return Name;
}

/**
 获取当前应用的bundleID
 
 @return 应用的bundleID
 */
+(NSString*)getBundleID
{
    return [[NSBundle mainBundle] bundleIdentifier];
}
+(NSString *)phoneVersion{
    //1.手机系统版本：9.1
    
    NSString*  Version = [[UIDevice currentDevice] systemVersion];
    
    // 2.手机类型：iPhone 6
    
    //  NSString* phoneModel = [self iphoneType];//方法在下面
    
    //3.手机系统：iPhone OS
    
    // NSString * iponeM = [[UIDevice currentDevice] systemName];
    
    return  Version;
    
    
}
/**
 判断 String 是否为空
 
 @param str 需要判断的String
 @return  YES 为空，NO 不为空
 */
+(Boolean)isStrEmpty:(NSString*)str
{
    if (str == Nil || [str isEqual:@""] || str.length==0) {
        return YES;
    }
    return NO;
}

/**
 返回当前时间的时间戳
 
 @return 时间戳
 */
+ (NSString *) getNowTimes {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval timeInterval = [date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f",timeInterval];
    return timeString;
}
/**
 根据字典 计算自己的sign值
 
 @param keyDic 字典数据
 @param key 签名的key
 @return 返回的签名数据
 */
+ (NSString *) transformSighKey:(NSDictionary *)keyDic Key:(NSString*)key
{
    NSArray *keyArray = keyDic.allKeys;
    NSArray *sortArray = [keyArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    NSMutableString *md5Str = [[NSMutableString alloc]init];
    for (NSInteger i = 0 ; i<sortArray.count; i++) {
        NSString *str = [keyDic objectForKey:sortArray[i]];
        
        [md5Str appendFormat:@"%@",str];
    }
    [md5Str appendFormat:@"%@", key];
//    ugliestLog(@"签名前的数据：md5Str--》》%@",md5Str);
    return [ugliestTools md5:[md5Str copy]];
}

/**
 把格式化的JSON格式的字符串转换成字典
 
 @param jsonString json 格式的 String
 @return 返回的字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        //ugliestLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

/**
 字典转换为json字符串
 
 @param dic 需要转换的字典
 @return json 类型的字符串
 */
+ (NSString *) dictionaryToString:(NSDictionary *)dic {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *dataString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
   // ugliestLog(@"字典转换json字符串成功!");
    return dataString;
}

/**
 获取指定 bundle 内的图片
 
 
 @param imageName 图片名字
 @return 读取后的图片资源
 */
+(UIImage*)getImageFromBundleImage:(NSString*)imageName
{
  
    NSString * bundlePath = [[NSBundle mainBundle] pathForResource:@"ugliestBUNDLE" ofType :@"bundle"];
    NSString *pathOne = [bundlePath stringByAppendingPathComponent:@"image"];
  
    UIImage *image = [UIImage imageWithContentsOfFile:[pathOne stringByAppendingPathComponent:imageName]];
    return image;
}

/**
 删除 View 的所有子节点
 
 @param mView 需要删除子节点的 view
 */
+(void)removeAllViewChildren:(UIView*)mView
{
    for(UIView *view in [mView subviews])
    {
        [view removeFromSuperview];
    }
}

/**
 View 自动适配大小
 
 @param mView 需要缩放的View
 */
+(void)viewFit:(UIView*)mView
{
    if ([[UIApplication sharedApplication] statusBarOrientation]==UIInterfaceOrientationPortrait || [[UIApplication sharedApplication] statusBarOrientation]==UIInterfaceOrientationPortraitUpsideDown) {
        CGAffineTransform at =CGAffineTransformMakeScale([UIScreen mainScreen].bounds.size.width/414,[UIScreen mainScreen].bounds.size.width/414);
        [mView setTransform:at];
    }
    if ([[UIApplication sharedApplication] statusBarOrientation]==UIInterfaceOrientationLandscapeLeft || [[UIApplication sharedApplication] statusBarOrientation]==UIInterfaceOrientationLandscapeRight) {
        CGAffineTransform at =CGAffineTransformMakeScale([UIScreen mainScreen].bounds.size.height/414,[UIScreen mainScreen].bounds.size.height/414);
        [mView setTransform:at];
    }
}

/**
 取消缩放适配
 
 @param mView 需要取消缩放的View
 */
+(void)viewFitCancel:(UIView*)mView
{
    mView.transform = CGAffineTransformIdentity;
}

/**
 获取网络状态
 
 @return 网络状态
 */
+(NSString *)getNetWorkStates{
    
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    NSString *state = nil;
    int netType = 0;
    //获取到网络返回码
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            //获取到状态栏
            netType = [[child valueForKeyPath:@"dataNetworkType"] intValue];
            
            switch (netType) {
                case 0:
                    state = @"无网络";
                    //无网模式
                    break;
                case 1:
                    state = @"2G";
                    break;
                case 2:
                    state = @"3G";
                    break;
                case 3:
                    state = @"4G";
                    break;
                case 5:
                    state = @"WIFI";
                    break;
                default:
                    break;
            }
        }else{
            state = @"无网络";
        }
    }
    //根据状态选择
    return state;
}
/**
 读取配置表的 String
 
 @param str key 键
 @return 读取到的 String
 */
+(NSString*)getString:(NSString*)str{
    
    
    static NSBundle *bundle = nil;
    NSString *  defaultString = nil;
    if (bundle == nil)
    {
        NSString *bundlePath  = [[NSBundle bundleForClass:[self class]] pathForResource:@"ugliestBUNDLE" ofType:@"bundle"];
        bundle = [NSBundle bundleWithPath:bundlePath];
        bundlePath = [bundle pathForResource:[[NSUserDefaults standardUserDefaults] objectForKey:@"appLanguage"] ofType:@"lproj"];
        bundle = [NSBundle bundleWithPath:bundlePath] ?: [NSBundle mainBundle];

    }
    defaultString = [bundle localizedStringForKey:str  value:defaultString table:@"ugliestLocalString"];
    return [[NSBundle mainBundle] localizedStringForKey:str value:defaultString table:@"ugliestLocalString"];
    
}
/**
 获取系统语言设置
 */
+ (void)setLangueage {
   // if (![[NSUserDefaults standardUserDefaults] objectForKey:appLanguage]) {
        NSArray  *languages = [NSLocale preferredLanguages];
        NSString *language = [languages objectAtIndex:0];
 
        if ([language hasPrefix:@"zh-Hans-CN"]) {
            [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hans" forKey:appLanguage];
        } else if ([language hasPrefix:@"zh-TW"] || [language hasPrefix:@"zh-HK"] || [language hasPrefix:@"zh-Hant"]) {
            [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hant" forKey:appLanguage];
        } else if ([language hasPrefix:@"en"]) {
            [[NSUserDefaults standardUserDefaults] setObject:@"en" forKey:appLanguage];
//        }else{
//            [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hans" forKey:appLanguage];
//        }
    }
}
/**
 读取配置表的 String
 
 @param color key 键
 @return 读取到的颜色
 */
+(UIColor *)getColor:(NSString *)color{
    NSString* str = [self getString:color];
 
    if (!str || [str isEqualToString:@""]) {
        return ColorFF(0xffda44);
    }
    unsigned red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 1;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&red];
    range.location = 3;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&green];
    range.location = 5;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&blue];
    UIColor *co= [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1];
    return co;
    
    
    
    
}
/**
 判断是否能连接到指定的服务器
 
 @param Url 服务器地址
 @return  YES 能，NO 不能
 */
+(Boolean)isNetWork:(NSString*)Url
{
    Boolean state = NO;
    ugliestReachability* hostReachability = [ugliestReachability reachabilityWithHostName:Url];
    ugliestNetworkStatus netStatus=[hostReachability currentReachabilityStatus];
    switch (netStatus) {
        case ugliestNotReachable:
            // ugliestLog(@"没有网络");
            state = NO;
            break;
        case ugliestReachableViaWiFi:
            // ugliestLog(@"wifi网络");
            state = YES;
            break;
        case ugliestReachableViaWWAN:
            //ugliestLog(@"WWAN网络");
            state = YES;
            break;
        default:
            break;
    }
   // 根据状态选择
    return state;
}

/**
 Dictionary转成 url 用的 String，并单独 URLEncode
 
 @param dictionary  需要转换的Dictionary
 @return 转换后的 String
 */
+(NSString*)DictionaryTOUrlString:(NSDictionary*)dictionary{
    NSMutableString *dataString = [[NSMutableString alloc]init];
    NSArray *allKeys = [dictionary allKeys];
    for (NSInteger i = 0; i<allKeys.count; i++) {
        NSCharacterSet *URLBase64CharacterSet = [[NSCharacterSet characterSetWithCharactersInString:@"&/+"] invertedSet];//防止参数里面有&/+等
        if(i>0){
            [dataString appendFormat:@"&%@=%@",allKeys[i],[dictionary[allKeys[i]] stringByAddingPercentEncodingWithAllowedCharacters:URLBase64CharacterSet]];
        }else{
            [dataString appendFormat:@"%@=%@",allKeys[i],[dictionary[allKeys[i]] stringByAddingPercentEncodingWithAllowedCharacters:URLBase64CharacterSet]];
        }
    }
    return dataString;
}

/**
 判断是否由数字和26个英文字母组成的字符串
 
 @param data 数据
 @return  YES 是，NO 不是
 */
+ (BOOL) checkForNumberAndCase:(NSString *)data{
    NSString *regEx = @"^[A-Za-z0-9]+$";
    return [self baseCheckForRegEx:regEx data:data];
}

/**
 判断是否由26位小写字母
 
 @param data 数据
 @return YES 是，NO 不是
 */
+(BOOL)checkForLowerCase:(NSString *)data{
    NSString *regEx = @"^[a-z]+$";
    return [self baseCheckForRegEx:regEx data:data];
}

/**
 判断是否由26位大写字母
 
 @param data 数据
 @return YES 是，NO 不是
 */
+(BOOL)checkForUpperCase:(NSString *)data{
    NSString *regEx = @"^[A-Z]+$";
    return [self baseCheckForRegEx:regEx data:data];
}

/**
 判断是否由26个小写英文字母组成的字符串
 
 @param data 字符串
 @return YES 是，NO 不是
 */
+(BOOL)checkForLowerAndUpperCase:(NSString *)data{
    NSString *regEx = @"^[A-Za-z]+$";
    return [self baseCheckForRegEx:regEx data:data];
}

/**
 判断是否含有特殊字符
 
 @param data 数据
 @return  YES 有，NO 没有
 */
+ (BOOL) checkForSpecialChar:(NSString *)data{
    NSString *regEx = @"[^%&',;=?$\x22]+";
    return [self baseCheckForRegEx:regEx data:data];
}

/**
 判断是否是全部数字
 
 @param number 数字
 @return  YES 是，NO 否
 */
+ (BOOL) checkForNumber:(NSString *)number{
    NSString *regEx = @"^[0-9]*$";
    return [self baseCheckForRegEx:regEx data:number];
}

/**
 判断是否是指定长度的数字
 
 @param length 长度
 @param number 数字
 @return YES 是，NO 否
 */
+ (BOOL) checkForNumberWithLength:(NSString *)length number:(NSString *)number{
    NSString *regEx = [NSString stringWithFormat:@"^\\d{%@}$", length];
    return [self baseCheckForRegEx:regEx data:number];
}

/**
 判断是否是字母开通
 
 @param username 字符串
 @return YES 是，NO 否
 */
+ (BOOL) checkForUsername:(NSString *)username{
    NSString *regEx = @"^[A-Za-z]+$";
    return [self baseCheckForRegEx:regEx data:username];
}



/**
 判断是否含有空格
 
 @param username 需要判断的 String
 @return YES 有，NO 没有
 */
+ (BOOL) checkForBlank:(NSString *)username{
    NSString *str = @" ";
    if ([username rangeOfString:str].location != NSNotFound) {
        return YES;
    }else {
        return NO;
    }
}

/**
 *  基本的验证方法
 *
 *  @param regEx 校验格式
 *  @param data  要校验的数据
 *
 *  @return YES:成功 NO:失败
 */
+(BOOL)baseCheckForRegEx:(NSString *)regEx data:(NSString *)data{
    NSPredicate *card = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
    if (([card evaluateWithObject:data])) {
        return YES;
    }
    return NO;
}

+ (void)setButton:(UIButton *)sender  CAGradientLayer:(CGRect)rect{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors           = @[(__bridge id)[ugliestTools getColor:@"startcolor"].CGColor, (__bridge id)[ugliestTools getColor:@"endcolor"].CGColor];
    gradientLayer.locations        = @[@0.0, @1.0];
    gradientLayer.startPoint       = CGPointMake(0, 0);
    gradientLayer.endPoint         = CGPointMake(1.0, 0);
    gradientLayer.frame            = rect;
    [sender.layer addSublayer:gradientLayer];
}

@end
