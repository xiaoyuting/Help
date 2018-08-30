//
//  ScanButton.m
//  HELPXY
//
//  Created by GM on 2018/6/9.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "ScanButton.h"

@implementation ScanButton
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
       
        self.icon   = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width/2.0-13-5, (frame.size.height-14)/2.0, 14, 13)];
        [self addSubview:self.icon];
        self.title  = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width/2.0+5, 0, frame.size.width/2.0-5, frame.size.height)];
        [self addSubview:self.title];
        self.layer.borderColor  = [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth  = 2;
        self.layer.borderColor  = ColorFF(0x999999).CGColor;
        self.layer.borderWidth  = 1;
        self.layer.cornerRadius = 5;
        self.title.text  = @"扫描";
        self.title.font  = [UIFont fontWithName:@"PingFangSC-Light" size:11];
        self.title.textColor = ColorFF(0x999999);
        self.icon.image  = [UIImage imageNamed:@"scan"];
      
    }
    return  self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
