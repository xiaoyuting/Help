//
//  uploadVideoVC.m
//  HELPXY
//
//  Created by GM on 2018/5/11.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "uploadVideoVC.h"
#import <AVFoundation/AVFoundation.h>

@interface uploadVideoVC()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic ,strong) UIImageView * videoimg;
@property (nonatomic ,strong) UIImagePickerController *ipc;
@property (nonatomic ,strong) UITextView   * txtView;
@property (nonatomic ,strong) UITextField  * txtTitle;
@property (nonatomic ,strong) UIImageView  * line;

@end

@implementation uploadVideoVC

- (void)viewDidLoad {
    [self setSubviews];
   
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}
- (void)setSubviews{
    self.title = @"视频上传";
    self.ipc = [[UIImagePickerController alloc] init];
    self.ipc.delegate = self;//设置委托
    self.txtTitle   = [[UITextField alloc]init];
    self.txtView    = [[UITextView alloc]init];
    self.line       = [[UIImageView alloc]init];
    self.videoimg   = [[UIImageView alloc]init];
    [self.view sd_addSubviews:@[self.txtTitle,self.line ,self.txtView,self.videoimg]];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self startvideo];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//选择本地视频
- (void)choosevideo
{
    
    self.ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//sourcetype有三种分别是camera，photoLibrary和photoAlbum
    NSArray *availableMedia = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];//Camera所支持的Media格式都有哪些,共有两个分别是@”public.image”,@”public.movie”
    self.ipc.mediaTypes = [NSArray arrayWithObject:availableMedia[1]];//设置媒体类型为public.movie
    [self presentViewController:self.ipc animated:YES completion:nil];
  
    
}

//录制视频
- (void)startvideo
{
    
    self.ipc.sourceType = UIImagePickerControllerSourceTypeCamera;//sourcetype有三种分别是camera，photoLibrary和photoAlbum
    NSArray *availableMedia = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];//Camera所支持的Media格式都有哪些,共有两个分别是@”public.image”,@”public.movie”
    self.ipc.mediaTypes = [NSArray arrayWithObject:availableMedia[1]];//设置媒体类型为public.movie
    [self presentViewController:self.ipc animated:YES completion:nil];
   self. ipc.videoMaximumDuration = 30.0f;//30秒
 
    
}

- (CGFloat) getFileSize:(NSString *)path
{
    NSLog(@"%@",path);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    float filesize = -1.0;
    if ([fileManager fileExistsAtPath:path]) {
        NSDictionary *fileDic = [fileManager attributesOfItemAtPath:path error:nil];//获取文件的属性
        unsigned long long size = [[fileDic objectForKey:NSFileSize] longLongValue];
        filesize = 1.0*size/1024;
    }else{
        NSLog(@"找不到文件");
    }
    return filesize;
}//此方法可以获取文件的大小，返回的是单位是KB。
- (CGFloat) getVideoLength:(NSURL *)URL
{
    
    AVURLAsset *avUrl = [AVURLAsset assetWithURL:URL];
    CMTime time = [avUrl duration];
    int second = ceil(time.value/time.timescale);
    return second;
}//此方法可以获取视频文件的时长。

//完成视频录制，并压缩后显示大小、时长
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSURL *sourceURL = [info objectForKey:UIImagePickerControllerMediaURL];
    NSLog(@"%@",[NSString stringWithFormat:@"%f s", [self getVideoLength:sourceURL]]);
    NSLog(@"%@", [NSString stringWithFormat:@"%.2f kb", [self getFileSize:[sourceURL path]]]);
    NSURL *newVideoUrl ; //一般.mp4
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];//用时间给文件全名，以免重复，在测试的时候其实可以判断文件是否存在若存在，则删除，重新生成文件即可
    [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    newVideoUrl = [NSURL fileURLWithPath:[NSHomeDirectory() stringByAppendingFormat:@"/Documents/output-%@.mp4", [formater stringFromDate:[NSDate date]]]] ;//这个是保存在app自己的沙盒路径里，后面可以选择是否在上传后删除掉。我建议删除掉，免得占空间。
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self convertVideoQuailtyWithInputURL:sourceURL outputURL:newVideoUrl completeHandler:nil];
}
- (void) convertVideoQuailtyWithInputURL:(NSURL*)inputURL
                               outputURL:(NSURL*)outputURL
                         completeHandler:(void (^)(AVAssetExportSession*))handler
{
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:inputURL options:nil];
    
    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
    //  NSLog(resultPath);
    exportSession.outputURL = outputURL;
    exportSession.outputFileType = AVFileTypeMPEG4;
    exportSession.shouldOptimizeForNetworkUse= YES;
    [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
     {
         switch (exportSession.status) {
             case AVAssetExportSessionStatusCancelled:
                 NSLog(@"AVAssetExportSessionStatusCancelled");
                 break;
             case AVAssetExportSessionStatusUnknown:
                 NSLog(@"AVAssetExportSessionStatusUnknown");
                 break;
             case AVAssetExportSessionStatusWaiting:
                 NSLog(@"AVAssetExportSessionStatusWaiting");
                 break;
             case AVAssetExportSessionStatusExporting:
                 NSLog(@"AVAssetExportSessionStatusExporting");
                 break;
             case AVAssetExportSessionStatusCompleted:
                 [self setImgUrl:outputURL];
                 NSLog(@"AVAssetExportSessionStatusCompleted");
                 NSLog(@"%@",[NSString stringWithFormat:@"%f s", [self getVideoLength:outputURL]]);
                 NSLog(@"%@", [NSString stringWithFormat:@"%.2f kb", [self getFileSize:[outputURL path]]]);
                 
                 //UISaveVideoAtPathToSavedPhotosAlbum([outputURL path], self, nil, NULL);//这个是保存到手机相册
                 
                [self alertUploadVideo:outputURL];
                 break;
                case AVAssetExportSessionStatusFailed:
                 NSLog(@"AVAssetExportSessionStatusFailed");
                 break;
                
                 
         }
         
     }];
    
}

