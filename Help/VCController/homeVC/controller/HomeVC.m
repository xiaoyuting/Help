//
//  HomeVC.m
//  HELPXY
//
//  Created by GM on 2018/5/2.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "HomeVC.h"
#import "relativePhotoVC.h"
#import "relativeInfoVC.h"
#import "videosVC.h"
#import "RootBaseNav.h"
#import "relativeUsersRequest.h"
#import "mediaRelativelistRequest.h"
#import "userPicRequest.h"
#import "toolVC.h"
#import "imgBtn.h"
#import "AddButton.h"
#import "relativeCollCell.h"
#import <AVFoundation/AVFoundation.h>
#import "picAndVideoVC.h"
#import "DBInfo.h"
#import "picScrollVC.h"
#import <CoreLocation/CoreLocation.h>
@interface HomeVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CLLocationManagerDelegate>
{
    CLLocationManager *locationmanager;//定位服务
    NSString *currentCity;//当前城市
    NSString *strlatitude;//经度
    NSString *strlongitude;//纬度
}
@property (nonatomic,strong) UIScrollView * scrollView;
@property (nonatomic,strong) imgBtn       * relativeVideoBtn;
@property (nonatomic,strong) imgBtn       * relativePicBtn;
@property (nonatomic,strong) imgBtn       * ownMediaBtn;
@property (nonatomic,strong) imgBtn       * toolNotifyBtn;
@property (nonatomic,strong) AddButton     * moreRelativeBtn;
@property (nonatomic,strong)NSMutableArray * releativeArr;
@property (nonatomic,strong)NSMutableArray * relativeVideoArr;
@property (nonatomic,strong)NSMutableArray * relativePicArr;
@property (nonatomic,strong) UICollectionView * collecView;
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayer;
@property (nonatomic,copy) NSString * userID;
@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getLocation];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setSubViews];
    [self relativeRequest];
    [self relativePicRequest];
    [self relativeVideoRequest];
    [self userPicRequest];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getLocation
{
    //判断定位功能是否打开
    if ([CLLocationManager locationServicesEnabled]) {
        locationmanager = [[CLLocationManager alloc]init];
        locationmanager.delegate = self;
        [locationmanager requestAlwaysAuthorization];
        currentCity = [NSString new];
        [locationmanager requestWhenInUseAuthorization];
        
        //设置寻址精度
        locationmanager.desiredAccuracy = kCLLocationAccuracyBest;
        locationmanager.distanceFilter = 5.0;
        [locationmanager startUpdatingLocation];
    }
}

