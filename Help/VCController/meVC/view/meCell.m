//
//  meCell.m
//  HELPXY
//
//  Created by GM on 2018/6/10.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "meCell.h"

@implementation meCell
{
    UIImageView * icon;
    UILabel     * lab;
    UIImageView * arrows;
    UIImageView * line;
    
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        icon = [[UIImageView alloc]initWithFrame:CGRectMake(14, 14, 16, 16)];
        [self addSubview:icon];
        lab = [[UILabel alloc]initWithFrame:CGRectMake(44, 14, 200, 16)];
        lab.font = [UIFont fontWithName:@"PingFangSC-Light" size:12];
        lab.textColor =ColorFF(0x333333);
        [self addSubview:lab];
        arrows = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth-40, 12, 20, 20)];
        arrows.image = [UIImage imageNamed:@"img"];
        [self addSubview:arrows];
        line = [[UIImageView alloc]initWithFrame:CGRectMake(0, 43, KScreenWidth, 1)];
        line.backgroundColor = ColorFF(0xEAEAEA);
        [self addSubview:line];
    }
    return self;
}

- (void)setInfoDic:(NSDictionary *)infoDic{
    _infoDic = infoDic;
    lab.text = [infoDic objectForKey:@"title"];
    icon.image =[UIImage imageNamed:[infoDic objectForKey:@"img"]];
    
}

- (void)setArrowsStatus:(BOOL)arrowsStatus{
    _arrowsStatus = arrowsStatus;
    if (arrowsStatus){
        arrows.hidden =YES;
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
