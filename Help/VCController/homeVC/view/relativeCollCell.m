//
//  relativeCollCell.m
//  HELPXY
//
//  Created by GM on 2018/5/31.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "relativeCollCell.h"

@implementation relativeCollCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]){
        //CGFloat h = self.frame.size.height;
        CGFloat w = self.frame.size.width ;
        self.img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, w, w)];
        self.img .userInteractionEnabled =YES;
        self.img.clipsToBounds  = YES;
        self.img.contentMode = UIViewContentModeScaleAspectFill;
        [self.img sd_setImageWithURL:[NSURL URLWithString:@"http://img.wdjimg.com/image/video/d536b9c09b2681630afcc92222599f0e_0_0.jpeg"]];
        self.name = [[UILabel alloc]initWithFrame:CGRectMake(0, w, w, 20)];
        self.name.textAlignment  = NSTextAlignmentCenter ;
        self.name.textColor = ColorFF(0xd4d4d4);
        self.name.font = SYSTEMFONT(14);
        self.name.text  =@"名字";
        [self  addSubview:self.img];
        [self addSubview:self.name];
    }
    return self;
}
- (void)setRadio:(BOOL)radio{
    _radio =radio;
    if (self.radio){
        
        self.img.layer.cornerRadius = self.img.frame.size.width/2.0;
    }
}
- (void)setImgUrl:(NSString *)imgUrl{
    _imgUrl = imgUrl;
    self.name.text  =@"名字";
    [self.img sd_setImageWithURL:[NSURL URLWithString: imgUrl]];
}

@end
