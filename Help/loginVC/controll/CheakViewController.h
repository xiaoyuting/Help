//
//  CheakViewController.h
//  BicycleApp
//
//  Created by 雨停 on 2017/5/4.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "RootBaseVC.h"
@protocol scanDelegate <NSObject>
- (void)scanInvateID:(NSString * )str;
@end
@interface CheakViewController : RootBaseVC
//@property   (nonatomic,strong)UIButton *lightButton;
@property (nonatomic,weak)id <scanDelegate>IDdelegate;
@end
