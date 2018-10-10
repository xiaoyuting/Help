//
//  picAndVideoVC.m
//  Help
//
//  Created by GM on 2018/10/8.
//  Copyright © 2018年 Ugliest. All rights reserved.
//

#import "picAndVideoVC.h"
#import "SegmentCate.h"
#import "mediaCollcell.h"
#import "userPicRequest.h"
#import "SDPhotoBrowser.h"
#import "videoPlayerVC.h"
@interface picAndVideoVC ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SDPhotoBrowserDelegate>
@property   (nonatomic,strong)SegmentCate * selectMode;
@property   (nonatomic,strong)UIScrollView * contentSrcView;
@property   (nonatomic,strong)UICollectionView  * picCol;
@property   (nonatomic,strong)UICollectionView  * videoCol;
@property   (nonatomic,strong)UICollectionViewFlowLayout * picLayer;
@property   (nonatomic,strong)UICollectionViewFlowLayout * videoLayer;
@property   (nonatomic,strong)NSMutableArray   * picArr;
@property   (nonatomic,strong)NSMutableArray   * videoArr;

@property   (nonatomic,assign)int  picSize;
@property   (nonatomic,assign)int  videoSize;

//@property   (nonatomic,strong)UICollectionViewFlowLayout * picLayer;
@end

@implementation picAndVideoVC
static NSString * const piccellID =@"piccellid";
static NSString * const videocellID = @"videocellid";
- (instancetype)init{
    if (self = [super init]){
        self.userID = [NSString string];
        self.titleStr = [NSString string];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubviews];
    self.videoSize=1;
    [self userVideoRequest];
}
- (void)setSubviews{
    self.title =self.titleStr;
    self.picArr = [NSMutableArray array];
    self.videoArr = [NSMutableArray array];
    self.selectMode  = [[SegmentCate alloc]initWithFrame:CGRectMake(0,[self naviGationH] , KScreenWidth, 40) titleArray:@[@"相册",@"视频"]];
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
    self.contentSrcView = [[UIScrollView alloc]init];
    self.contentSrcView.delegate = self;
    self.contentSrcView.pagingEnabled = YES;
    [self.view addSubview: self.contentSrcView];
    self.contentSrcView.sd_layout.spaceToSuperView(UIEdgeInsetsMake([self naviGationH]+40, 0, 0, 0));
    
    self.picLayer  = [[UICollectionViewFlowLayout alloc]init];
    self.picCol = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.picLayer];
    self.picCol.delegate   = self;
    self.picCol.dataSource = self;
    self.picCol.backgroundColor = [UIColor whiteColor];
    self.picLayer.scrollDirection = UICollectionViewScrollDirectionVertical;
    [self.picCol registerClass:[mediaCollcell class] forCellWithReuseIdentifier:piccellID];
   
    self.videoLayer  = [[UICollectionViewFlowLayout alloc]init];
    self.videoCol= [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.videoLayer];
    self.videoCol.delegate   = self;
    self.videoCol.dataSource = self;
    self.videoCol.backgroundColor = [UIColor whiteColor];
    [self.videoCol registerClass:[mediaCollcell class] forCellWithReuseIdentifier:videocellID];
    [self.contentSrcView sd_addSubviews:@[self.picCol ,self.videoCol]];
    self.picCol.sd_layout
    .leftEqualToView(self.contentSrcView)
    .topEqualToView(self.contentSrcView)
    .bottomEqualToView(self.contentSrcView)
    .widthIs(KScreenWidth);
    self.videoCol.sd_layout
    .leftSpaceToView(self.picCol, 0)
    .topEqualToView(self.contentSrcView)
    .bottomEqualToView(self.contentSrcView)
    .widthIs(KScreenWidth);
    [self.contentSrcView setupAutoContentSizeWithRightView:self.videoCol rightMargin:0];
    self.picCol.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(picHeadRef)];
    self.picCol.mj_footer = [MJRefreshBackNormalFooter  footerWithRefreshingTarget:self refreshingAction:@selector(picFootRef)];
    [self.picCol.mj_header beginRefreshing];
}
- (void)picHeadRef{
    self.picSize=1;
    [self userPicRequest];
    [self.picCol.mj_header endRefreshing];
}
- (void)picFootRef{
    self.picSize++;
    [self userPicRequest];
    [self.picCol.mj_footer endRefreshing];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if([scrollView isEqual:self.contentSrcView]){
        NSInteger const kPageIndex = scrollView.contentOffset.x / KScreenWidth;
        [self.selectMode segmentedControlSetSelectedIndexWithSelectedBlock:kPageIndex];
        // 重设选中位置
        [self.selectMode segmentedControlSetSelectedIndex:kPageIndex];}
}