- (void)setSubViews{
    self.releativeArr =[NSMutableArray array];
    self.relativePicArr = [NSMutableArray array];
    self.relativeVideoArr = [NSMutableArray array];
    self.title          = @"首页";
    self.relativePicBtn =[self Tag:0 Name:@"亲友相册" img:@"home"];
    self.relativeVideoBtn =[self Tag:1 Name:@"共享视频" img:@"home2"];
    self.ownMediaBtn   = [self Tag:2 Name:@"我的分享" img:@"home3"];
    self.toolNotifyBtn = [self Tag:3 Name:@"助老服务" img:@"home1"];
   
    self.flowLayer = [[UICollectionViewFlowLayout alloc]init];
     [self.flowLayer setScrollDirection:UICollectionViewScrollDirectionHorizontal ];
    self.collecView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.flowLayer];
    self.collecView.delegate   = self;
    self.collecView.dataSource = self;
    self.collecView.backgroundColor = [UIColor whiteColor];
    [self.collecView registerClass:[relativeCollCell class] forCellWithReuseIdentifier:@"relativeCollCell"];
    self.collecView.showsHorizontalScrollIndicator = NO;
    self.moreRelativeBtn = [[AddButton alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
  
    [self.moreRelativeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UIScrollView *scrollView = [UIScrollView new];
    [self.view addSubview:scrollView];
    [scrollView sd_addSubviews:@[self.relativePicBtn,
                                 self.relativeVideoBtn,
                                 self.collecView,
                                 self.moreRelativeBtn,
                                 self.ownMediaBtn,
                                 self.toolNotifyBtn]];
    
    scrollView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    self.relativePicBtn.sd_layout
    .topEqualToView(scrollView)
    .leftEqualToView(scrollView)
    .widthIs(KScreenWidth/2.0)
    .heightIs((KScreenWidth/2.0-10)/0.75);
    
    self.relativeVideoBtn.sd_layout
    .topEqualToView(scrollView)
    .rightEqualToView(scrollView)
    .widthIs(KScreenWidth/2.0)
    .heightIs((KScreenWidth/2.0-10)/0.75);
    
    self.collecView.sd_layout
    .topSpaceToView(self.relativeVideoBtn, 5)
    .leftEqualToView(scrollView)
    .rightSpaceToView(scrollView, 80)
    .heightIs(70);
    self.moreRelativeBtn.sd_layout
    .topSpaceToView(self.relativeVideoBtn, 5)
    .widthIs(70)
    .rightEqualToView(scrollView)
    .heightIs(70);
    
    self.ownMediaBtn.sd_layout
    .topSpaceToView(self.collecView, 5)
    .leftEqualToView(scrollView)
    .widthIs(KScreenWidth/2.0)
    .heightIs((KScreenWidth/2.0-10)/0.75);
    
    self.toolNotifyBtn.sd_layout
    .topSpaceToView(self.collecView, 5)
    .rightEqualToView(scrollView)
    .widthIs(KScreenWidth/2.0)
    .heightIs((KScreenWidth/2.0-10)/0.75);
    
     [scrollView setupAutoContentSizeWithBottomView:self.toolNotifyBtn bottomMargin:0];
 
}

- (void)selectInfo: (UIButton *) sender{
    
    if (sender.tag==0){
        picScrollVC * scr = [[picScrollVC alloc]init];
        [self pushViewController:scr animated:YES];
      
    }else if(sender.tag==1){
       
        videosVC* videoTab = [[ videosVC alloc]init];
        
       
        [self pushViewController:videoTab animated:YES];
        
    }else if(sender.tag==2){
        picAndVideoVC * vc = [[picAndVideoVC alloc]init];
        NSDictionary * dic = [DBInfo getPersonInfo];
        vc.userID = [dic objectForKey:@"id"];
        vc.titleStr  =  @"我的分享";
        [self pushViewController:vc animated:YES];
    }else if(sender.tag==3){
        toolVC * tool  =[[toolVC alloc]init];
        [self pushViewController:tool animated:YES];
    }
}

//设置分区
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView{
    
    return 1;
}

//每个分区上的元素个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.releativeArr.count;
}

//设置元素内容
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify =@"relativeCollCell";
    relativeCollCell    *cell =[collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.radio = YES;
    cell.dic = self.releativeArr[indexPath.row];
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
    UIEdgeInsets top = {0,10,0,10};
    return top;
}
//* 头部的尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(0, 0);
}

/** 顶部的尺寸*/
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(0, 0);
}

//设置元素大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //NSLog(@"%f",(kDeviceHeight-88-49)/4.0);
    return CGSizeMake(50,70);
}

//点击元素触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",indexPath);
    picAndVideoVC * vc = [[picAndVideoVC alloc]init];
     NSDictionary * dic = self.releativeArr[indexPath.row];
    vc.userID = [dic objectForKey:@"id"];
    vc.titleStr  =  [NSString stringWithFormat:@"%@的分享",[dic objectForKey:@"username"]];
    [self pushViewController:vc animated:YES];
}


