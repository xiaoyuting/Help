//
//  cinView.m
//  HELPXY
//
//  Created by GM on 2018/5/7.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "cinView.h"
#import "ScanButton.h"

@implementation cinView
- (instancetype) init{
    if(self = [super init]){
        
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame viewType:(cinType)type category:(type)cate{
    if (self =[super initWithFrame:frame ]){
        if       (type==typeLD){
            self.phone = [[cinTextView alloc]initWithFrame:CGRectZero placeHolder:@"请输入手机号"];
            
            self.password = [[cinTextView alloc]initWithFrame:CGRectZero placeHolder:@"请输入密码"];
            self.password.cinField.secureTextEntry=YES;
            
            
            [self sd_addSubviews:@[self.phone,self.password ]];
            self.phone.sd_layout
            .leftEqualToView(self)
            .rightEqualToView(self)
            .topEqualToView(self)
            .heightIs(40);
            self.password.sd_layout
            .topSpaceToView(self.phone, 19)
            .leftEqualToView(self)
            .rightEqualToView(self)
            .heightIs(40);
            

            
        } else if(type==typeFW){
            
            self.phone = [[cinTextView alloc]initWithFrame:CGRectZero placeHolder:@"请输入手机号"];
            
            self.personID = [[cinTextView alloc]initWithFrame:CGRectZero placeHolder:@"身份证号码"];
            ScanButton * btn = [[ScanButton alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
           
            [btn setTag:0];
            [btn addTarget:self action:@selector(checkInfo:) forControlEvents:UIControlEventTouchUpInside];
            self.name  =[[cinTextView alloc]initWithFrame:CGRectZero placeHolder:@"真实姓名"];
            
            self.password = [[cinTextView alloc]initWithFrame:CGRectZero placeHolder:@"新密码"];
            
            [self sd_addSubviews:@[self.phone,self. personID ,btn, self.name,self.password]];
            self.phone.sd_layout
            .leftEqualToView(self)
            .rightEqualToView(self)
            .topEqualToView(self)
            .heightIs(40);
             btn.sd_layout
            .topSpaceToView(self.phone, 19)
            .rightEqualToView(self)
            .widthIs(80)
            .heightIs(40);
            
            self.personID.sd_layout
            .topSpaceToView(self.phone, 19)
            .leftEqualToView(self)
            .rightSpaceToView(btn, 10)
            .heightIs(40);
            
            self.name.sd_layout
            .topSpaceToView(self.personID, 19)
            .leftEqualToView(self)
            .rightEqualToView(self)
            .heightIs(40);
            
            self.password.sd_layout
            .topSpaceToView(self.name, 19)
            .leftEqualToView(self)
            .rightEqualToView(self)
            .heightIs(40);
           
        }else if(type ==typeRG){
            self.phone = [[cinTextView alloc]initWithFrame:CGRectZero placeHolder:@"请输入手机号"];
            
            self.personID = [[cinTextView alloc]initWithFrame:CGRectZero placeHolder:@"身份证号码"];
           
            self.name  =[[cinTextView alloc]initWithFrame:CGRectZero placeHolder:@"真实姓名"];
            
            self.password = [[cinTextView alloc]initWithFrame:CGRectZero placeHolder:@"密码"];
            
            self.inviteID = [[cinTextView alloc]initWithFrame:CGRectZero placeHolder:@"邀请码"];
            self.organID = [[cinTextView alloc]initWithFrame:CGRectZero placeHolder:@"邀请码"];
            if(cate==oldMan){
                ScanButton * btn = [[ScanButton alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
                [btn setTag:1];
                [btn addTarget:self action:@selector(checkInfo:) forControlEvents:UIControlEventTouchUpInside];
                UIButton * regBtn = [[UIButton alloc]init];
                regBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
                //[regBtn setTitleColor:ColorFF(0x666666) forState:UIControlStateNormal];
                [ regBtn setTitle:@"注册" forState:UIControlStateNormal];
                regBtn.layer.cornerRadius = 5;
                regBtn.backgroundColor  = themesColor;
                [ regBtn addTarget:self action:@selector(registM:) forControlEvents:UIControlEventTouchUpInside];
               [self sd_addSubviews:@[self.phone,self.password,self. personID ,btn, self.name,regBtn]];
                self.phone.sd_layout
                .leftEqualToView(self)
                .rightEqualToView(self)
                .topEqualToView(self)
                .heightIs(40);
                
                self.password.sd_layout
                .topSpaceToView(self.phone, 19)
                .leftEqualToView(self)
                .rightEqualToView(self)
                .heightIs(40);
                btn.sd_layout
                .topSpaceToView(self.password, 19)
                .rightEqualToView(self)
                .widthIs(80)
                .heightIs(40);
                
                self.personID.sd_layout
                .topSpaceToView(self.password, 19)
                .leftEqualToView(self)
                .rightSpaceToView(btn, 10)
                .heightIs(40);
                
                self.name.sd_layout
                .topSpaceToView(self.personID, 19)
                .leftEqualToView(self)
                .rightEqualToView(self)
                .heightIs(40);
                
                regBtn.sd_layout
                .topSpaceToView(self.name, 19)
                .leftEqualToView(self)
                .rightEqualToView(self)
                .heightIs(40);
                
            }else if(cate==relatives){
                ScanButton * btn = [[ScanButton alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
                [btn setTag:1];
                [btn addTarget:self action:@selector(checkInfo:) forControlEvents:UIControlEventTouchUpInside];
                UIButton * regBtn = [[UIButton alloc]init];
                regBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
                [ regBtn setTitle:@"注册" forState:UIControlStateNormal];
                regBtn.layer.cornerRadius = 5;
                regBtn.backgroundColor  = themesColor;
                [ regBtn addTarget:self action:@selector(registM:) forControlEvents:UIControlEventTouchUpInside];
                
                ScanButton * btnID =[[ScanButton alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
                [btnID setTag:2];
                [btnID addTarget:self action:@selector(invite:)forControlEvents:UIControlEventTouchUpInside];
                [self sd_addSubviews:@[self.phone,self.password,self. personID ,btn, self.name, self.inviteID,btnID,regBtn]];
                self.phone.sd_layout
                .leftEqualToView(self)
                .rightEqualToView(self)
                .topEqualToView(self)
                .heightIs(40);
                
                self.password.sd_layout
                .topSpaceToView(self.phone, 19)
                .leftEqualToView(self)
                .rightEqualToView(self)
                .heightIs(40);
                btn.sd_layout
                .topSpaceToView(self.password, 19)
                .rightEqualToView(self)
                .widthIs(80)
                .heightIs(40);
                
                self.personID.sd_layout
                .topSpaceToView(self.password, 19)
                .leftEqualToView(self)
                .rightSpaceToView(btn, 10)
                .heightIs(40);
                
                self.name.sd_layout
                .topSpaceToView(self.personID, 19)
                .leftEqualToView(self)
                .rightEqualToView(self)
                .heightIs(40);
                
                btnID.sd_layout
                .topSpaceToView(self.name, 19)
                .rightEqualToView(self)
                .widthIs(80)
                .heightIs(40);
                self.inviteID.sd_layout
                .topSpaceToView(self.name, 19)
                .leftEqualToView(self)
                .rightSpaceToView(btnID, 10)
                .heightIs(40);
                regBtn.sd_layout
                .topSpaceToView(self.inviteID, 19)
                .leftEqualToView(self)
                .rightEqualToView(self)
                .heightIs(40);
                
                
            }else if (cate==server){
                ScanButton * btn = [[ScanButton alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
                [btn setTag:1];
                [btn addTarget:self action:@selector(checkInfo:) forControlEvents:UIControlEventTouchUpInside];
                UIButton * regBtn = [[UIButton alloc]init];
                regBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
                //[regBtn setTitleColor:ColorFF(0x666666) forState:UIControlStateNormal];
                [ regBtn setTitle:@"注册" forState:UIControlStateNormal];
                regBtn.layer.cornerRadius = 5;
                regBtn.backgroundColor  = themesColor;
                [ regBtn addTarget:self action:@selector(registM:) forControlEvents:UIControlEventTouchUpInside];
                [self sd_addSubviews:@[self.phone,self.password,self. personID ,btn, self.name,regBtn]];
                self.phone.sd_layout
                .leftEqualToView(self)
                .rightEqualToView(self)
                .topEqualToView(self)
                .heightIs(40);
                
                self.password.sd_layout
                .topSpaceToView(self.phone, 19)
                .leftEqualToView(self)
                .rightEqualToView(self)
                .heightIs(40);
                btn.sd_layout
                .topSpaceToView(self.password, 19)
                .rightEqualToView(self)
                .widthIs(80)
                .heightIs(40);
                
                self.personID.sd_layout
                .topSpaceToView(self.password, 19)
                .leftEqualToView(self)
                .rightSpaceToView(btn, 10)
                .heightIs(40);
                
                self.name.sd_layout
                .topSpaceToView(self.personID, 19)
                .leftEqualToView(self)
                .rightEqualToView(self)
                .heightIs(40);
                
                regBtn.sd_layout
                .topSpaceToView(self.name, 19)
                .leftEqualToView(self)
                .rightEqualToView(self)
                .heightIs(40);
            }else if (cate==organ){
                ScanButton * btn = [[ScanButton alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
                [btn setTag:1];
                [btn addTarget:self action:@selector(checkInfo:) forControlEvents:UIControlEventTouchUpInside];
                UIButton * regBtn = [[UIButton alloc]init];
                regBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
                //[regBtn setTitleColor:ColorFF(0x666666) forState:UIControlStateNormal];
                [ regBtn setTitle:@"注册" forState:UIControlStateNormal];
                regBtn.layer.cornerRadius = 5;
                regBtn.backgroundColor  = themesColor;
                [ regBtn addTarget:self action:@selector(registM:) forControlEvents:UIControlEventTouchUpInside];
                [self sd_addSubviews:@[self.phone,self.password,self. personID ,btn, self.name,regBtn]];
                self.phone.sd_layout
                .leftEqualToView(self)
                .rightEqualToView(self)
                .topEqualToView(self)
                .heightIs(40);
                
                self.password.sd_layout
                .topSpaceToView(self.phone, 19)
                .leftEqualToView(self)
                .rightEqualToView(self)
                .heightIs(40);
                btn.sd_layout
                .topSpaceToView(self.password, 19)
                .rightEqualToView(self)
                .widthIs(80)
                .heightIs(40);
                
                self.personID.sd_layout
                .topSpaceToView(self.password, 19)
                .leftEqualToView(self)
                .rightSpaceToView(btn, 10)
                .heightIs(40);
                
                self.name.sd_layout
                .topSpaceToView(self.personID, 19)
                .leftEqualToView(self)
                .rightEqualToView(self)
                .heightIs(40);
                
                regBtn.sd_layout
                .topSpaceToView(self.name, 19)
                .leftEqualToView(self)
                .rightEqualToView(self)
                .heightIs(40);
            }
        }
    }
    return self;
}
- (void)checkInfo: (UIButton * )sender{
    if (self.personInfo){
        self.personInfo();
   }
   
}

- (void)invite: (UIButton * )sender{
    if (self.invite){
        self.invite();
    }
}

- (void)registM:(UIButton *)sender{
    if (self.regist){
        self.regist();
    }
}
@end
