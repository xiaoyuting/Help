//
//  game2048VC.h
//  HELPXY
//
//  Created by GM on 2018/5/22.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "RootBaseVC.h"
#define kOneLabelwidth 67.5
#define kOneLabelHeight 65
#define kPlaceX @"X"
#define kPlaceY @"Y"
#define kHaveSameNumberLabel 10
#define kHaveNoLabel 20
#define kHaveDifferentLabel 30

#define kRight 1
#define kLeft 2
#define kUp 3
#define kDown 4
@interface game2048VC : RootBaseVC
@property (nonatomic,strong) NSMutableArray *currentExistArray;
@property (nonatomic,strong) NSMutableArray *emptyPlaceArray;
@property (nonatomic,strong) NSArray *labelArray;
@property (nonatomic,strong) NSArray *testArray;

@property(nonatomic)BOOL  R_1;
@property(nonatomic)BOOL  R_2;
@property(nonatomic)BOOL  R_3;
@property(nonatomic)BOOL  R_4;

@property(nonatomic)BOOL  C_1;
@property(nonatomic)BOOL  C_2;
@property(nonatomic)BOOL  C_3;
@property(nonatomic)BOOL  C_4;

@property(nonatomic)BOOL canBornNewLabel;
@property(nonatomic)BOOL isOver;
@end
