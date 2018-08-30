//
//  photoCell.m
//  HELPXY
//
//  Created by GM on 2018/5/8.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "photoCell.h"
#import "bottomView.h"
#import "relativeCollCell.h"
@interface  photoCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  >
{
    
   

    
    
  

  
}
@property (nonatomic,strong)  UIImageView * avrater;
@property (nonatomic,strong)  UICollectionView  * collecView;
@property (nonatomic,strong)  UILabel     * name;
@property (nonatomic,strong)  UILabel * titleLab;
@property (nonatomic,strong)  UICollectionViewFlowLayout *flowLayer;
@property (nonatomic,strong)  UIImageView * line;
@property (nonatomic,strong)  bottomView      * bottomview;
@end

@implementation photoCell
@synthesize avrater,collecView,name,titleLab,flowLayer,line,bottomview;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if( self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        avrater =[[UIImageView alloc]init];
        avrater.frame = CGRectMake(8, 8, 52, 52);
        avrater.layer.cornerRadius =26 ;
        avrater.clipsToBounds = YES;
        avrater.contentMode = UIViewContentModeScaleAspectFill;
          [self.contentView addSubview:avrater];
        name = [[UILabel alloc]init];
        [self.contentView addSubview:name];
        
        titleLab =[[UILabel alloc]init];
        titleLab.numberOfLines  =0;
        titleLab.font = SYSTEMFONT(14);
        titleLab.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview: titleLab];
        
        flowLayer = [[UICollectionViewFlowLayout alloc]init];
        collecView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayer];
        collecView.delegate   = self;
        collecView.dataSource = self;
        [collecView registerClass:[relativeCollCell class] forCellWithReuseIdentifier:@"cell"];
        collecView.showsHorizontalScrollIndicator = NO;
        collecView.backgroundColor = [UIColor whiteColor];
        bottomview = [[bottomView alloc]init];
    }
    return self;
}
-(void)setContentView:(NSArray *)dataArray
{
    self.picArray=@[@"http://ww2.sinaimg.cn/thumbnail/904c2a35jw1emu3ec7kf8j20c10epjsn.jpg",
                    @"http://ww2.sinaimg.cn/thumbnail/98719e4agw1e5j49zmf21j20c80c8mxi.jpg",
                    @"http://ww2.sinaimg.cn/thumbnail/642beb18gw1ep3629gfm0g206o050b2a.gif"
                    ];
    [self setSubView];
}
-(void)setSubView{
    CGFloat  ZH =0;
    [avrater sd_setImageWithURL:[NSURL URLWithString:@"http://img.wdjimg.com/image/video/d536b9c09b2681630afcc92222599f0e_0_0.jpeg"]];
    ZH = 70 ;
    CGFloat titleH = [photoCell getTextHeight:KScreenWidth-20 text:@"wqewqewqewqewqewqewqewqewqewqewqewewqewqewqewqewqewqewqewqewqewqewqewqewqewq" font:SYSTEMFONT(14)];
    titleLab.frame =CGRectMake(10, ZH, KScreenWidth-20, titleH);
    
    titleLab.text = @"wqewqewqewqewqewqewqewqewqewqewqewewqewqewqewqewqewqewqewqewqewqewqewqewqewq" ;
    ZH = ZH+titleH+10;
    
    collecView.frame = CGRectMake(0, ZH, KScreenWidth, [self HeightWithCollview:self.picArray]);
    ZH =ZH+[self HeightWithCollview:self.picArray]+10;
    bottomview.frame= CGRectMake(0, ZH, KScreenWidth, 30);
   
    [self.contentView addSubview:bottomview];
    ZH=ZH+30+9;
    line = [[UIImageView alloc]initWithFrame:CGRectMake(10, ZH, KScreenWidth-20, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
 
    [self.contentView addSubview: collecView];
    [self.contentView addSubview: line];
    
    
    
    
}
-(void)setContentRelativeView:(NSArray *)dataArray
{
    self.picArray=@[@"http://ww2.sinaimg.cn/thumbnail/904c2a35jw1emu3ec7kf8j20c10epjsn.jpg",
                    @"http://ww2.sinaimg.cn/thumbnail/98719e4agw1e5j49zmf21j20c80c8mxi.jpg",
                    @"http://ww2.sinaimg.cn/thumbnail/642beb18gw1ep3629gfm0g206o050b2a.gif"
                    ];
    [self setRelativetSubView];
}
-(void)setRelativetSubView{
    titleLab = [[UILabel alloc]init];
  
    
   collecView.frame = CGRectMake(0,  70, KScreenWidth, [self HeightWithCollview:self.picArray]);
    line = [[UIImageView alloc]initWithFrame:CGRectMake(10, [self HeightWithCollview:self.picArray]+70, KScreenWidth-20, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
 
 
    [self.contentView addSubview: collecView];
    [self.contentView addSubview: line];
    
    
    
    
}


//设置分区
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView{
    
    return 1;
}

//每个分区上的元素个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.picArray .count;
}

//设置元素内容
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify =@"cell";
   relativeCollCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.imgUrl  = self.picArray[indexPath.row];
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
}
/** 头部的尺寸*/
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
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}
- (CGFloat)HeightWithCollview:(NSArray *)array{
    CGFloat height;
    if (array.count%3==0) {
        
        height=array.count/3*(KScreenWidth-40)/3.0+(array.count/3+1)*10;
    }else{
        
        height=(array.count/3+1)*(KScreenWidth-40)/3.0+(array.count/3+2)*10;
    }
    
    return height;
}

+ (CGFloat)HeightWithArray:(NSArray *)array
{
    CGFloat height;
    if (array.count%3==0) {
        
        height=array.count/3*(KScreenWidth-40)/3.0+(array.count/3+1)*10;
    }else{
        
        height=(array.count/3+1)*(KScreenWidth-40)/3.0+(array.count/3+2)*10;
    }
    height = height+40+40;
    
    return height;
}
+ (CGFloat)HeightWithZanArray:(NSArray *)array
{
    CGFloat height = 0;
    if (array.count%3==0) {
        
        height=array.count/3*(KScreenWidth-40)/3.0+(array.count/3+1)*10;
    }else{
        
        height=(array.count/3+1)*(KScreenWidth-40)/3.0+(array.count/3+2)*10;
    }
    height = height+130+ [photoCell getTextHeight:KScreenWidth-20 text:@"wqewqewqewqewqewqewqewqewqewqewqewewqewqewqewqewqewqewqewqewqewqewqewqewqewq" font:SYSTEMFONT(14)];;
    
    return height;
}
+ (float)getTextHeight:(float)textWidth text:(NSString *)text font:(UIFont *)font {
    if (!text.length) {
        return 0;
    }
    float origin = [text boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: font} context:nil].size.height;
    return ceilf(origin);
}

#pragma mark  SDPhotoBrowserDelegate

//// 返回临时占位图片（即原来的小图）
//- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
//{
//    // 不建议用此种方式获取小图，这里只是为了简单实现展示而已
//    UICollectionViewCell *cell = (UICollectionViewCell *)[self collectionView:collecView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
//
//    return nil;
//
//}
//
//
//// 返回高质量图片的url
//- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
//{
//    NSString *urlStr =  [self.picArray[index]stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
//    return [NSURL URLWithString:urlStr];
//}
@end
