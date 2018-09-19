//
//  SDWeiXinPhotoContainerView.m
//  SDAutoLayout 测试 Demo
//
//  Created by gsd on 15/12/23.
//  Copyright © 2015年 gsd. All rights reserved.
//


/*
 
 *********************************************************************************
 *
 * GSD_WeiXin
 *
 * QQ交流群: 459274049
 * Email : gsdios@126.com
 * GitHub: https://github.com/gsdios/GSD_WeiXin
 * 新浪微博:GSD_iOS
 *
 * 此“高仿微信”用到了很高效方便的自动布局库SDAutoLayout（一行代码搞定自动布局）
 * SDAutoLayout地址：https://github.com/gsdios/SDAutoLayout
 * SDAutoLayout视频教程：http://www.letv.com/ptv/vplay/24038772.html
 * SDAutoLayout用法示例：https://github.com/gsdios/SDAutoLayout/blob/master/README.md
 *
 *********************************************************************************
 
 */

#import "SDWeiXinPhotoContainerView.h"

#import "UIView+SDAutoLayout.h"
#import "videoPlayerVC.h"
#import "SDPhotoBrowser.h"
#import "relativeCollCell.h"
#import <AVFoundation/AVFoundation.h>
@interface SDWeiXinPhotoContainerView () <SDPhotoBrowserDelegate  >

@property (nonatomic, strong) NSArray *imageViewsArray;
//@property (nonatomic,strong)  UICollectionView  * collecView;
//@property (nonatomic,strong)  UICollectionViewFlowLayout * flowlayout;
@end

@implementation SDWeiXinPhotoContainerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    NSMutableArray *temp = [NSMutableArray new];
//    self.flowlayout  = [[UICollectionViewFlowLayout alloc]init];
//    self.collecView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.flowlayout];
//    self.collecView.delegate   = self;
//    self.collecView.dataSource = self;
//    [self.collecView registerClass:[relativeCollCell class] forCellWithReuseIdentifier:@"cell"];
//    self.collecView.showsHorizontalScrollIndicator = NO;
//    self.collecView.backgroundColor = [UIColor whiteColor];
//    [self addSubview:self.collecView];
//    self.collecView.sd_layout
//    .spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    for (int i = 0; i < 9; i++) {
        UIImageView *imageView = [UIImageView new];
        imageView.contentMode = UIViewContentModeScaleAspectFill    ;
        imageView.layer.masksToBounds =YES;    
        [self addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [imageView addGestureRecognizer:tap];
        [temp addObject:imageView];
    }

    self.imageViewsArray = [temp copy];
}


