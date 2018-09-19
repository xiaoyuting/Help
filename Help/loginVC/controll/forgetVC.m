//
//  forgetVC.m
//  HELPXY
//
//  Created by GM on 2018/5/7.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "forgetVC.h"
#import "cinView.h"
 

#import "AVCaptureViewController.h"
@interface forgetVC ()
@property  (nonatomic,strong)UIButton   *resetPass;
@property  (nonatomic,strong)cinView    * forget;
@end

@implementation forgetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubviews];
}
- (void)setSubviews{
    self.title = @"重制密码";
    __weak typeof(self) weakSelf =self;
    self.forget = [[cinView alloc]initWithFrame:CGRectZero viewType:typeFW category:0];
    self.resetPass = [[UIButton alloc]init];
    self.resetPass.layer.cornerRadius = 5;
    self.resetPass.backgroundColor  = ColorFF(0x78C34E);
    [self.resetPass setTitle:@"重置密码" forState:UIControlStateNormal];
    [self.resetPass addTarget:self action:@selector(selectModules:) forControlEvents:UIControlEventTouchUpInside];
    self.forget.personInfo = ^{
        AVCaptureViewController *AVCaptureVC = [[AVCaptureViewController alloc] init];
        AVCaptureVC.info = ^(NSDictionary *dic) {
            weakSelf.forget.name.cinField.text =[dic objectForKey:@"name"];
            weakSelf.forget.personID.cinField.text =[dic objectForKey:@"phone"];
        };
        [weakSelf pushViewController:AVCaptureVC animated:YES];
    };
    [self.view sd_addSubviews:@[self.forget,self.resetPass]];
    self.forget.sd_layout
    .topSpaceToView(self.view, [self naviGationH]+35)
    .leftSpaceToView(self.view, 30)
    .rightSpaceToView(self.view, 30)
    .heightIs(220);
    self.resetPass.sd_layout
    .topSpaceToView(self.forget, 20)
    .leftSpaceToView(self.view, 30)
    .rightSpaceToView(self.view, 30)
    .heightIs(40);
    
    
}
- (void)selectModules: (UIButton * )sender{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
