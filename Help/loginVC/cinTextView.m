//
//  cinTextView.m
//  HELPXY
//
//  Created by GM on 2018/5/7.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "cinTextView.h"
#import "SDAutoLayout.h"
@implementation cinTextView

- (instancetype)initWithFrame:(CGRect)frame placeHolder:(NSString * )holder{
    if (self = [super initWithFrame:frame]){
       
        self.cinField     = [[UITextField alloc]init];
        self.cinField.font =SYSTEMFONT(11);
        NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holder];
        [placeholder addAttribute:NSForegroundColorAttributeName
                            value:ColorFF(0x999999)
                            range:NSMakeRange(0, holder.length)];
        [placeholder addAttribute:NSFontAttributeName
                            value:[UIFont fontWithName:@"PingFangSC-Light" size:11]
                            range:NSMakeRange(0, holder.length)];
        self.cinField .attributedPlaceholder = placeholder;
        self.layer.borderWidth =1;
        self.layer.borderColor = ColorFF(0x999999).CGColor;
        self.layer.cornerRadius =5;
        [self sd_addSubviews:@[ self.cinField] ];
        
 
        self.cinField.sd_layout
        .leftSpaceToView(self, 10)
        .topEqualToView(self)
        .bottomSpaceToView(self, 0)
        .rightSpaceToView(self, 10);
        
       
        
    }
    return self;
}

@end
