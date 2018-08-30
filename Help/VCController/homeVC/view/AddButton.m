//
//  AddButton.m
//  HELPXY
//
//  Created by GM on 2018/8/28.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "AddButton.h"

@implementation AddButton
- (instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]){
        //CGFloat h = frame.size.height;
        CGFloat w = frame.size.width;
        self.img = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 50, 50)];
        self.img . image = [UIImage imageNamed:@"add"];
        self.img.layer.cornerRadius =25;
        self.img.layer.borderColor = ColorFF(0xd4d4d4).CGColor;
        self.img.layer.borderWidth = 1;
        self.name = [[UILabel alloc]initWithFrame:CGRectMake( 0, 50 , w , 20)];
        self.name.textColor = ColorFF(0xd4d4d4);
        self.name.textAlignment = NSTextAlignmentCenter;
        self.name.font = SYSTEMFONT(14);
        self.name.text = @"更多";
        [self addSubview:self.name];
        [self addSubview:self.img];
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