- (imgBtn*)Tag:(NSInteger )tag Name:(NSString *)name img:(NSString *)img{
    imgBtn * btn = [[imgBtn alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth/2.0,(KScreenWidth/2.0-10)/0.75)];
    btn.tag = tag;
    btn.name.text =name;
    btn.icon.image = [UIImage imageNamed:img];
    [btn addTarget:self action:@selector(selectInfo:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)relativeRequest{
    [relativeUsersRequest profileRelativeUsersSuccess:^(NSDictionary *dic) {
        NSLog(@"dicwqwew==%@",dic);
        if ([[dic objectForKey:@"code"]isEqualToString:@"200"]){
            [self.releativeArr addObjectsFromArray:[dic objectForKey:@"data"]];
            [self.collecView reloadData];
            
        }
    } failure:^(NSError *error) {
        
    }];
}
- (void)relativeVideoRequest{
    [mediaRelativelistRequest mediaRelativelistRequestInfo:@{@"pageNum":@"1",
                                                             @"pageSize":@"1",
                                                             @"mediaType":@"1"}
                                                   Success:^(NSDictionary *dic) {
                                                       NSLog(@"dic==%@",dic);
                                                       if ([[dic objectForKey:@"code"]isEqualToString:@"200"]){
                                                           
                                                           NSArray * arr = [dic objectForKey:@"data"];
                                                           NSDictionary * picDic = arr[0];
                                                           [self.relativePicBtn.img sd_setImageWithURL:imgUrl([picDic objectForKey:@"url"])];
                                                           
                                                       }
    }
                                                   failure:^(NSError *error) {
        
    }];
}
- (void)relativePicRequest{
    [mediaRelativelistRequest mediaRelativelistRequestInfo:@{@"pageNum":@"1",
                                                             @"pageSize":@"1",
                                                             @"mediaType":@"2"}
                                                   Success:^(NSDictionary *dic) {
                                                       NSLog(@"dic==%@",dic);
                                                       if ([[dic objectForKey:@"code"]isEqualToString:@"200"]){
                                                           NSArray * arr = [dic objectForKey:@"data"];
                                                           NSDictionary * videoDic = arr[0];
                                                           [self videoImageWithvideoURL:imgUrl([videoDic objectForKey:@"url"]) atTime:1 :self.relativeVideoBtn.img];
                                                       }
                                                   }
                                                   failure:^(NSError *error) {
                                                       
                                                   }];
}

- (void)userPicRequest{
   
                           
    
    [userPicRequest userPicRequestInfo:@{@"pageNum":@"1",
                                         @"pageSize":@"1",
                                         @"mediaType":@"1",
                                         @"owner":@"true"
                                         }
                           Success:^(NSDictionary *info) {
                               NSLog(@"%@",info);
                               if ([[info objectForKey:@"code"]isEqualToString:@"200"]){
                                   NSArray * arr = [info objectForKey:@"data"];
                                   NSDictionary * picDic = arr[0];
                                   [self.ownMediaBtn.img sd_setImageWithURL:imgUrl([picDic objectForKey:@"url"]) placeholderImage:placeholdImg];
                               }
                           } failure:^(NSError *error) {
                               
                           }];
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
#pragma mark CoreLocation delegate (定位失败)
//定位失败后调用此代理方法
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    //设置提示提醒用户打开定位服务
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"允许定位提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:nil];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark 定位成功后则执行此代理方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    [locationmanager stopUpdatingHeading];
    //旧址
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    //打印当前的经度与纬度
    NSLog(@"%f,%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
    
    //反地理编码
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            currentCity = placeMark.locality;
            if (!currentCity) {
                currentCity = @"无法定位当前城市";
            }
            
            /*看需求定义一个全局变量来接收赋值*/
            NSLog(@"----%@",placeMark.country);//当前国家
            NSLog(@"%@",currentCity);//当前的城市
            [self setNavLeftItemTitle:currentCity andImage:nil];
            [locationmanager stopUpdatingLocation];
            //            NSLog(@"%@",placeMark.subLocality);//当前的位置
            //            NSLog(@"%@",placeMark.thoroughfare);//当前街道
            //            NSLog(@"%@",placeMark.name);//具体地址
            
        }
    }];
    
}
@end
