//
//  AVCaptureViewController.h
//  实时视频Demo
//
//  Created by zhongfeng1 on 2017/2/16.
//  Copyright © 2017年 zhongfeng. All rights reserved.
//

#import "RootBaseVC.h"
typedef  void (^Info)(NSDictionary  * dic);
@interface AVCaptureViewController : RootBaseVC
@property (nonatomic,strong)Info info;
@end

