//
//  relativeCollCell.h
//  HELPXY
//
//  Created by GM on 2018/5/31.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface relativeCollCell : UICollectionViewCell
@property (nonatomic,strong) UIImageView  * img;
@property (nonatomic,assign) BOOL         radio;
@property (nonatomic,copy)   NSString     * imgUrl;
@property (nonatomic,strong) UILabel      * name;
@end
