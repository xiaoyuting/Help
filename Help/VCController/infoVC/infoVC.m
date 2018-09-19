//
//  infoVC.m
//  HELPXY
//
//  Created by GM on 2018/5/7.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "infoVC.h"
#import "uploadPicVC.h"
#import "photoCell.h"

#import "SegmentCate.h"
#import "infoModel.h"
#import "usermedModel.h"
#import "SDTimeLineCell.h"
#import <CoreLocation/CoreLocation.h>
#define kTimeLineTableViewCellId @"SDTimeLineCell"

@interface infoVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,CLLocationManagerDelegate>
{
    CLLocationManager *locationmanager;//定位服务
    NSString *currentCity;//当前城市
    NSString *strlatitude;//经度
    NSString *strlongitude;//纬度
}
@property   (nonatomic,strong)UITableView *   recTab;
@property   (nonatomic,strong)UITableView * localTab;
@property   (nonatomic,strong)SegmentCate * selectMode;
@property   (nonatomic,strong)UIScrollView * contentSrcView;

@property   (nonatomic,strong)NSMutableArray * info;
@property   (nonatomic,assign)int    recTag;


@end

@implementation infoVC

- (void)viewDidLoad {
    self.info = [[NSMutableArray   alloc]init];
    self.recTag = 1;
    [super viewDidLoad];
    [self setSubviews];
    [self getLocation];
  
    // Do any additional setup after loading the view.
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
- (void)setSubviews{
    [self setNavRightItemTitle:@"添加" andImage:nil];
    self.title= @"友邻";
     __weak typeof(self) weakSelf = self;

    self.selectMode  = [[SegmentCate alloc]initWithFrame:CGRectMake(0,[self naviGationH] , KScreenWidth, 40) titleArray:@[@"推荐",@"附近的人"]];
    self .selectMode .segmentedControlTitleSpacingStyle = SegmentedControlTitleSpaceStyleFixed;
    self.selectMode.showSplitLine=YES;
    self. selectMode .titleWidth = KScreenWidth /2.0;
    self.selectMode.showSplitLine =YES;
    self.selectMode.splitLineColor = ColorFF(0xEAEAEA);
    self.selectMode.lineColor =[UIColor redColor];
    self.selectMode.selectedTextColor = ColorFF(0x78C34E);
    self.selectMode.lineColor = ColorFF(0x78C34E);
    self.selectMode.defaultSelectedIndex =0;
    [self.selectMode segmentedControlSelectedWithBlock:^(SegmentCate *segmentedControl, NSInteger selectedIndex) {
        NSLog(@"selectedIndex : %zd", selectedIndex);
         [self.contentSrcView setContentOffset:CGPointMake(selectedIndex * KScreenWidth, 0) animated:YES];
    }];
    
    [self.view addSubview:self.selectMode];
    
 
    self.localTab = [[UITableView alloc]init];
    self.localTab.delegate   = self;
    self.localTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.localTab.dataSource = self;
    self.localTab.backgroundColor = [UIColor whiteColor];
    self.recTab = [[UITableView alloc]init];
    self.recTab.delegate   = self;
    self.recTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.recTab.dataSource = self;
    self.recTab.estimatedRowHeight = 0;
    self.recTab.estimatedSectionFooterHeight = 0;
    self.recTab.estimatedSectionHeaderHeight = 0;
    self.recTab.backgroundColor = [UIColor whiteColor];
    self.contentSrcView = [UIScrollView new];
    [self.view addSubview:self.contentSrcView];
    
    [self.contentSrcView sd_addSubviews:@[self.recTab,self.localTab]];
    self.contentSrcView.delegate = self;
    self.contentSrcView.pagingEnabled = YES;
   self.contentSrcView.sd_layout.spaceToSuperView(UIEdgeInsetsMake([self naviGationH]+40,0 , 0, 0 ));
    self.recTab.sd_layout
    .leftEqualToView(self.contentSrcView)
    .topEqualToView(self.contentSrcView)
    .bottomEqualToView(self.contentSrcView)
    .widthIs(KScreenWidth);
    self.localTab.sd_layout
    .leftSpaceToView(self.recTab, 0)
    .topEqualToView(self.contentSrcView)
    .bottomEqualToView(self.contentSrcView)
    .widthIs(KScreenWidth);
    [self.contentSrcView setupAutoContentSizeWithRightView:self.localTab rightMargin:0];
   self.recTab.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(recHeadRef)];
    self.recTab.mj_footer = [MJRefreshBackNormalFooter  footerWithRefreshingTarget:self refreshingAction:@selector(recFootRef)];
   [self.recTab.mj_header beginRefreshing];
}
- (void)recHeadRef{
    self.recTag = 1;
    [self Recrequest:self.recTag];
    [self.recTab.mj_header endRefreshing];
}

