//
//  infoVC.m
//  HELPXY
//
//  Created by GM on 2018/5/7.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "infoVC.h"
#import "uploadPicVC.h"
#import "photoCell.h"
#import "SDAutoLayout.h"
#import "SegmentCate.h"
@interface infoVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property   (nonatomic,strong)UITableView *   recTab;
@property   (nonatomic,strong)UITableView * localTab;
@property   (nonatomic,strong)SegmentCate * selectMode;
@property   (nonatomic,strong)UIScrollView * contentSrcView;

@end

@implementation infoVC

- (void)viewDidLoad {
    [self request];
    [super viewDidLoad];
    [self setSubviews];
    // Do any additional setup after loading the view.
}

- (void)setSubviews{
    [self setNavRightItemTitle:@"添加" andImage:nil];
    self.title= @"友邻";

    self.selectMode  = [[SegmentCate alloc]initWithFrame:CGRectMake(0,[self naviGationH] , KScreenWidth, 40) titleArray:@[@"推荐",@"附近的人"]];
    self .selectMode .segmentedControlTitleSpacingStyle = SegmentedControlTitleSpaceStyleFixed;
    self.selectMode.showSplitLine=YES;
    self. selectMode .titleWidth = KScreenWidth /2.0;
    self.selectMode.showSplitLine =YES;
    self.selectMode.splitLineColor = ColorFF(0xEAEAEA);
    self.selectMode.lineColor =[UIColor redColor];
    self.selectMode.selectedTextColor = ColorFF(0x78C34E);
    self.selectMode.lineColor = ColorFF(0x78C34E);
    self.selectMode.defaultSelectedIndex =0;
    [self.selectMode segmentedControlSelectedWithBlock:^(SegmentCate *segmentedControl, NSInteger selectedIndex) {
        NSLog(@"selectedIndex : %zd", selectedIndex);
         [self.contentSrcView setContentOffset:CGPointMake(selectedIndex * KScreenWidth, 0) animated:YES];
    }];
    
    [self.view addSubview:self.selectMode];
    
 
    self.localTab = [[UITableView alloc]init];
    self.localTab.delegate   = self;
    self.localTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.localTab.dataSource = self;
    self.localTab.backgroundColor = [UIColor whiteColor];
    self.recTab = [[UITableView alloc]init];
    self.recTab.delegate   = self;
    self.recTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.recTab.dataSource = self;
    self.recTab.backgroundColor = [UIColor whiteColor];
    self.contentSrcView = [UIScrollView new];
    [self.view addSubview:self.contentSrcView];
    
    [self.contentSrcView sd_addSubviews:@[self.recTab,self.localTab]];
    self.contentSrcView.delegate = self;
    self.contentSrcView.pagingEnabled = YES;
   self.contentSrcView.sd_layout.spaceToSuperView(UIEdgeInsetsMake([self naviGationH]+40,0 , 0, 0 ));
    self.recTab.sd_layout
    .leftEqualToView(self.contentSrcView)
    .topEqualToView(self.contentSrcView)
    .bottomEqualToView(self.contentSrcView)
    .widthIs(KScreenWidth);
    self.localTab.sd_layout
    .leftSpaceToView(self.recTab, 0)
    .topEqualToView(self.contentSrcView)
    .bottomEqualToView(self.contentSrcView)
    .widthIs(KScreenWidth);
    [self.contentSrcView setupAutoContentSizeWithRightView:self.localTab rightMargin:0];
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if([scrollView isEqual:self.contentSrcView]){
        NSInteger const kPageIndex = scrollView.contentOffset.x / KScreenWidth;
        [self.selectMode segmentedControlSetSelectedIndexWithSelectedBlock:kPageIndex];
        // 重设选中位置
        [self.selectMode segmentedControlSetSelectedIndex:kPageIndex];}
}

- (void)rightItemClick:(id)sender{
    uploadPicVC * pic = [[uploadPicVC alloc]init];
    [self pushViewController:pic animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return    [photoCell  HeightWithZanArray: @[@"http://ww2.sinaimg.cn/thumbnail/904c2a35jw1emu3ec7kf8j20c10epjsn.jpg",
                                                @"http://ww2.sinaimg.cn/thumbnail/98719e4agw1e5j49zmf21j20c80c8mxi.jpg",
                                                @"http://ww2.sinaimg.cn/thumbnail/642beb18gw1ep3629gfm0g206o050b2a.gif"
                                                ]];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * str = @"infoCell";
    photoCell   * cell =[tableView dequeueReusableCellWithIdentifier:str];
    if (!cell){
        cell = [[photoCell  alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setContentView:@[@"http://ww2.sinaimg.cn/thumbnail/904c2a35jw1emu3ec7kf8j20c10epjsn.jpg",
                           @"http://ww2.sinaimg.cn/thumbnail/98719e4agw1e5j49zmf21j20c80c8mxi.jpg",
                           @"http://ww2.sinaimg.cn/thumbnail/642beb18gw1ep3629gfm0g206o050b2a.gif"
                           ]];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)request{
    [RequestManager requestWithType:HttpRequestTypeGet
                          urlString:URL_moment_recommend2 parameters:@{@"pageNum":@"1",
                                                                    @"pageSize":@"3"
                                                                                                    }
                       successBlock:^(id response) {
                        DLog(@"response==%@",response);
                                                                                                    }
                       failureBlock:^(NSError *error) {
                                                                                                        
                                                                                                    }
                           progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                                                                                                        
                                                                                                    }];
}
@end
