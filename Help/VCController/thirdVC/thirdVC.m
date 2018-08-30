//
//  thirdVC.m
//  HELPXY
//
//  Created by GM on 2018/5/7.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "thirdVC.h"
#import "relativeCell.h"
#import "SDAutoLayout.h"
#import "webVC.h"
#import "SDCycleScrollView.h"
#import "ToolButton.h"
#import "WKWebViewController.h"
#define MX YES
@interface thirdVC ()
@property  (nonatomic,strong) UIScrollView  * scrView;
@property  (nonatomic,strong) ToolButton      * game;
@property  (nonatomic,strong) ToolButton      * pet;
@property  (nonatomic,strong) ToolButton      * smart;
@property  (nonatomic,strong) ToolButton      * puton;
@property  (nonatomic,strong) UIImageView     * img;
//@property  (nonatomic,strong) SDCycleScrollView * scrPic;
@end

@implementation thirdVC

- (void)viewDidLoad {
//#if MX
////#elif MX>0
//#else
//#endif
//#if defined(MX)
//#endif
//#ifdef MX
//#endif
//#if MAX == 0
//         printf("MAX是0");
//#elif MAX > 0
//         printf("MAX大于0");
//#else
//             printf("MAX小于0");
//#endif
    [super viewDidLoad];
    [self setSubviews];
    // Do any additional setup after loading the view.
}
- (void)setSubviews{
    self.title =@"工具";
    self.scrView = [[UIScrollView alloc]init];
    self.scrView.showsVerticalScrollIndicator =NO;
    self.scrView.showsHorizontalScrollIndicator =NO;
//    self.scrPic = [[SDCycleScrollView alloc]init];
//    self.scrPic.imageURLStringsGroup =@[@"http://img.wdjimg.com/image/video/2d93c9404ff0218c4ca4c537cb6482e9_0_0.jpeg",@"http://img.wdjimg.com/image/video/489070df80a1f699ef2b6c84cac13f21_0_0.jpeg",@"http://img.wdjimg.com/image/video/72c193615840f4ed82e84f99f88fe7c2_0_0.jpeg"];
    
    self.img = [[UIImageView alloc]init];
    self.img.image = [UIImage  imageNamed:@"tool5"];
    [self.view sd_addSubviews:@[self.scrView,self.img]];
  
    self.game =[self setbuttonTag:0 title:@"美食生活" img:@"tool1"];
    self.pet =[self setbuttonTag:1 title:@"风景掠影" img:@"tool2"];
    self.smart =[self setbuttonTag:2 title:@"最新资讯" img:@"tool3"];
    self.puton =[self setbuttonTag:3 title:@"求医指南" img:@"tool4"];
//    self.scrPic.sd_layout
//    .spaceToSuperView(UIEdgeInsetsMake([self naviGationH], 0, [self tabBarH]+90, 0));
    [self.scrView sd_addSubviews:@[self.game,self.pet,self.smart,self.puton]];
    self.scrView.sd_layout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .topSpaceToView(self.view, [self naviGationH])
    .heightIs(90);
    self.img.sd_layout
    .topSpaceToView(self.scrView, 0)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .heightIs(50);
    self.game.sd_layout
    .topSpaceToView(self.scrView, 10)
    .leftSpaceToView(self.scrView, 10)
    .heightIs(70)
   .widthIs((KScreenWidth-50)/4.0);
    
    self.pet.sd_layout
    .topSpaceToView(self.scrView, 10)
    .leftSpaceToView(self.game, 10)
    .heightIs(70)
    .widthIs((KScreenWidth-50)/4.0);
    
    self.smart.sd_layout
    .topSpaceToView(self.scrView, 10)
    .leftSpaceToView(self.pet, 10)
    .heightIs(70)
   .widthIs((KScreenWidth-50)/4.0);
    
    self.puton.sd_layout
    .topSpaceToView(self.scrView, 10)
    .leftSpaceToView(self.smart, 10)
    .heightIs(70)
    .widthIs((KScreenWidth-50)/4.0);
    
    [self.scrView setupAutoContentSizeWithRightView:self.puton rightMargin:10];
    
}
- (ToolButton *)setbuttonTag:(NSInteger )tag title:(NSString *)title img:(NSString *)img{
    ToolButton * btn = [[ToolButton alloc]initWithFrame:CGRectMake(0, 0, (KScreenWidth-50)/4.0, 70)];
    btn.layer.borderColor = ColorFF(0xEDEDED).CGColor;
    btn.layer.borderWidth = 1;
    btn.layer.cornerRadius =5;
    btn.tag =tag;
 
    btn.title.text = title;
    btn.icon.image = [UIImage imageNamed:img];
    [btn addTarget:self  action:@selector(selectView:) forControlEvents:UIControlEventTouchUpInside];
 
    return  btn;
    
}
- (void)selectView:(UIButton *) sender{
    WKWebViewController * vc = [[WKWebViewController alloc]init];
    if (sender.tag ==0){
         [vc loadWebURLSring:@"http://yxyzl.cn/mssh"];
    }else if (sender.tag ==1){
          [vc loadWebURLSring:@"http://yxyzl.cn/fjly"];
    }
    else if (sender.tag ==2){
          [vc loadWebURLSring:@"http://yxyzl.cn/zxzx"];
    }
    else if (sender.tag ==3){
          [vc loadWebURLSring:@"http://yxyzl.cn/qyzn"];
    }
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