//设置分区
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView{
    
    return 1;
}

//每个分区上的元素个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section

{
    if (collectionView ==self.picCol){
        return self.picArr.count;
    } else if(collectionView  ==self.videoCol){
        return self.videoArr.count;
    }
    
    return 0;
}

//设置元素内容
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView ==self.picCol){
        mediaCollcell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:piccellID forIndexPath:indexPath];
        cell.picDic = self.picArr[indexPath.row];
        return cell;
    } else if(collectionView  ==self.videoCol){
        mediaCollcell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:videocellID forIndexPath:indexPath];
        cell.videoDic = self.videoArr[indexPath.row];
        return cell;
    }
    return nil;
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}
//设置元素的的大小框
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{  //top, left, bottom, right;
    UIEdgeInsets top = {1,1,0,0};
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
    
  
    return CGSizeMake(KScreenWidth/3.0-2,KScreenWidth/3.0-2);
}

//点击元素触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",indexPath);
    if (collectionView ==self.picCol){
        SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
        browser.currentImageIndex = indexPath.row;
        browser.sourceImagesContainerView = self.picCol;
        browser.imageCount = [self picGetArr].count;
        browser.delegate = self;
        [browser show];
    } else if(collectionView  ==self.videoCol){
        videoPlayerVC * vc = [[videoPlayerVC alloc]initwithVideoArr:[self videoGetArr] select:indexPath.row];
        [self presentViewController:vc animated:YES completion:nil];
    }
}


#pragma mark - SDPhotoBrowserDelegate

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *imageName = [self picGetArr][index];
    NSURL *url = [[NSBundle mainBundle] URLForResource:imageName withExtension:nil];
    return url;
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIImageView *imageView =  [[UIImageView alloc]init];
    [imageView sd_setImageWithURL:imgUrl([self picGetArr][index])];
    return imageView.image;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)userPicRequest{
    
    
    
    [userPicRequest userPicRequestInfo:@{@"pageNum":[NSString stringWithFormat:@"%d",self.picSize ],
                                         @"pageSize":@"10",
                                         @"mediaType":@"1",
                                         @"owner":@"false",
                                         @"userId":self.userID
                                         }
                               Success:^(NSDictionary *info) {
                                   NSLog(@"%@",info);
                                   if (self.picSize==1){
                                       [self.picArr  removeAllObjects];
                                   }
                                   if ([[info objectForKey:@"code"]isEqualToString:@"200"]){
                                       
                                       [self.picArr addObjectsFromArray: [info objectForKey:@"data"]];
                                       [self.picCol reloadData];
                                   }
                               } failure:^(NSError *error) {
                                   
                               }];
}
- (void)userVideoRequest{
    
    
    
    [userPicRequest userPicRequestInfo:@{
                                         @"pageNum":[NSString stringWithFormat:@"%d",self.videoSize],
                                         @"pageSize":@"10",
                                         @"mediaType":@"2",
                                         @"owner":@"false",
                                         @"userId":self.userID
                                         }
                               Success:^(NSDictionary *info) {
                                   NSLog(@"%@",info);
                                   if (self.videoSize==1){
                                       [self.videoArr  removeAllObjects];
                                   }
                                   if ([[info objectForKey:@"code"]isEqualToString:@"200"]){
                                       
                                       [self.videoArr addObjectsFromArray: [info objectForKey:@"data"]];
                                       [self.videoCol reloadData];
                                   }
                               } failure:^(NSError *error) {
                                   
                               }];
}

- (NSArray *)picGetArr{
    NSMutableArray * arr = [NSMutableArray array];
    for (NSDictionary * dic in self.picArr) {
        [arr addObject:[dic objectForKey:@"url"]];
    }
    return [arr copy];
}
- (NSArray *)videoGetArr{
    NSMutableArray * arr = [NSMutableArray array];
    for (NSDictionary * dic in self.videoArr) {
        [arr addObject:[dic objectForKey:@"url"]];
    }
    return [arr copy];
}

@end
