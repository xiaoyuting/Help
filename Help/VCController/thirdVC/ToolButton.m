//
//  ToolButton.m
//  HELPXY
//
//  Created by GM on 2018/6/10.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "ToolButton.h"

@implementation ToolButton
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        self.icon = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width/2.0-16, 6, 32, 32)];
        self.icon.contentMode =UIViewContentModeScaleAspectFit;
        [self addSubview:self.icon];
        self.title = [[UILabel alloc]initWithFrame:CGRectMake(0, self.icon.frame.origin.y+self.icon.frame.size.height+4, frame.size.width, 15)];
        self.title.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
        self.title.textColor = ColorFF(0x333333);
        self.title.textAlignment =NSTextAlignmentCenter;
        [self addSubview:self.title];
        
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