-(void)setImgUrl:(NSURL*)outputURL{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        
        
        UIImage *image=[self thumbnailImageForVideo:outputURL atTime:1];
        
       // self.img.image=image;
    });
}
-(void)alertUploadVideo:(NSURL*)URL{
    CGFloat size = [self getFileSize:[URL path]];
    NSString *message;
    NSString *sizeString;
    CGFloat sizemb= size/1024;
    if(size<=1024){
        sizeString = [NSString stringWithFormat:@"%.2fKB",size];
    }else{
        sizeString = [NSString stringWithFormat:@"%.2fMB",sizemb];
    }
    
    
    
    
    if(sizemb<2){
        [self uploadVideo:URL];
    }
    
    else if(sizemb<=5){
        message = [NSString stringWithFormat:@"视频%@，大于2MB会有点慢，确定上传吗？", sizeString];
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil
                                                                                  message: message
                                                                           preferredStyle:UIAlertControllerStyleAlert];
        
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshwebpages" object:nil userInfo:nil];
            [[NSFileManager defaultManager] removeItemAtPath:[URL path] error:nil];//取消之后就删除，以免占用手机硬盘空间（沙盒）
            
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            
            [self uploadVideo:URL];
            
            
            
            
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
        
        
    }else if(sizemb>5){
        message = [NSString stringWithFormat:@"视频%@，超过5MB，不能上传，抱歉。", sizeString];
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil
                                                                                  message: message
                                                                           preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshwebpages" object:nil userInfo:nil];
            [[NSFileManager defaultManager] removeItemAtPath:[URL path] error:nil];//取消之后就删除，以免占用手机硬盘空间
            
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    
    
}

-(void)uploadVideo:(NSURL*)URL{
    //[MyTools showTipsWithNoDisappear:nil message:@”正在上传…”];
    /*NSData *data = [NSData dataWithContentsOfURL:URL];
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:@"www.ylhuakai.com" customHeaderFields:nil];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    NSString *updateURL;
    updateURL = @"/alflower/Data/sendupdate";
    
    
    [dic setValue:[NSString stringWithFormat:@"%@",User_id] forKey:@"openid"];
    [dic setValue:[NSString stringWithFormat:@"%@",[self.web objectForKey:@"web_id"]] forKey:@"web_id"];
    [dic setValue:[NSString stringWithFormat:@"%i",insertnumber] forKey:@”number”];
    [dic setValue:[NSString stringWithFormat:@"%i",insertType] forKey:@”type”];
    
    MKNetworkOperation *op = [engine operationWithPath:updateURL params:dic httpMethod:@"POST"];
    [op addData:data forKey:@"video" mimeType:@"video/mpeg" fileName:@"aa.mp4"];
    [op addCompletionHandler:^(MKNetworkOperation *operation) {
        NSLog(@"[operation responseData]–>>%@", [operation responseString]);
        NSData *data = [operation responseData];
        NSDictionary *resweiboDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSString *status = [[resweiboDict objectForKey:@"status"]stringValue];
        NSLog(@"addfriendlist status is %@", status);
        NSString *info = [resweiboDict objectForKey:@"info"];
        NSLog(@"addfriendlist info is %@", info);
        // [MyTools showTipsWithView:nil message:info];
        // [SVProgressHUD showErrorWithStatus:info];
        if ([status isEqualToString:@"1"])
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshwebpages" object:nil userInfo:nil];
            [[NSFileManager defaultManager] removeItemAtPath:[URL path] error:nil];//上传之后就删除，以免占用手机硬盘空间;
            
        }else
        {
            //[SVProgressHUD showErrorWithStatus:dic[@”info”]];
        }
        // [[NSNotificationCenter defaultCenter] postNotificationName:@”StoryData” object:nil userInfo:nil];
        
        
    }errorHandler:^(MKNetworkOperation *errorOp, NSError* err) {
        NSLog(@"MKNetwork request error : %@", [err localizedDescription]);
    }];
    [engine enqueueOperation:op];*/
    
    
}
//4.获取视频的第一帧

#pragma mark----获取视频的某一帧

-(UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time {
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    
    NSParameterAssert(asset);
    
    AVAssetImageGenerator *assetImageGenerator =[[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    
    assetImageGenerator.apertureMode =AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    
    CFTimeInterval thumbnailImageTime = time;
    
    NSError *thumbnailImageGenerationError = nil;
    
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60)actualTime:NULL error:&thumbnailImageGenerationError];
    
    if(!thumbnailImageRef)
        
        NSLog(@"thumbnailImageGenerationError %@",thumbnailImageGenerationError);
    
    UIImage*thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage:thumbnailImageRef]  : nil;
    
    return thumbnailImage;
    
}
@end
