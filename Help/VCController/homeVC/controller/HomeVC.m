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

#import "toolVC.h"
#import "imgBtn.h"
#import "AddButton.h"
#import "relativeCollCell.h"
@interface HomeVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UIScrollView * scrollView;
@property (nonatomic,strong) imgBtn       * relativeVideoBtn;
@property (nonatomic,strong) imgBtn       * relativePicBtn;
@property (nonatomic,strong) imgBtn       * ownMediaBtn;
@property (nonatomic,strong) imgBtn       * toolNotifyBtn;
@property (nonatomic,strong) AddButton     * moreRelativeBtn;
@property (nonatomic,strong) UICollectionView * collecView;
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayer;
@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setSubViews{
    self.title          = @"首页";
    self.relativePicBtn =[self Tag:0 Name:@"亲友相册" img:@"home"];
    self.relativeVideoBtn =[self Tag:1 Name:@"视频" img:@"home2"];
    self.ownMediaBtn   = [self Tag:2 Name:@"我的相册" img:@"home3"];
    self.toolNotifyBtn = [self Tag:3 Name:@"平台" img:@"home1"];
   
    self.flowLayer = [[UICollectionViewFlowLayout alloc]init];
     [self.flowLayer setScrollDirection:UICollectionViewScrollDirectionHorizontal ];
    self.collecView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.flowLayer];
    self.collecView.delegate   = self;
    self.collecView.dataSource = self;
    self.collecView.backgroundColor = [UIColor whiteColor];
    [self.collecView registerClass:[relativeCollCell class] forCellWithReuseIdentifier:@"relativeCollCell"];
    self.collecView.showsHorizontalScrollIndicator = NO;
    self.moreRelativeBtn = [[AddButton alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
    //self.moreRelativeBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:7];
    //[self.moreRelativeBtn setTitleColor:ColorFF(0x999999) forState:UIControlStateNormal];
    //[self.moreRelativeBtn setTitle:@"更多" forState:UIControlStateNormal];
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
//     [self.relativePicBtn.img  sd_setImageWithURL:[NSURL URLWithString:@"http://img.wdjimg.com/image/video/2d93c9404ff0218c4ca4c537cb6482e9_0_0.jpeg"]];
//    [self.relativeVideoBtn.img sd_setImageWithURL:[NSURL URLWithString:@"http://img.wdjimg.com/image/video/d536b9c09b2681630afcc92222599f0e_0_0.jpeg"]];
//    [self.ownMediaBtn.img sd_setImageWithURL:[NSURL URLWithString:@"http://img.wdjimg.com/image/video/d536b9c09b2681630afcc92222599f0e_0_0.jpeg"]];
//     [self.toolNotifyBtn.img sd_setImageWithURL:[NSURL URLWithString:@"http://img.wdjimg.com/image/video/d536b9c09b2681630afcc92222599f0e_0_0.jpeg"]];
}

- (void)selectInfo: (UIButton *) sender{
    
    if (sender.tag==0){
        relativePhotoVC * relative = [[relativePhotoVC alloc]init];
        [self pushViewController:relative animated:YES];
      
    }else if(sender.tag==1){
       
        videosVC* videoTab = [[ videosVC alloc]init];
        
       
        [self pushViewController:videoTab animated:YES];
        
    }else if(sender.tag==2){
        relativeInfoVC * info = [[relativeInfoVC alloc]init];
        [self pushViewController:info animated:YES];
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
    return 10;
}

//设置元素内容
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify =@"relativeCollCell";
    relativeCollCell    *cell =[collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.radio = YES;
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
//    [self.relativePicBtn.img  sd_setImageWithURL:[NSURL URLWithString:@"http://img.wdjimg.com/image/video/d536b9c09b2681630afcc92222599f0e_0_0.jpeg"]];
//    [self.relativeVideoBtn.img sd_setImageWithURL:[NSURL URLWithString:@"http://img.wdjimg.com/image/video/2d93c9404ff0218c4ca4c537cb6482e9_0_0.jpeg"]];
    
}


- (imgBtn*)Tag:(NSInteger )tag Name:(NSString *)name img:(NSString *)img{
    imgBtn * btn = [[imgBtn alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth/2.0,(KScreenWidth/2.0-10)/0.75)];
    btn.tag =tag;
    btn.name.text =name;
    btn.icon.image = [UIImage imageNamed:img];
    [btn addTarget:self action:@selector(selectInfo:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}




@end
