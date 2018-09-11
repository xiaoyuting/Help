//
//  registVC.m
//  HELPXY
//
//  Created by GM on 2018/5/7.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "registVC.h"
#import "cinView.h"
#import "SegmentCate.h"
#import "AVCaptureViewController.h"

#import "CheakViewController.h"
@interface registVC ()<scanDelegate>
@property (nonatomic,strong) cinView * oldMan;
@property (nonatomic,strong) cinView * server;
@property (nonatomic,strong) cinView * relative;

@property (nonatomic,strong) UIImageView * line;
@property (nonatomic,strong) SegmentCate * selectMode;

@end

@implementation registVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubviews];
    
}
- (void)rightItemClick:(id)sender{
   
}
- (void)scanInvateID:(NSString *)str{
    self.relative.inviteID.cinField.text=str;
}
- (void)setSubviews{
    self.title = @"注册";
    __weak typeof(self) weakSelf = self;
    self.line = [[UIImageView alloc]init];
    self.line.backgroundColor = [UIColor lightGrayColor];
    self.oldMan = [[cinView alloc]initWithFrame:CGRectZero viewType:typeRG category:oldMan];
    self.server = [[cinView alloc]initWithFrame:CGRectZero viewType:typeRG category:server];
    self.relative  = [[cinView alloc]initWithFrame:CGRectZero viewType:typeRG category:relatives];
    self.oldMan.personInfo = ^{
        AVCaptureViewController *AVCaptureVC = [[AVCaptureViewController alloc] init];
        AVCaptureVC.info = ^(NSDictionary *dic) {
            weakSelf.oldMan.name.cinField.text =[dic objectForKey:@"name"];
            weakSelf.oldMan.personID.cinField.text =[dic objectForKey:@"phone"];
        };
        [weakSelf pushViewController:AVCaptureVC animated:YES];
    };
    self.relative.personInfo = ^{
        AVCaptureViewController *AVCaptureVC = [[AVCaptureViewController alloc] init];
        AVCaptureVC.info = ^(NSDictionary *dic) {
            weakSelf.relative.name.cinField.text =[dic objectForKey:@"name"];
            weakSelf.relative.personID.cinField.text =[dic objectForKey:@"phone"];
        };
        [weakSelf pushViewController:AVCaptureVC animated:YES];
    };
    self.relative.invite = ^{
        CheakViewController * vc = [[CheakViewController alloc]init];
        vc.IDdelegate =weakSelf;
        [weakSelf pushViewController:vc animated:YES];
        
    };
    self.server.personInfo = ^{
        AVCaptureViewController *AVCaptureVC = [[AVCaptureViewController alloc] init];
        AVCaptureVC.info = ^(NSDictionary *dic) {
            weakSelf.server.name.cinField.text =[dic objectForKey:@"name"];
            weakSelf.server.personID.cinField.text =[dic objectForKey:@"phone"];
        };
        [weakSelf pushViewController:AVCaptureVC animated:YES];
    };
   
    self.oldMan.regist = ^{
        [weakSelf regist:@{
                           @"idCard":   weakSelf.oldMan.personID.cinField.text,
                           @"password": weakSelf.oldMan.password.cinField.text,
                           @"phone":    weakSelf.oldMan.phone.cinField.text,
                           @"realName": weakSelf.oldMan.name.cinField.text
                           //@"agedSignUpTO":@"agedSignUpTO"
                           }
                     url:URL_regOld
                    view:weakSelf.oldMan];
    };
    self.relative.regist =^{
        if ([ugliestTools isStrEmpty:weakSelf.server.inviteID.cinField.text]){
            [weakSelf showProgressTitle:@"请输入邀请码" autoHide:YES];
            return;
        }
        [weakSelf regist:@{
                           @"idCard":   weakSelf.server.personID.cinField.text,
                           @"password": weakSelf.server.password.cinField.text,
                           @"phone":    weakSelf.server.phone.cinField.text,
                           @"realName": weakSelf.server.name.cinField.text,
                            @"inviteCode":weakSelf.server.inviteID.cinField.text,
                           @"relativeSignUpTO":@"relativeSignUpTO"
                           }
                     url:URL_regRelat
                    view:weakSelf.relative];
    };
    self.server.regist = ^{
        
        [weakSelf regist:@{
                           @"idCard":   weakSelf.server.personID.cinField.text,
                           @"password": weakSelf.server.password.cinField.text,
                           @"phone":    weakSelf.server.phone.cinField.text,
                           @"realName": weakSelf.server.name.cinField.text,
                           @"personalServiceSignUpTO":@"personalServiceSignUpTO"
                           }
                     url:URL_regServer
                    view:weakSelf.server];
    };
    
    self.selectMode  = [[SegmentCate alloc]initWithFrame:CGRectMake(0,[self naviGationH] , KScreenWidth, 40) titleArray:@[@"老人",@"亲朋",@"助老服务者"]];
    self.selectMode.titleWidth = KScreenWidth/3.0;
    self.selectMode.segmentedControlTitleSpacingStyle = SegmentedControlTitleSpaceStyleFixed;
    self.selectMode.selectedTextColor = themesColor;
    self.selectMode.showSplitLine =YES;
    self.selectMode.lineViewFill =YES;
    self.selectMode.lineColor = themesColor;
    self.selectMode.defaultSelectedIndex =0;
    [self.selectMode segmentedControlSelectedWithBlock:^(SegmentCate *segmentedControl, NSInteger selectedIndex) {
        NSLog(@"selectedIndex : %zd", selectedIndex);
        switch (selectedIndex) {
            case 0:
                self.oldMan.hidden   =NO;
                self.relative.hidden =YES;
                self.server.hidden   =YES;
            
                break;
            case 1:
                self.oldMan.hidden   =YES;
                self.relative.hidden =NO;
                self.server.hidden   =YES;
            
                break;
            case 2:
                self.oldMan.hidden   =YES;
                self.relative.hidden =YES;
                self.server.hidden   =NO;
             
                break;
             
        
                break;
            default:
                break;
        }
    }];
   
    [self.view sd_addSubviews:@[self.line,self.selectMode,self.oldMan,self.server,self.relative   ]];
    self.line.sd_layout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .heightIs(1)
    .topSpaceToView(self.view, [self naviGationH]+39);
    self.oldMan.sd_layout.topSpaceToView(self.selectMode, 30)
    .leftSpaceToView(self.view, 40 )
    .rightSpaceToView(self.view, 40)
    .heightIs(280);
    self.server.sd_layout.topSpaceToView(self.selectMode, 30)
    .leftSpaceToView(self.view, 40 )
    .rightSpaceToView(self.view, 40)
    .heightIs(340);
    self.relative.sd_layout.topSpaceToView(self.selectMode, 30)
    .leftSpaceToView(self.view, 40 )
    .rightSpaceToView(self.view, 40)
    .heightIs(340);
 
    self.oldMan.hidden =NO;
    self.relative.hidden =YES;
    self.server.hidden =YES;
 
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}
- (void)regist:(NSDictionary *)info url:(NSString *)url  view:(cinView *)vc{
    if (![ugliestTools isPhone:vc .phone.cinField.text]){
        [self showProgressTitle:@"手机号输入有误" autoHide:YES];
        return ;
    }
    if ([ugliestTools isStrEmpty:vc.password.cinField.text]){
        [self showProgressTitle:@"请输入密码" autoHide:YES];
        return;
    }
    if ([ugliestTools isStrEmpty:vc.personID.cinField.text]){
        [self showProgressTitle:@"请输入身份证号" autoHide:YES];
        return;
    }
    if ([ugliestTools isStrEmpty:vc.name.cinField.text]){
        [self showProgressTitle:@"请输入姓名" autoHide:YES];
        return;
    }
   
    [RequestManager requestWithType:HttpRequestTypePost
                          urlString: url
                         parameters:info
                       successBlock:^(id response) {
                           NSLog(@"response===%@",response);
                           if (response[@"status"]){
                               NSMutableArray *tmpArr=[NSMutableArray array];
                               NSDictionary *dic = response[@"data"];
                               [tmpArr addObjectsFromArray:dic[@"results"]];
                              
                           }
                           
                           
                       } failureBlock:^(NSError *error) {
                           
                       } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                           
                       }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //[self regist];
}
- (void)cheakInfoView:(cinView *)vc{
    
}
@end
