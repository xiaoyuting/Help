//
//  ugliestFontImageList.m
//  ugliestSDK
//
//  Created by Develop on 2018/11/28.
//  Copyright © 2018年 ugliest. All rights reserved.
//

#import "ugliestFontImageList.h"

@implementation ugliestFontImageList

+ (NSDictionary*)IconDictionary
{
    return @{ @"del"    : @"\U0000e62f",
              @"left"   : @"\U0000e680",
              @"right"  : @"\U0000e681",
              @"up"     : @"\U0000e682",
              @"down"   : @"\U0000e683",
              @"loading": @"\U0000e6ac",
              @"loadcenter":@"\U0000e684",
              @"back" :@"\U0000e6f0"
              };
}

+ (NSString*)fontName
{
    return @"iconfont";
}

@end
