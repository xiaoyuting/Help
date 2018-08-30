//
//  photosVC.m
//  HELPXY
//
//  Created by GM on 2018/5/8.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "photosVC.h"
#import "photoCell.h"
#import "SDAutoLayout.h"
@interface photosVC ()<UITableViewDelegate,UITableViewDataSource>
@property   (nonatomic,strong)UITableView * tab  ;

@end

@implementation photosVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubviews];
    // Do any additional setup after loading the view.
}

- (void)setSubviews{
    self.tab = [[UITableView alloc]init];
    self.tab.delegate   = self;
    self.tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tab.dataSource = self;
    [self.view sd_addSubviews:@[self.tab]];
    self.tab.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake([self naviGationH], 0, 0, 0));
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    return    [photoCell  HeightWithArray: @[@"http://ww2.sinaimg.cn/thumbnail/904c2a35jw1emu3ec7kf8j20c10epjsn.jpg",
                                             @"http://ww2.sinaimg.cn/thumbnail/98719e4agw1e5j49zmf21j20c80c8mxi.jpg",
                                             @"http://ww2.sinaimg.cn/thumbnail/642beb18gw1ep3629gfm0g206o050b2a.gif"
                                             ]];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * str = @"photoCell";
    photoCell   * cell =[tableView dequeueReusableCellWithIdentifier:str];
    if (!cell){
        cell = [[photoCell  alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setContentRelativeView:@[@"http://ww2.sinaimg.cn/thumbnail/904c2a35jw1emu3ec7kf8j20c10epjsn.jpg",
                                   @"http://ww2.sinaimg.cn/thumbnail/98719e4agw1e5j49zmf21j20c80c8mxi.jpg",
                                   @"http://ww2.sinaimg.cn/thumbnail/642beb18gw1ep3629gfm0g206o050b2a.gif"
                                   ]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
@end
