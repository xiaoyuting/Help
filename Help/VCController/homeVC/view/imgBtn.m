//
//  imgBtn.m
//  HELPXY
//
//  Created by GM on 2018/5/31.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "imgBtn.h"

@implementation imgBtn
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        self.img = [[UIImageView alloc]initWithFrame:frame];
        self.img.contentMode = UIViewContentModeScaleAspectFill;
        self.img.clipsToBounds =YES;
        [self addSubview:self.img];
        self.icon = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width/2.0-16, 60, 32, 32)];
        self.icon.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.icon];
        self.name = [[UILabel alloc]initWithFrame:CGRectMake(0, self.icon.frame.size.height+self.icon.frame.origin.y+10, frame.size.width, 30)];
        self.name.textColor = ColorFF(0x333333);
        self.name.font = [UIFont fontWithName:@"PingFangSC-Light" size:12];
        self.name.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.name];
        self.layer.borderWidth =0.5;
        self.layer.borderColor = ColorFF(0xEAEAEA).CGColor;
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
