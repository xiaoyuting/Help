//
//  bottomView.m
//  HELPXY
//
//  Created by GM on 2018/6/1.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "bottomView.h"

@implementation bottomView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.Zan = [[UIButton alloc]init];
        [_Zan setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
        _Zan.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        
        self.Clo = [[UIButton  alloc]init];
         [_Clo setImage:[UIImage imageNamed:@"clo"] forState:UIControlStateNormal];
 
        self.Shear = [[UIButton alloc]init];
       //[_Shear setBackgroundImage:[UIImage imageNamed:@"she"] forState:UIControlStateNormal];
       [_Shear setImage:[UIImage imageNamed:@"she"] forState:UIControlStateNormal];
        self.distance = [[UILabel alloc]init];
        self.distance.text =@"距离";
        [self sd_addSubviews:@[self.distance,self.Clo,self.Shear,self.Zan]];
        self.distance.sd_layout
        .centerYEqualToView(self)
        .leftSpaceToView(self, 50)
        .heightIs(20)
        .widthIs(120);
        self.Shear.sd_layout
        .centerYEqualToView(self)
        .rightSpaceToView(self, 20)
        .heightIs(30)
        .widthIs(30);
        self.Clo.sd_layout
        .centerYEqualToView(self)
        .rightSpaceToView(self.Shear, 20)
        .heightIs(30)
        .widthIs(30);
        
        self.Zan.sd_layout
        .centerYEqualToView(self)
        .rightSpaceToView(self.Clo, 20)
        .heightIs(30)
        .widthIs(30);
        
        
        }
    
    return  self;
}

@end