- (void)recFootRef{
    self.recTag ++;
    [self Recrequest:self.recTag];
    [self.recTab.mj_footer endRefreshing];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if([scrollView isEqual:self.contentSrcView]){
        NSInteger const kPageIndex = scrollView.contentOffset.x / KScreenWidth;
        [self.selectMode segmentedControlSetSelectedIndexWithSelectedBlock:kPageIndex];
        // 重设选中位置
        [self.selectMode segmentedControlSetSelectedIndex:kPageIndex];}
}

- (void)rightItemClick:(id)sender{
    uploadPicVC * pic = [[uploadPicVC alloc]init];
    [self pushViewController:pic animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.info.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
    id model = self.info[indexPath.row];
    return [self.recTab cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[SDTimeLineCell class] contentViewWidth:[self cellContentViewWith]];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SDTimeLineCell *cell = [tableView dequeueReusableCellWithIdentifier:kTimeLineTableViewCellId];
    cell.indexPath = indexPath;
    __weak typeof(self) weakSelf = self;
    if (!cell.moreButtonClickedBlock) {
        [cell setMoreButtonClickedBlock:^(NSIndexPath *indexPath) {
            usermedModel *model = weakSelf.info[indexPath.row];
           // model.isOpening = !model.isOpening;
            [weakSelf.recTab reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
      
    }
    cell.collectblock = ^(NSIndexPath *indexPath) {
        
    };
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    ///////////////////////////////////////////////////////////////////////
    
    cell.model = self.info[indexPath.row];
 
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
- (void)requestuserID:(NSString *)userID momentID:(NSString *)momentID{
    [RequestManager requestWithType:HttpRequestTypePost
                          urlString:URL_moment_recommend2 parameters:@{
                                                         @"momentId": @"2568",
                                                         @"userId": @"2084"}
                       successBlock:^(id response) {
                           NSLog(@"%@",response);
                           if (self.recTag==1){
                               [self.info removeAllObjects];
                           }
                           infoModel  * model = [infoModel yy_modelWithJSON:response ];
                           [self.info addObjectsFromArray: model.data];
                           [self.recTab reloadData];
                           
                           
                       }
                       failureBlock:^(NSError *error) {
                           
                       }
                           progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                               
                           }];
}
- (void)Recrequest:(int)tag{
    [RequestManager requestWithType:HttpRequestTypeGet
                          urlString:URL_moment_recommend2 parameters:@{
                                        @"pageNum":[NSString stringWithFormat:@"%d",tag],
                                       @"pageSize":@"5"
                                                                                                    }
                       successBlock:^(id response) {
                           NSLog(@"%@",response);
                           if (self.recTag==1){
                               [self.info removeAllObjects];
                           }
                           infoModel  * model = [infoModel yy_modelWithJSON:response ];
                           [self.info addObjectsFromArray: model.data];
                           [self.recTab reloadData];
                    
                        
                       }
                       failureBlock:^(NSError *error) {
                                                                                                        
                                                                                                    }
                           progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                                                                                                        
                                                                                                    }];
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
