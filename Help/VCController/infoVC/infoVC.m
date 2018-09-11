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

#import "SegmentCate.h"
#import "infoModel.h"
#import "usermedModel.h"
#import "SDTimeLineCell.h"

#define kTimeLineTableViewCellId @"SDTimeLineCell"

@interface infoVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property   (nonatomic,strong)UITableView *   recTab;
@property   (nonatomic,strong)UITableView * localTab;
@property   (nonatomic,strong)SegmentCate * selectMode;
@property   (nonatomic,strong)UIScrollView * contentSrcView;

@property   (nonatomic,strong)NSMutableArray * info;
@property   (nonatomic,assign)int    recTag;

@end

@implementation infoVC

- (void)viewDidLoad {
    self.info = [[NSMutableArray   alloc]init];
    self.recTag = 1;
    [super viewDidLoad];
    [self setSubviews];
  
    // Do any additional setup after loading the view.
}

- (void)setSubviews{
    [self setNavRightItemTitle:@"添加" andImage:nil];
    self.title= @"友邻";
     __weak typeof(self) weakSelf = self;

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
    self.recTab.estimatedRowHeight = 0;
    self.recTab.estimatedSectionFooterHeight = 0;
    self.recTab.estimatedSectionHeaderHeight = 0;
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
   self.recTab.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(recHeadRef)];
    self.recTab.mj_footer = [MJRefreshBackNormalFooter  footerWithRefreshingTarget:self refreshingAction:@selector(recFootRef)];
    [self.recTab.mj_header beginRefreshing];
}
- (void)recHeadRef{
    [self.info removeAllObjects];
    self.recTag =1;
    [self Recrequest:self.recTag];
    [self.recTab.mj_header endRefreshing];
}

- (void)recFootRef{
    self.recTag ++;
    [self Recrequest:self.recTag];
    [self.recTab.mj_footer endRefreshing];
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
    return self.info.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
    id model = self.info[indexPath.row];
    return [self.recTab cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[SDTimeLineCell class] contentViewWidth:[self cellContentViewWith]];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SDTimeLineCell *cell = [tableView dequeueReusableCellWithIdentifier:kTimeLineTableViewCellId];
    cell.indexPath = indexPath;
    __weak typeof(self) weakSelf = self;
    if (!cell.moreButtonClickedBlock) {
        [cell setMoreButtonClickedBlock:^(NSIndexPath *indexPath) {
            usermedModel *model = weakSelf.info[indexPath.row];
           // model.isOpening = !model.isOpening;
            [weakSelf.recTab reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
      
    }
    
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    ///////////////////////////////////////////////////////////////////////
    
    cell.model = self.info[indexPath.row];
 
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)Recrequest:(int)tag{
    [RequestManager requestWithType:HttpRequestTypeGet
                          urlString:URL_moment_recommend2 parameters:@{
                                        @"pageNum":[NSString stringWithFormat:@"%d",tag],
                                       @"pageSize":@"5"
                                                                                                    }
                       successBlock:^(id response) {
                        DLog(@"response==%@",response);
                         infoModel  * model = [infoModel yy_modelWithJSON:response ];
                           [self.info addObjectsFromArray: model.data];
                           [self.recTab reloadData];
                    
                           NSLog(@"self.model==%@",model.code);
                       }
                       failureBlock:^(NSError *error) {
                                                                                                        
                                                                                                    }
                           progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                                                                                                        
                                                                                                    }];
}
@end
