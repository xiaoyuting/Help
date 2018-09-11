//
//  ThirdCell.m
//  Help
//
//  Created by GM on 2018/9/10.
//  Copyright © 2018年 Ugliest. All rights reserved.
//

#import "ThirdCell.h"
#import "companymodel.h"
@interface  ThirdCell()
@property    (nonatomic,strong)UIImageView * icon ;
@property    (nonatomic,strong)UILabel     * companynam;
@property    (nonatomic,strong)UILabel     * intro;
@property    (nonatomic,strong)UIImageView * line;
@end
@implementation ThirdCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier   {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setSubView];
    }
    return self;
}

- (void)setSubView{
    self.icon = [UIImageView  new];
    self.companynam = [UILabel new];
    self.companynam.font = SYSTEMFONT(20);
    self.intro = [UILabel new];
    self.intro.font =SYSTEMFONT(13);
    self.intro.textColor =CFontColor2;
    self.line = [UIImageView new];
    self.line.backgroundColor = CLineColor;
    [self.contentView sd_addSubviews:@[self.icon,self.companynam,self.intro,self.line]];
    self.icon.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView, 10)
    .widthIs(KScreenWidth/3.0)
    .heightIs(KScreenWidth/3.0);
    
    self.companynam.sd_layout
    .leftSpaceToView(self.icon, 10)
    .topEqualToView(self.icon)
    .rightSpaceToView(self.contentView, 10)
    .autoHeightRatio(0);
    
    self.intro.sd_layout
    .topSpaceToView(self.companynam, 10)
    .leftSpaceToView(self.icon, 10)
    .rightSpaceToView(self.contentView, 10)
    .autoHeightRatio(0);
    
    self.line.sd_layout
    .topSpaceToView(self.icon, 10)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(1);
    
    [self setupAutoHeightWithBottomViewsArray:@[self.icon,self.companynam,self.intro,self.line] bottomMargin:10];
    
    
}

- (void)setCommodel:(companymodel *)commodel{
    _commodel = commodel;
    DLog(@"commodel==%@",commodel );
    [self.icon sd_setImageWithURL:imgUrl(commodel.logoUrl) placeholderImage:placeholdImg];
    self.companynam.text = commodel.organizationName;
    self.intro.text = commodel.introduction;
}
- (void)setDetailemodel:(companymodel *)detailemodel{
    _detailemodel  = detailemodel ;
     [self.icon sd_setImageWithURL:imgUrl(detailemodel.url) placeholderImage:placeholdImg];
    self.companynam.text =detailemodel.fileName;
    self.intro.text  =detailemodel.descrip ;
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
