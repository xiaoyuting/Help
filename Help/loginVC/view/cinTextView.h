//
//  cinTextView.h
//  HELPXY
//
//  Created by GM on 2018/5/7.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cinTextView : UIView
- (instancetype)initWithFrame:(CGRect)frame placeHolder:(NSString * )holder;
@property (nonatomic,strong)UITextField * cinField;

@end
