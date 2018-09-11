//
//  usermedModel.h
//  Help
//
//  Created by GM on 2018/8/30.
//  Copyright © 2018年 Ugliest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "userModel.h"
@interface usermedModel : NSObject
@property (nonatomic,copy)   NSString  *collected   ;
@property (nonatomic,copy)   NSString  *content  ;
@property (nonatomic,copy)   NSString  *createdAt ;
@property (nonatomic,copy)   NSString  * mediaid ;
@property (nonatomic,copy)   NSString  *latitude  ;
@property (nonatomic,copy)   NSString  *liked  ;
@property (nonatomic,copy)   NSString  *likesCount  ;
@property (nonatomic,copy)   NSString  *location    ;
@property (nonatomic,copy)   NSString  *longitude  ;
@property (nonatomic,strong) NSArray   * media  ;
@property (nonatomic,copy)   NSString  *type  ;
@property (nonatomic,copy)   NSString  *userId ;
@property (nonatomic,strong) userModel *  user ;

@end
