//
//  photoCell.h
//  HELPXY
//
//  Created by GM on 2018/5/8.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class   usermedModel;
@interface photoCell : UITableViewCell
- (void)setTuijianContentView:( usermedModel *)model;
+ (CGFloat)setTuijianHeight:( usermedModel *)model;
-(void)setContentRelativeView:(NSArray *)dataArray;
+ (CGFloat)HeightWithArray:(NSArray *)array;
@property  (nonatomic, strong) NSMutableArray *picArray;
@end
