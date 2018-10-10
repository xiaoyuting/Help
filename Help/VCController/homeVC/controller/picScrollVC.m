//
//  picScrollVC.m
//  Help
//
//  Created by GM on 2018/10/9.
//  Copyright © 2018年 Ugliest. All rights reserved.
//

#import "picScrollVC.h"

@interface picScrollVC ()
@property (nonatomic,strong)UITableView  * tab;

@end

@implementation picScrollVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tab = [[UITableView alloc]init];
    [self.view sd_addSubviews:@[self.tab]];
    self.tab.sd_layout.spaceToSuperView(UIEdgeInsetsMake([self naviGationH], 0, 0, 44));

    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
