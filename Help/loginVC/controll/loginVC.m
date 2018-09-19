//
//  loginVC.m
//  HELPXY
//
//  Created by GM on 2018/5/2.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "loginVC.h"
#import "AppDelegate.h"
#import "registVC.h"
#import "cinView.h"
#import "forgetVC.h"
#import "AppDelegate+AppService.h"
#import "usernameLogin.h"
#import "phoneLogin.h"
#import "DBInfo.h"
#import "getPersonInfoRequest.h"
@interface loginVC ()
@property (nonatomic,strong)cinView     * ldView;

@property (nonatomic,strong)UIButton     * registBtn;
@property (nonatomic,strong)UIButton     * forgetPWBtn;
@property (nonatomic,strong)UIButton     * loadBtn;
@end

@implementation loginVC

- (void)viewDidLoad {
    self.title =@"登录";
    [super viewDidLoad];
    [self setSubviews ];

}


- (void)setSubviews{

    self.ldView = [[cinView   alloc]initWithFrame:CGRectZero   viewType:typeLD category:0];
    self.registBtn   = [[UIButton alloc]init];
    self.registBtn.tag =0;
    self.registBtn.titleLabel.font =  [UIFont fontWithName:@"PingFangSC-Light" size:11];
    [self.registBtn setTitle:@"现在注册" forState:UIControlStateNormal];
    self.registBtn.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
    [self.registBtn setTitleColor:ColorFF(0x666666) forState:UIControlStateNormal];
    [self.registBtn addTarget:self action:@selector(selectModules:) forControlEvents:UIControlEventTouchUpInside];
    
    self.forgetPWBtn = [[UIButton alloc]init];
    self.forgetPWBtn.tag =1;
     self.forgetPWBtn.contentHorizontalAlignment =UIControlContentHorizontalAlignmentRight;
    self.forgetPWBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:11];
    [self.forgetPWBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [self.forgetPWBtn setTitleColor:ColorFF(0x666666) forState:UIControlStateNormal];
    [self.forgetPWBtn addTarget:self action:@selector(selectModules:) forControlEvents:UIControlEventTouchUpInside];
    
    self.loadBtn     = [[UIButton  alloc]init];
    self.loadBtn.tag = 2;
    [self.loadBtn setTitle:@"登录" forState:UIControlStateNormal];
    self.loadBtn.layer.cornerRadius = 5;
    self.loadBtn.backgroundColor  = themesColor;
    [self.loadBtn addTarget:self action:@selector(selectModules:) forControlEvents:UIControlEventTouchUpInside];
    [self.view sd_addSubviews:@[self.ldView,self.loadBtn,self.registBtn,self.forgetPWBtn]];
    
    self.ldView.sd_layout
    .topSpaceToView(self.view, [self naviGationH]+35)
    .leftSpaceToView(self.view, 30)
    .rightSpaceToView(self.view, 30)
    .heightIs(100);
    
    self.loadBtn.sd_layout
    .leftSpaceToView(self.view, 30)
    .rightSpaceToView(self.view, 30)
    .heightIs(40)
    .topSpaceToView(self.ldView, 25);
    
    self.registBtn.sd_layout
    .topSpaceToView(self.loadBtn, 15)
    .leftSpaceToView(self.view, 30)
    .heightIs(40)
    .widthIs(100);
    
    self.forgetPWBtn.sd_layout
    .topSpaceToView(self.loadBtn, 15)
    .rightSpaceToView(self.view, 30)
    .heightIs(40)
    .widthIs(100);
    
    if ([DBInfo   getInfo]){
      
    self.ldView.password.cinField.text = [[DBInfo   getInfo] objectForKey:@"password"];
    self.ldView.phone.cinField.text = [[DBInfo   getInfo] objectForKey:@"phone"];
    }
    
    
}


-(void)selectModules:(UIButton *)sender{
    if (sender.tag==0){
        registVC * reg = [[registVC alloc]init];
        [self pushViewController:reg animated:YES];
    }else if (sender.tag==1){
        forgetVC  * forget = [[forgetVC alloc]init];
         [self pushViewController:forget animated:YES];
        
    }else if (sender.tag==2){
        [self login];
       
    }
  
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
  //  [[AppDelegate sharedAppDelegate] cinViewTabbar];
}
- (void)login{
    NSLog(@"getToken==%@",[DBInfo getToken]);
    if ( [ugliestTools isStrEmpty:self.ldView.phone.cinField.text]){
        [self showProgressTitle:@"请输入账号或手机号" autoHide:YES];
        return;
    }
    if ([ugliestTools isStrEmpty:self.ldView.password.cinField.text]){
        [self showProgressTitle:@"请输入密码" autoHide:YES];
        return;
    }

    if ([ugliestTools isPhone:self.ldView.phone.cinField.text]){
        [phoneLogin  phoneInfo: @{ @"password": self.ldView.password.cinField.text,
                                   @"phone": self.ldView.phone.cinField.text}
                  LoginSuccess:^(NSDictionary *dic) {
                      DLog(@"dic=%@",dic);
                      if([[dic objectForKey:@"code"] isEqualToString:@"200"]){
                          [DBInfo saveToken:[dic objectForKey:@"data"]];
                          [DBInfo saveLoadStatus:1];
                          [DBInfo saveInfo:@{ @"password": self.ldView.password.cinField.text,
                                              @"phone": self.ldView.phone.cinField.text}];
                          [self setPersonInfo];
                          [[AppDelegate sharedAppDelegate] cinViewTabbar];
                      }
                  } failure:^(NSError *error) {
                      
                  }];
    }else{
        [usernameLogin usernameInfo: @{ @"password": self.ldView.password.cinField.text,
                                        @"username": self.ldView.phone.cinField.text}
                       LoginSuccess:^(NSDictionary *dic) {
                            DLog(@"dic=%@",dic);
                           if([[dic objectForKey:@"code"] isEqualToString:@"200"]){
                               [DBInfo saveToken:[dic objectForKey:@"data"]];
                               [DBInfo saveLoadStatus:1];
                               [DBInfo saveInfo:@{ @"password": self.ldView.password.cinField.text,
                                                   @"phone": self.ldView.phone.cinField.text}];
                                 [self setPersonInfo];
                               [[AppDelegate sharedAppDelegate] cinViewTabbar];
                           }else{
                        
                               [self showProgressTitle:[dic objectForKey:@"message"] autoHide:YES];
                               
                           }
                       } failure:^(NSError *error) {
                           
                       }];
    }
   
}
- (void)setPersonInfo{
    [getPersonInfoRequest getPersonInfoSuccess:^(NSDictionary *dic) {
        if([[dic objectForKey:@"code"] isEqualToString:@"200"]){
            [DBInfo saveInfo:[dic objectForKey:@"data"]];
            
            DLog(@"person==%@",[dic objectForKey:@"data"]);
        }else{
      
            
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
