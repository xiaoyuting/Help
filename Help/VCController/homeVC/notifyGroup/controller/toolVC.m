//
//  toolVC.m
//  HELPXY
//
//  Created by GM on 2018/5/30.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "toolVC.h"
#import "ToolCell.h"
#import "SDAutoLayout.h"
@interface toolVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * toolTab;
@property (nonatomic,strong) NSArray     * arr;
@end

@implementation toolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubviews];
}

- (void)setSubviews{
    self.title = @"平台";
    self.arr =@[@"问卷调查",@"推送",@"商品",@"娱乐",@"定时提醒"];
    self.toolTab = [[UITableView alloc]init];
    self.toolTab.delegate =self;
    self.toolTab.dataSource =self;
    self.toolTab.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self.view sd_addSubviews:@[self.toolTab]];
    self.toolTab.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake([self naviGationH], 0, 0, 0));
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView cellHeightForIndexPath:indexPath
                                       model:self.arr[indexPath.row]
                                     keyPath:@"content"
                                   cellClass:[ToolCell class]
                            contentViewWidth:[self cellContentViewWith]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * str = @"toolcell";
    ToolCell  * cell =[tableView dequeueReusableCellWithIdentifier:str];
    if (!cell){
        cell = [[ToolCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
    }
    cell.content=self.arr[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