- (void)setPicPathStringsArray:(NSArray *)picPathStringsArray
{
    _picPathStringsArray = picPathStringsArray;
    __weak __typeof(self) weakself =self;
    for (long i = _picPathStringsArray.count; i < self.imageViewsArray.count; i++) {
        UIImageView *imageView = [self.imageViewsArray objectAtIndex:i];
        imageView.hidden = YES;
    }
    
    if (_picPathStringsArray.count == 0) {
        self.height_sd = 0;
        self.fixedHeight = @(0);
        return;
    }
    if (self.type==1){
        CGFloat itemW = [self itemWidthForPicPathArray:_picPathStringsArray];
        CGFloat itemH = 0;
        if (_picPathStringsArray.count == 1) {
            UIImageView * imgSize = [UIImageView new];
         
            
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:_picPathStringsArray.lastObject]];
            
            UIImage *image = [UIImage imageWithData:data]; // 取得图片
          
            [imgSize sd_setImageWithURL:_picPathStringsArray.lastObject];
            if (image.size.width) {
                itemH =image.size.height / image.size.width * itemW;
            }
        } else {
            itemH = itemW;
        }
        long perRowItemCount = [self perRowItemCountForPicPathArray:_picPathStringsArray];
        CGFloat margin = 5;
        
        [_picPathStringsArray enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            long columnIndex = idx % perRowItemCount;
            long rowIndex = idx / perRowItemCount;
            UIImageView *imageView = [_imageViewsArray objectAtIndex:idx];
            imageView.hidden = NO;
            [imageView sd_setImageWithURL:imgUrl(obj) placeholderImage:placeholdImg];
            imageView.frame = CGRectMake(columnIndex * (itemW + margin), rowIndex * (itemH + margin), itemW, itemH);
        }];
        
        CGFloat w = perRowItemCount * itemW + (perRowItemCount - 1) * margin;
        int columnCount = ceilf(_picPathStringsArray.count * 1.0 / perRowItemCount);
        CGFloat h = columnCount * itemH + (columnCount - 1) * margin;
        
        self.width_sd = w;
        self.height_sd = h;
        self.fixedHeight = @(h);
        self.fixedWidth = @(w);
    }else{
        CGFloat itemW = [self itemWidthForPicPathArray:_picPathStringsArray];
        CGFloat itemH = 0;
        if (_picPathStringsArray.count == 1) {
            UIImageView * imgview = [[UIImageView alloc]init];
            [weakself   videoImageWithvideoURL:imgUrl(_picPathStringsArray.lastObject) atTime:1 :imgview ];
           // UIImage * image = [self firstFrameWithVideoURL:imgUrl(_picPathStringsArray.lastObject) size:CGSizeZero];
            if (imgview.image.size.width) {
                itemH = imgview.image.size.height / imgview.image.size.width * itemW;
            }
        } else {
            itemH = itemW;
        }
        long perRowItemCount = [self perRowItemCountForPicPathArray:_picPathStringsArray];
        CGFloat margin = 5;
        
        [_picPathStringsArray enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            long columnIndex = idx % perRowItemCount;
            long rowIndex = idx / perRowItemCount;
            UIImageView *imageView = [_imageViewsArray objectAtIndex:idx];
            imageView.hidden = NO;
            
            [weakself  videoImageWithvideoURL:imgUrl(_picPathStringsArray[idx]) atTime:1 :imageView];
            dispatch_async(dispatch_queue_create(0, 0), ^{
                
               // UIImage * img =[self firstFrameWithVideoURL:imgUrl(_picPathStringsArray[idx]) size:CGSizeZero];
               // dispatch_async(dispatch_get_main_queue(), ^{
                   // imageView.image =img;
                //});
            });
           
           // [imageView sd_setImageWithURL:imgUrl(obj) placeholderImage:placeholdImg];
            imageView.frame = CGRectMake(columnIndex * (itemW + margin), rowIndex * (itemH + margin), itemW, itemH);
        }];
        
        CGFloat w = perRowItemCount * itemW + (perRowItemCount - 1) * margin;
        int columnCount = ceilf(_picPathStringsArray.count * 1.0 / perRowItemCount);
        CGFloat h = columnCount * itemH + (columnCount - 1) * margin;
        self.width_sd = w;
        self.height_sd = h;
        
        self.fixedHeight = @(h);
        self.fixedWidth = @(w);
    }
   
}

#pragma mark - private actions

- (void)tapImageView:(UITapGestureRecognizer *)tap
{
    if (self.type==1){
        
    
    UIView *imageView = tap.view;
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.currentImageIndex = imageView.tag;
    browser.sourceImagesContainerView = self;
    browser.imageCount = self.picPathStringsArray.count;
    browser.delegate = self;
        [browser show];
        
    }else{
         UIView *imageView = tap.view;
        videoPlayerVC * vc = [[videoPlayerVC alloc]initwithVideoArr:self.picPathStringsArray select:imageView.tag];
        [[[UIApplication sharedApplication].delegate window].rootViewController presentViewController:vc  animated:YES completion:nil];
    }
}
- (void)onBack:(id)sender
{
    [[[UIApplication sharedApplication].delegate window].rootViewController dismissViewControllerAnimated:YES completion:nil];
    
    
}
- (CGFloat)itemWidthForPicPathArray:(NSArray *)array
{
    if (array.count == 1) {
        return 120;
    } else {
        CGFloat w = [UIScreen mainScreen].bounds.size.width > 320 ? 80 : 70;
        return w;
    }
}

