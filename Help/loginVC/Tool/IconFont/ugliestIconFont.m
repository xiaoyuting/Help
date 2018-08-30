//
//  ugliestIconFont.m
//  ugliestSDK
//
//  Created by Develop on 2018/11/28.
//  Copyright © 2018年 ugliest. All rights reserved.
//

#import "ugliestIconFont.h"
#import <CoreText/CoreText.h>

@implementation ugliestIconFont

static NSString *_fontName;

+ (void)registerFontWithURL:(NSURL *)url {
    NSAssert([[NSFileManager defaultManager] fileExistsAtPath:[url path]], @"Font file doesn't exist");
    CGDataProviderRef fontDataProvider = CGDataProviderCreateWithURL((__bridge CFURLRef)url);
    CGFontRef newFont = CGFontCreateWithDataProvider(fontDataProvider);
    CGDataProviderRelease(fontDataProvider);
    CTFontManagerRegisterGraphicsFont(newFont, nil);
    CGFontRelease(newFont);
}

+ (UIFont *)fontWithSize:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:[self fontName] size:size];
    if (font == nil) {
        NSString * plistPath = [[NSBundle mainBundle] pathForResource:@"ugliestBUNDLE" ofType :@"bundle"];
        NSString *pathOne = [plistPath stringByAppendingPathComponent:@"ugliestTTF"];
        NSURL *fontFileUrl = [NSURL fileURLWithPath:pathOne];
        [self registerFontWithURL: fontFileUrl];
        font = [UIFont fontWithName:[self fontName] size:size];
        NSAssert(font, @"UIFont object should not be nil, check if the font file is added to the application bundle and you're using the correct font name.");
    }
    return font;
}

+ (UIFont *)fontWithSize: (CGFloat)size withFontName:(NSString*)fontName
{
    UIFont *font = [UIFont fontWithName:fontName size:size];
    if (font == nil) {
        NSString * plistPath = [[NSBundle mainBundle] pathForResource:@"ugliestBUNDLE" ofType :@"bundle"];
        NSString *pathOne = [plistPath stringByAppendingPathComponent:@"ugliestTTF"];
        NSURL *fontFileUrl = [NSURL fileURLWithPath:pathOne];
        [self registerFontWithURL: fontFileUrl];
        font = [UIFont fontWithName:fontName size:size];
        NSAssert(font, @"UIFont object should not be nil, check if the font file is added to the application bundle and you're using the correct font name.");
    }
    return font;
}

+ (void)setFontName:(NSString *)fontName {
    _fontName = fontName;
}

+ (NSString *)fontName {
    return _fontName ? : @"iconfont";
}

+ (UIImage *)iconWithInfo:(ugliestIconInfo *)info
{
    CGFloat w1 = info.size - info.imageInsets.left - info.imageInsets.right;
    CGFloat w2 = info.size - info.imageInsets.top - info.imageInsets.bottom;
    CGFloat size = MIN(w1, w2);
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat realSize = size * scale;
    CGFloat imageSize = info.size * scale;
    UIFont *font = info.fontName ?
    [ugliestIconFont fontWithSize:realSize withFontName:info.fontName] :
    [ugliestIconFont fontWithSize:realSize];
    
    UIGraphicsBeginImageContext(CGSizeMake(imageSize, imageSize));
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (info.backgroundColor) {
        [info.backgroundColor set];
        UIRectFill(CGRectMake(0.0, 0.0, imageSize, imageSize)); //fill the background
    }
    CGPoint point = CGPointMake(info.imageInsets.left*scale, info.imageInsets.top*scale);
    
    if ([info.text respondsToSelector:@selector(drawAtPoint:withAttributes:)]) {
        /**
         * 如果这里抛出异常，请打开断点列表，右击All Exceptions -> Edit Breakpoint -> All修改为Objective-C
         * See: http://stackoverflow.com/questions/1163981/how-to-add-a-breakpoint-to-objc-exception-throw/14767076#14767076
         */
        [info.text drawAtPoint:point withAttributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName: info.color}];
    } else {
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        CGContextSetFillColorWithColor(context, info.color.CGColor);
        [info.text drawAtPoint:point withFont:font];
#pragma clang pop
    }
    
    UIImage *image = [UIImage imageWithCGImage:UIGraphicsGetImageFromCurrentImageContext().CGImage scale:scale orientation:UIImageOrientationUp];
    UIGraphicsEndImageContext();
    
    return image;
}

@end
