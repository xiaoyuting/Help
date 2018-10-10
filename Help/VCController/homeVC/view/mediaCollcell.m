//
//  mediaCollcell.m
//  Help
//
//  Created by GM on 2018/10/8.
//  Copyright © 2018年 Ugliest. All rights reserved.
//

#import "mediaCollcell.h"
#import <AVFoundation/AVFoundation.h>
@implementation mediaCollcell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]){
        self.pic = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth/3.0-2, KScreenWidth/3.0-2)];
        self.pic.contentMode = UIViewContentModeScaleAspectFill;
        self.pic.layer.masksToBounds =YES;
        [self.contentView addSubview:self.pic];
        self.playerimg  =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        self.playerimg.center =self.contentView.center;
        [self.contentView addSubview:self.playerimg];
        self.playerimg.image = [UIImage imageNamed:@"playerStart"];
        
        self.playerimg.hidden =YES;
    }
    return self;
}

- (void)setPicDic:(NSDictionary *)picDic{
    _picDic =picDic;
    [self.pic sd_setImageWithURL:imgUrl([picDic objectForKey:@"url"]) placeholderImage:placeholdImg];
}
- (void)setVideoDic:(NSDictionary *)videoDic{
    _videoDic =videoDic;
    self.playerimg.hidden =NO;
    [self videoImageWithvideoURL:imgUrl([videoDic objectForKey:@"url"]) atTime:1 :self.pic];
    
}
- (void)videoImageWithvideoURL:(NSURL *)videoURL atTime:(NSTimeInterval)time  :(UIImageView * )img{
    
    //先从缓存中找是否有图片
    __weak typeof(self)weakself =self;
    SDImageCache *cache =  [SDImageCache sharedImageCache];
    UIImage *memoryImage =  [cache imageFromMemoryCacheForKey:videoURL.absoluteString];
    if (memoryImage) {
        img.image =  memoryImage ;
        return;
    }else{
        UIImage *diskImage =  [cache imageFromDiskCacheForKey:videoURL.absoluteString];
        if (diskImage) {
            img.image =  diskImage  ;
            return;
        }
    }
    
    if (!time) {
        time = 1;
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
        NSParameterAssert(asset);
        AVAssetImageGenerator *assetImageGenerator =[[AVAssetImageGenerator alloc] initWithAsset:asset];
        assetImageGenerator.appliesPreferredTrackTransform = YES;
        assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
        CGImageRef thumbnailImageRef = NULL;
        CFTimeInterval thumbnailImageTime = time;
        NSError *thumbnailImageGenerationError = nil;
        thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60)actualTime:NULL error:&thumbnailImageGenerationError];
        if(!thumbnailImageRef)
            NSLog(@"thumbnailImageGenerationError %@",thumbnailImageGenerationError);
        UIImage*thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage: thumbnailImageRef] : nil;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            SDImageCache *cache =  [SDImageCache sharedImageCache];
            [cache storeImage:thumbnailImage forKey:videoURL.absoluteString toDisk:YES];
            img.image =  thumbnailImage ;
        });
        
    });
    
}
@end