- (NSInteger)perRowItemCountForPicPathArray:(NSArray *)array
{
    if (array.count < 3) {
        return array.count;
    } else if (array.count <= 4) {
        return 2;
    } else {
        return 3;
    }
}


#pragma mark - SDPhotoBrowserDelegate

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *imageName = self.picPathStringsArray[index];
    NSURL *url = [[NSBundle mainBundle] URLForResource:imageName withExtension:nil];
    return url;
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIImageView *imageView = self.subviews[index];
    return imageView.image;
}
#pragma mark ---- 获取图片第一帧
- (UIImage *)firstFrameWithVideoURL:(NSURL *)url size:(CGSize)size
{
    // 获取视频第一帧
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:opts];
    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    generator.appliesPreferredTrackTransform = YES;
   //generator.maximumSize = CGSizeMake(size.width, size.height);
    NSError *error = nil;
    CGImageRef img = [generator copyCGImageAtTime:CMTimeMake(0, 10) actualTime:NULL error:&error];
    {
        return [UIImage imageWithCGImage:img];
    }
    return nil;
}
- (void)videoImageWithvideoURL:(NSURL *)videoURL atTime:(NSTimeInterval)time  :(UIImageView * )img{
    
    //先从缓存中找是否有图片
    __weak typeof(self)weakself =self;
    SDImageCache *cache =  [SDImageCache sharedImageCache];
    UIImage *memoryImage =  [cache imageFromMemoryCacheForKey:videoURL.absoluteString];
    if (memoryImage) {
        img.image = [weakself addImage:memoryImage withImage:@"playerStart"];;
        return;
    }else{
        UIImage *diskImage =  [cache imageFromDiskCacheForKey:videoURL.absoluteString];
        if (diskImage) {
            img.image = [weakself addImage:diskImage withImage:@"playerStart"];
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
            img.image = [weakself addImage:thumbnailImage withImage:@"playerStart"];
        });
        
    });
    
}
- (UIImage *)addImage:(UIImage *)image1 withImage:(NSString *)imageName2 {
    
    
    UIImage *image2 = [UIImage imageNamed:imageName2];
    
    UIGraphicsBeginImageContext(image1.size);
    
    [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
    
    [image2 drawInRect:CGRectMake(image1.size.width*0.4 ,(image1.size.height -0.2*image1.size.width) /2.0, 0.2*image1.size.width, image1.size.width*0.2)];
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultingImage;
}
/*//设置分区
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView{
    
    return 1;
}

//每个分区上的元素个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _picPathStringsArray.count;
}

//设置元素内容
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify =@"cell";
relativeCollCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.imgUrl  = _picPathStringsArray[indexPath.row];
    return cell;
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
//设置元素的的大小框
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{  //top, left, bottom, right;
    UIEdgeInsets top = {10,10,10,10};
    return top;
}*/
/** 头部的尺寸*/
/*-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    
    return CGSizeMake(0, 0);
}

/** 顶部的尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    
    return CGSizeMake(0, 0);
}

//设置元素大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //NSLog(@"%f",(kDeviceHeight-88-49)/4.0);
    return CGSizeMake((KScreenWidth-40)/3.0,(KScreenWidth-40)/3.0);
}

//点击元素触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",indexPath);
    //    SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
    //    photoBrowser.delegate = self;
    //    photoBrowser.currentImageIndex = indexPath.item;
    //    photoBrowser.imageCount = self.picArray.count;
    //    photoBrowser.sourceImagesContainerView = collectionView;
    //
    //    [photoBrowser show];
}*/

@end
