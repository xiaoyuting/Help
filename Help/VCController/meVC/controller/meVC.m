//
//  meVC.m
//  HELPXY
//
//  Created by GM on 2018/5/7.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "meVC.h"
#import "meCell.h"

@interface meVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *  Tab;
@property (nonatomic,strong) NSArray     * arr;
@property (nonatomic,strong) UIImageView * img;
@property (nonatomic,strong) UILabel     * name;
@end

@implementation meVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubviews];
    // Do any additional setup after loading the view.
}

- (void)setSubviews{
    self.arr = @[@[@{@"title":@"我的二维码",@"img":@"me"},@{@"title":@"我的收藏",@"img":@"me1"},@{@"title":@"我拍的支付订单",@"img":@"me2"},@{@"title":@"我的邀请码",@"img":@"me3"}],@[@{@"title":@"版本号",@"img":@"me4"}],@[@{@"title":@"退出",@"img":@"me5"}]];
    self.title = @"我的";
    self.Tab = [[UITableView alloc]init];
    self.Tab.delegate =self;
    self.Tab.dataSource =self;
    self.Tab.tableHeaderView = [self setheaedView];
    self.Tab.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self.view sd_addSubviews:@[self.Tab]];
    self.Tab.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake([self naviGationH], 0, 0, 0));
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (UIView * )setheaedView{
    UIView * head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 56)];
    self.img = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10.5, 35, 35)];
    self. img.layer.cornerRadius =17.5;
    self.img.contentMode = UIViewContentModeScaleAspectFill;
    self.img.clipsToBounds =YES;
   
    //[self.img sd_setImageWithURL:[NSURL URLWithString:@"http://img.wdjimg.com/image/video/d536b9c09b2681630afcc92222599f0e_0_0.jpeg"]];
    [head addSubview:self.img];
    
    self.name = [[UILabel alloc]initWithFrame:CGRectMake(80, 13, 200, 30)];
    self.name.text  =@"名字";
    self.name.textColor =ColorFF(0x333333);
    self.name.font = [UIFont fontWithName:@"PingFangSC-Light" size:13];
    [head addSubview:self.name];
    UIImageView * arrows = [[UIImageView alloc]initWithFrame:CGRectMake( KScreenWidth-40
                                                                        , 18,20,20)];
    arrows .image = [UIImage imageNamed:@"img"];
    [head addSubview:arrows];
    
    return head;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.arr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray * arr = self.arr[section];
    return arr.count;
}
//- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    UIView * v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 2)];
//    v.backgroundColor = ColorFF(0xEAEAEA);
//    return v;
//}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 5)];
    head.backgroundColor = ColorFF(0xEAEAEA);
    return head ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * str = @"toolcell";
    meCell  * cell =[tableView dequeueReusableCellWithIdentifier:str];
    if (!cell){
        cell = [[meCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
    }
    NSArray * arr =self.arr[indexPath.section];
    cell.infoDic = arr[indexPath.row];
    if ([[NSString stringWithFormat:@"%ld",indexPath.section] isEqualToString:@"2"]){
        cell.arrowsStatus = YES;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
@end
