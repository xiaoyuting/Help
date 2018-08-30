//
//  photoCell.h
//  HELPXY
//
//  Created by GM on 2018/5/8.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface photoCell : UITableViewCell
- (void)setContentView:(NSArray *)dataArray;
+ (CGFloat)HeightWithZanArray:(NSArray *)array;
-(void)setContentRelativeView:(NSArray *)dataArray;
+ (CGFloat)HeightWithArray:(NSArray *)array;
@property  (nonatomic, strong) NSArray *picArray;
@end
