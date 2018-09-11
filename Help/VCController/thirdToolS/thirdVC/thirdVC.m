//
//  thirdVC.m
//  HELPXY
//
//  Created by GM on 2018/5/7.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "thirdVC.h"
#import "relativeCell.h"
#import "webVC.h"
#import "SDCycleScrollView.h"
#import "ToolButton.h"
#import "WKWebViewController.h"
#import "thirdmodel.h"
#import "companymodel.h"
#import "ThirdCell.h"
#import "thirdDetaileVC.h"
#define MX YES
@interface thirdVC ()<UITableViewDelegate,UITableViewDataSource>
@property  (nonatomic,strong) UIScrollView  * scrView;
@property  (nonatomic,strong) ToolButton      * game;
@property  (nonatomic,strong) ToolButton      * pet;
@property  (nonatomic,strong) ToolButton      * smart;
@property  (nonatomic,strong) ToolButton      * puton;
@property  (nonatomic,strong) UIImageView     * img;
@property  (nonatomic,strong) UITableView     * tab;
@property  (nonatomic,strong) NSMutableArray  * comarr;
@property  (nonatomic,assign) int  comTag;
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
    self.comarr = [NSMutableArray array];

    self.scrView = [[UIScrollView alloc]init];
    self.scrView.showsVerticalScrollIndicator =NO;
    self.scrView.showsHorizontalScrollIndicator =NO;

    
    self.img = [[UIImageView alloc]init];
    self.img.image = [UIImage  imageNamed:@"tool5"];
    self.tab =[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tab.delegate =self;
    self.tab.dataSource = self;
    self.tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view sd_addSubviews:@[self.scrView,self.img,self.tab]];
  
    self.game =[self setbuttonTag:0 title:@"美食生活" img:@"tool1"];
    self.pet =[self setbuttonTag:1 title:@"风景掠影" img:@"tool2"];
    self.smart =[self setbuttonTag:2 title:@"最新资讯" img:@"tool3"];
    self.puton =[self setbuttonTag:3 title:@"求医指南" img:@"tool4"];

   
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
    self.tab.sd_layout
    .topSpaceToView(self.img, 0)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0);
    
    
    self.tab.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(recHeadRef)];
    self.tab.mj_footer = [MJRefreshBackNormalFooter  footerWithRefreshingTarget:self refreshingAction:@selector(recFootRef)];
    [self.tab.mj_header beginRefreshing];
}
- (void)recHeadRef{
    [self.comarr   removeAllObjects];
    self.comTag =1;
    [self requestTag:self.comTag];
    [self.tab.mj_header endRefreshing];
}

- (void)recFootRef{
    self.comTag ++;
    [self requestTag:self.comTag];
    [self.tab.mj_footer endRefreshing];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.comarr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
    companymodel * model = self.comarr [indexPath.row];
    return [self.tab cellHeightForIndexPath:indexPath model:model keyPath:@"commodel" cellClass:[ThirdCell class] contentViewWidth:[self cellContentViewWith]];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * str =@"third";
    ThirdCell * cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(!cell){
        cell = [[ThirdCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
        
    }
    cell.commodel = self.comarr[indexPath.row];
    NSLog(@"cell.commodel===%@",cell.commodel);
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    companymodel * model = self.comarr [indexPath.row];
    thirdDetaileVC  * vc   = [[thirdDetaileVC alloc]init];
    vc.organizationId= model.comid;
    [self pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)requestTag:(int)tag{
    NSDictionary  * dic  = @{
                             @"pageNum":[NSString stringWithFormat:@"%d",tag],
                             @"pageSize":@"3"
                             
                             };
    [RequestManager requestWithType:HttpRequestTypeGet urlString:URL_origanization parameters:dic successBlock:^(id response) {
        thirdmodel  * model = [thirdmodel    yy_modelWithJSON:response];
        [self.comarr addObjectsFromArray:model.data];
        DLog("self.comarr=%@",self.comarr);
        [self.tab reloadData];
        NSLog(@"response=%@",response);
        
    } failureBlock:^(NSError *error) {
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

@end
