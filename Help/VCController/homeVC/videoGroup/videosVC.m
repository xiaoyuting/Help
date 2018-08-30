//
//  videosVC.m
//  HELPXY
//
//  Created by GM on 2018/6/25.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "videosVC.h"





 

#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
 
@interface videosVC ()<UITableViewDelegate,UITableViewDataSource,  UIScrollViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    int playIndex;
    CGPoint oldOffset;
}
@property (nonatomic, strong)UIView *mainViewNavigitionView;

@property (nonatomic, strong)UIButton    * backButton;

@end

@implementation videosVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
