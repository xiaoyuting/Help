//
//  CheakViewController.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/4.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "CheakViewController.h"

#import <AVFoundation/AVFoundation.h>
#import "XYScanView.h"

@interface CheakViewController ()<XYScanViewDelegate
>

@property (strong, nonatomic)   AVCaptureDevice *device;
@property (nonatomic,weak) XYScanView *scanV;
@end

@implementation CheakViewController

- (void)viewDidLoad {
     self.title = @"扫描邀请码";
    XYScanView *scanV = [[XYScanView alloc]initWithFrame:CGRectMake(0, [self naviGationH], KScreenWidth, KScreenHeight-[self naviGationH])];
    scanV.delegate = self;
    
    [self.view addSubview:scanV];
    _scanV = scanV;
       [super viewDidLoad];
   
}
-(void)getScanDataString:(NSString*)scanDataString{
   
    
    NSLog(@"二维码内容：%@",scanDataString);
    [self.IDdelegate  scanInvateID:scanDataString];
    [self.navigationController popViewControllerAnimated:YES];
   
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    //self.navigationController.navigationBar.hidden=YES;
     //[self Getphoto];
}


-(void)viewWillDisappear:(BOOL)animated{
    
            [self.device unlockForConfiguration];
}


@end
