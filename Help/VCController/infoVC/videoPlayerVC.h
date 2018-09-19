//
//  videoPlayerVC.h
//  Help
//
//  Created by GM on 2018/9/13.
//  Copyright © 2018年 Ugliest. All rights reserved.
//

#import "RootBaseVC.h"

@interface videoPlayerVC : RootBaseVC
- (instancetype)initwithVideoArr:(NSArray *)arr select:(NSInteger)selcet;
@property (nonatomic,strong)NSArray  * urlArr ;
@property (nonatomic,assign)NSInteger  countIndex;
@end
