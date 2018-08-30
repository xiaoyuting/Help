//
//  ugliestIconFont.h
//  ugliestSDK
//
//  Created by Develop on 2018/11/28.
//  Copyright © 2018年 ugliest. All rights reserved.
//


#import "ugliestIconInfo.h"

#define TBCityIconInfoMake(text, imageSize, imageColor) [TBCityIconInfo iconInfoWithText:text size:imageSize color:imageColor]

@interface ugliestIconFont : NSObject

+ (UIFont *)fontWithSize: (CGFloat)size;
+ (UIFont *)fontWithSize: (CGFloat)size withFontName:(NSString*)fontName;
+ (void)setFontName:(NSString *)fontName;
+ (UIImage *)iconWithInfo:(ugliestIconInfo *)info;
@end
