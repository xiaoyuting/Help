//
//  thirdDetaileVC.m
//  Help
//
//  Created by GM on 2018/9/10.
//  Copyright © 2018年 Ugliest. All rights reserved.
//

#import "thirdDetaileVC.h"
#import "thirdmodel.h"
#import "companymodel.h"
#import "ThirdCell.h"
#import "imgShowVC.h"
@interface thirdDetaileVC ()<UITableViewDelegate,UITableViewDataSource >
@property  (nonatomic,strong) UITableView     * tab;
@property  (nonatomic,strong) NSMutableArray  * comarr;
@property  (nonatomic,assign) int  comTag;
@end

@implementation thirdDetaileVC
- (void)viewDidLoad{
    [super viewDidLoad];
    [self setSubviews];
}
- (void)setSubviews{
    self.title =@"证书及承诺";
    self.comarr = [NSMutableArray array];
  
    self.tab =[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tab.delegate =self;
    self.tab.dataSource = self;
    self.tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view sd_addSubviews:@[ self.tab]];
   self.tab.sd_layout
    .spaceToSuperView(UIEdgeInsetsZero);
    
    
    self.tab.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(recHeadRef)];
//    self.tab.mj_footer = [MJRefreshBackNormalFooter  footerWithRefreshingTarget:self refreshingAction:@selector(recFootRef)];
    [self.tab.mj_header beginRefreshing];
}
- (void)recHeadRef{
    [self.comarr   removeAllObjects];
    self.comTag =1;
    [self requestTag:self.comTag ];
    [self.tab.mj_header endRefreshing];
}

- (void)recFootRef{
    self.comTag ++;
    [self requestTag:self.comTag];
    [self.tab.mj_footer endRefreshing];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.comarr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
    companymodel    * model = self.comarr [indexPath.row];
    return [self.tab cellHeightForIndexPath:indexPath model:model keyPath:@"detailemodel" cellClass:[ThirdCell class] contentViewWidth:[self cellContentViewWith]];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * str =@"detailemodel";
    ThirdCell * cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(!cell){
        cell = [[ThirdCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
        
    }
    cell.detailemodel= self.comarr[indexPath.row];

    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
     companymodel    * model = self.comarr [indexPath.row];
    imgShowVC * vc = [[imgShowVC alloc]init];
    vc.imgUrl = model.url;
    [self pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)requestTag:(int)tag {
    NSDictionary  * dic  = @{
//                             @"pageNum":[NSString stringWithFormat:@"%d",tag],
//                             @"pageSize":@"3",
                             @"organizationId":self.organizationId
                             };
    [RequestManager requestWithType:HttpRequestTypeGet urlString:URL_organization_id parameters:dic successBlock:^(id response) {
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
