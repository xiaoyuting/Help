//
//  cinView.h
//  HELPXY
//
//  Created by GM on 2018/5/7.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cinTextView.h"
typedef void(^personInfo)();
typedef void(^invite)();
typedef void(^regist)();
typedef NS_ENUM(NSInteger, cinType)
{
    typeLD  = 0,
    typeRG,
    typeFW
};

typedef NS_ENUM(NSInteger,type) {
    oldMan  = 0,//160
    relatives,  //220
    server,      //160
    organ
};
@interface cinView : UIView
@property (nonatomic,strong) cinTextView     * phone;
@property (nonatomic,strong) cinTextView     * name;
@property (nonatomic,strong) cinTextView     * password;
@property (nonatomic,strong) cinTextView     * personID;
@property (nonatomic,strong) cinTextView     * inviteID;
@property (nonatomic,strong) cinTextView     * organID;
@property (nonatomic,copy)   personInfo       personInfo;
@property (nonatomic,copy)   invite           invite;
@property (nonatomic,copy)   regist           regist;
- (instancetype)initWithFrame:(CGRect)frame viewType:(cinType)type category:(type)cate; 
@end
