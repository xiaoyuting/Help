//
//  relativeCell.m
//  HELPXY
//
//  Created by GM on 2018/5/7.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "relativeCell.h"

@interface relativeCell ()
{
    UIImageView * _icon;
    UIImageView * _arrows;
    UILabel     * _name;
    UILabel     * _distance;
    UIImageView * _line;
}
@end

@implementation relativeCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier ]){
        [self setSubviews];
    }
    return self;
}

- (void)setSubviews{
    UIImageView  * icon = [[UIImageView alloc]init];
    icon.layer.cornerRadius =25;
    icon.clipsToBounds =YES;
    icon.contentMode = UIViewContentModeScaleAspectFill;
    _icon  = icon;
    UIImageView * arrows = [[UIImageView alloc]init];
    _arrows = arrows;
    UILabel * name = [[UILabel alloc]init];
    _name = name;
    UILabel * distance = [[UILabel alloc]init];
    _distance   = distance;
    UIImageView * line = [[UIImageView alloc]init];
    line.backgroundColor = [UIColor lightGrayColor];
    _line = line;
    [self.contentView sd_addSubviews:@[icon , arrows  , name , distance,line]];
    
    _icon.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView, 10)
    .widthIs(50)
    .heightIs(50);
   
    _name.sd_layout
    .leftSpaceToView(_icon, 10)
    .topEqualToView(_name)
    .heightIs(30)
    .widthIs(120);
    
    _distance.sd_layout
    .bottomEqualToView(_icon)
    .leftSpaceToView(_icon, 10)
    .heightIs(30)
    .widthIs(220);
    
    _arrows.sd_layout
    .widthIs(7)
    .heightIs(13)
    .leftSpaceToView(self.contentView, 15)
    .centerYEqualToView(_icon);
    
    _line.sd_layout
    .leftSpaceToView(self.contentView, 10)
    .rightSpaceToView(self.contentView, 10)
    .topSpaceToView(_icon,8)
    .heightIs(1);
    
    [self setupAutoHeightWithBottomView:_line bottomMargin:1];
    
    
}
-(void)setDicInfoRelative:(NSDictionary *)dicInfoRelative{
    _dicInfoRelative = dicInfoRelative;
    _name.text =@"name";
    //[_icon   sd_setImageWithURL:[NSURL URLWithString:@"http://img.wdjimg.com/image/video/d536b9c09b2681630afcc92222599f0e_0_0.jpeg"]]; 
    _distance.text = @"distance";
}
-(void)setDicInfoThird:(NSDictionary *)dicInfoThird{
    _dicInfoThird = dicInfoThird;
    _name.text =@"fuwu";
    _distance.text = @"jieshao";
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
