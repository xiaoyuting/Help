//
//  ToolCell.m
//  HELPXY
//
//  Created by GM on 2018/5/30.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "ToolCell.h"
#import "SDAutoLayout.h"
@implementation ToolCell{
    UILabel * _titleLab;
    UIImageView * _bottomImg;
    UIImageView * _arrows;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setSubview];
    }
    
    return self;
}
- (void)setSubview{
    UILabel  * titleLab = [[UILabel alloc]init];
    titleLab.font = [UIFont fontWithName:@"PingFangSC-Light" size:12];
    titleLab.textColor = ColorFF(0x333333);
    _titleLab = titleLab;
    UIImageView  * bottomImg =[[UIImageView alloc]init];
    bottomImg.backgroundColor = ColorFF(0xEAEAEA);
    _bottomImg = bottomImg;
    UIImageView  * arrows =[[UIImageView alloc]init];
    arrows.image = [UIImage imageNamed:@"img"];
    _arrows = arrows;
    
    [self.contentView sd_addSubviews:@[_titleLab,_bottomImg,_arrows]];
    _titleLab.sd_layout
    .topSpaceToView(self.contentView, 8)
    .leftSpaceToView(self.contentView, 20)
    .heightIs(30)
    .widthIs(220);
    
   
    _arrows.sd_layout
    .centerYEqualToView(_titleLab)
    .widthIs(20)
    .heightIs(20)
    .rightSpaceToView(self.contentView, 20);
    _bottomImg.sd_layout
    .topSpaceToView(_titleLab, 9)
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .heightIs(1);
    
    [self setupAutoHeightWithBottomView:_bottomImg bottomMargin:1];
}

- (void)setContent:(NSString *)content{
    _content = content;
    _titleLab.text = content;
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
