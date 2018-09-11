//
//  relativePhotoVC.m
//  HELPXY
//
//  Created by GM on 2018/5/7.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "relativePhotoVC.h"
#import "relativeCell.h"
#import "photosVC.h"

@interface relativePhotoVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView  * relative;
@end

@implementation relativePhotoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubviews];
}
- (void)setSubviews{
    self.relative   = [[UITableView alloc]init];
    self.relative . delegate  = self;
    self.relative .dataSource = self;
    self.relative .separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view sd_addSubviews:@[self.relative]];
    self.relative.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake([self naviGationH], 0, 0, 0));
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  return [tableView
                    cellHeightForIndexPath:indexPath
                    model:nil
                    keyPath:@"dicInfoRelative"
                    cellClass:[relativeCell  class]
                    contentViewWidth:[self cellContentViewWith]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * str = @"relative";
    relativeCell * cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell){
        cell = [[relativeCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
    
    }
    cell.dicInfoRelative = nil;
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    photosVC * photo = [[photosVC alloc]init];
    [self pushViewController:photo animated:YES];
}

@end
