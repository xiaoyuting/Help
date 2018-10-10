//
//  mediaCollcell.h
//  Help
//
//  Created by GM on 2018/10/8.
//  Copyright © 2018年 Ugliest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mediaCollcell : UICollectionViewCell
@property  (nonatomic,strong)UIImageView  * pic;
@property  (nonatomic,strong)UIImageView  * playerimg;
@property  (nonatomic,assign)bool   showPlay;
@property  (nonatomic,strong)NSDictionary * picDic;
@property  (nonatomic,strong)NSDictionary * videoDic;
@end
