//
//  ugliestFontImageInfo.m
//  ugliestSDK
//
//  Created by Develop on 2018/11/28.
//  Copyright © 2018年 ugliest. All rights reserved.
//

#import "ugliestIconInfo.h"

@implementation ugliestIconInfo

- (instancetype)initWithText:(NSString *)text size:(NSInteger)size color:(UIColor *)color {
    if (self = [super init]) {
        self.text = text;
        self.size = size;
        self.color = color;
        self.imageInsets = UIEdgeInsetsZero;
    }
    return self;
}

- (instancetype)initWithText:(NSString *)text size:(NSInteger)size color:(UIColor *)color inset:(UIEdgeInsets)inset {
    if (self = [super init]) {
        self.text = text;
        self.size = size;
        self.color = color;
        self.imageInsets = inset;
    }
    return self;
}

+ (instancetype)iconInfoWithText:(NSString *)text size:(NSInteger)size color:(UIColor *)color {
    return [[ugliestIconInfo alloc] initWithText:text size:size color:color];
}

+ (instancetype)iconInfoWithText:(NSString *)text size:(NSInteger)size color:(UIColor *)color inset:(UIEdgeInsets)inset {
    return [[ugliestIconInfo alloc] initWithText:text size:size color:color inset:inset];
}

@end
