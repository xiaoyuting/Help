//
//  game2048VC.m
//  HELPXY
//
//  Created by GM on 2018/5/22.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "game2048VC.h"
#import "CLLuckyLabel.h"
static int totalScore;
@interface game2048VC ()
{
    UIButton *_scoreButton;
    UIButton *_restartButton;
    UILabel *_scoreLabel;
    
}
@end

@implementation game2048VC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createButtons];
    [self addGesture];
    [self addBackGround];
    
    [self initData];
    [self firstBornLabel];
    // Do any additional setup after loading the view.
}
-(void)createButtons
{
    _scoreButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _scoreButton.frame=CGRectMake(20, [UIScreen mainScreen].bounds.size.height-80, 120, 60);
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.text=@"分数";
    [_scoreButton addSubview:titleLabel];
    
    _scoreLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 30, 120, 30)];
    _scoreLabel.textAlignment=NSTextAlignmentCenter;
    _scoreLabel.text=@"0";
    _scoreButton.layer.cornerRadius=10.0;
    _scoreButton.backgroundColor=[UIColor colorWithRed:237/255.0 green:207/255.0 blue:114/255.0 alpha:1.0];
    [_scoreButton addSubview:_scoreLabel];
    
    [self.view addSubview:_scoreButton];
    
    _restartButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _restartButton.layer.cornerRadius=10;
    _restartButton.frame=CGRectMake(180, [UIScreen mainScreen].bounds.size.height-80, 120, 60);
    [_restartButton setTitle:@"重新开始" forState:UIControlStateNormal];
    [_restartButton addTarget:self action:@selector(restartTheGame) forControlEvents:UIControlEventTouchUpInside];
    _restartButton.userInteractionEnabled=YES;
    _restartButton.backgroundColor=[UIColor colorWithRed:237/255.0 green:207/255.0 blue:114/255.0 alpha:1.0];
    [self.view addSubview:_restartButton];
}
-(void)restartTheGame
{
    NSLog(@"重新开始游戏");
    for (CLLuckyLabel *label in self.currentExistArray) {
        [label removeFromSuperview];
    }
    [self.currentExistArray removeAllObjects];
    [self.emptyPlaceArray removeAllObjects];
    self.isOver=NO;
    totalScore=0;
    [self initData];
    [self firstBornLabel];
}
-(void)updateGameScore:(int)score
{
    _scoreLabel.text=[NSString stringWithFormat:@"%d",score];
}
-(void)addBackGround
{
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 370)];
    imageView.userInteractionEnabled=YES;
    [self.view addSubview:imageView];
    
    self.view.backgroundColor=[UIColor lightGrayColor];
    
    UIGraphicsBeginImageContext(imageView.frame.size);
    [imageView.image drawInRect:CGRectMake(5, 0, imageView.frame.size.width-10, 310)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapButt);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 10.0);
    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 238/255.0, 228/255.0, 218/255.0, 1.0);
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    
    // 边框
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 0, 60);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), 315, 60);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), 315, 360);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), 5, 360);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), 5, 60);
    
    // 竖线
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 82.5, 60);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), 82.5, 360);
    
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 160, 60);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), 160, 360);
    
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 237.5, 60);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), 237.5, 360);
    
    // 横线
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 5, 135);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), 315, 135);
    
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 5, 210);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), 315, 210);
    
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 5, 285);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), 315, 285);
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    imageView.image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
}
-(void)initData
{
    self.emptyPlaceArray =  [NSMutableArray arrayWithObjects:
                             [NSNumber numberWithInt:11],
                             [NSNumber numberWithInt:21],
                             [NSNumber numberWithInt:31],
                             [NSNumber numberWithInt:41],
                             [NSNumber numberWithInt:12],
                             [NSNumber numberWithInt:22],
                             [NSNumber numberWithInt:32],
                             [NSNumber numberWithInt:42],
                             [NSNumber numberWithInt:13],
                             [NSNumber numberWithInt:23],
                             [NSNumber numberWithInt:33],
                             [NSNumber numberWithInt:43],
                             [NSNumber numberWithInt:14],
                             [NSNumber numberWithInt:24],
                             [NSNumber numberWithInt:34],
                             [NSNumber numberWithInt:44],
                             
                             nil];
    
    self.currentExistArray = [NSMutableArray arrayWithCapacity:16];
    self.labelArray = [NSArray arrayWithObjects:
                       [NSNumber numberWithInt:2],
                       [NSNumber numberWithInt:4],
                       nil];
    
    [self resetGameState];
    
}
-(void)firstBornLabel
{
    int random;
    for (int i=0; i<2; i++) {
        random = arc4random()%(self.emptyPlaceArray.count-1);
        
        NSNumber *place = [self.emptyPlaceArray objectAtIndex:random];
        [self.emptyPlaceArray removeObject:place];
        CLLuckyLabel *label = [[CLLuckyLabel alloc]init];
        label.placeTag = [place intValue];
        
        NSDictionary *dic =  [self caculatePosition:place];
        
        int random2 = arc4random()%2;
        NSNumber *textNumber = [self.labelArray objectAtIndex:random2];
        label.numberTag = textNumber.intValue;
        label.text =[NSString stringWithFormat:@"%@",textNumber];
        
        CGRect frame =  CGRectMake([[dic objectForKey:kPlaceX] intValue], [[dic objectForKey:kPlaceY] intValue], kOneLabelwidth, kOneLabelHeight);
        
        label.frame = frame;
        [self.currentExistArray addObject:label];
        [self.view addSubview:label];
    }
    
}
-(void)addGesture
{
    UISwipeGestureRecognizer *swip;
    
    swip=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipFrom:)];
    swip.direction=UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swip];
    
    swip=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipFrom:)];
    swip.direction=UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swip];
    
    swip=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipFrom:)];
    swip.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swip];
    
    swip=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipFrom:)];
    swip.direction=UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swip];
}
-(void)swipFrom:(UISwipeGestureRecognizer *)sender
{
    [self resetGameState];
    self.view.userInteractionEnabled=YES;
    switch (sender.direction) {
        case UISwipeGestureRecognizerDirectionDown:
            NSLog(@"下滑");
            [self moveLabel:4];
            break;
            
        case UISwipeGestureRecognizerDirectionUp:
            NSLog(@"上滑");
            [self moveLabel:3];
            break;
            
        case UISwipeGestureRecognizerDirectionLeft:
            NSLog(@"左滑");
            [self moveLabel:2];
            break;
            
        case UISwipeGestureRecognizerDirectionRight:
            NSLog(@"右滑");
            [self moveLabel:1];
            break;
            
        default:
            break;
    }
    if (self.currentExistArray.count<16&&self.canBornNewLabel) {
        [self bornNewLabel];
    }else if (self.currentExistArray.count>=16)
    {
        [self isGameOver];
    }
    [self performSelector:@selector(setUserInteractionEnabled:) withObject:[NSNumber numberWithInt:1] afterDelay:0.5f];
    
    //update game score
    int sum=0;
    for (CLLuckyLabel *label in self.currentExistArray) {
        sum+=label.numberTag;
    }
    totalScore+=sum;
    [self updateGameScore:totalScore];
}
-(void)setUserInteractionEnabled:(int)number
{
    
}
-(void)resetGameState
{
    self.canBornNewLabel = NO;
    self.isOver = NO;
    self.R_1 = YES;
    self.R_2 = YES;
    self.R_3 = YES;
    self.R_4 = YES;
    self.C_1 = YES;
    self.C_2 = YES;
    self.C_3 = YES;
    self.C_4 = YES;
}
-(int)checkFrontLabel:(CLLuckyLabel *)label andDirection:(int) direction
{
    switch (direction) {
        case 1:
            for (CLLuckyLabel *childLabel in self.currentExistArray) {
                if ((label.placeTag+10==childLabel.placeTag)&&(label.numberTag==childLabel.numberTag)) {
                    CGRect frame2=label.frame;
                    frame2.origin.x+=kOneLabelwidth+10;
                    label.placeTag+=10;
                    label.frame=frame2;
                    label.numberTag=2*label.numberTag;
                    label.text=[NSString stringWithFormat:@"%d",label.numberTag];
                    [self setStateFlagDirection:1 andPlace:label.placeTag%10];
                    [self.currentExistArray removeObject:childLabel];
                    [childLabel removeFromSuperview];
                    
                    self.canBornNewLabel=YES;
                    self.isOver=NO;
                    return kHaveSameNumberLabel;
                }
                else if ((label.placeTag + 10 == childLabel.placeTag) && (label.numberTag!=childLabel.numberTag))
                {
                    return kHaveDifferentLabel;
                }
            }
            
            if ((label.placeTag + 10)/10 == 4) {
                label.placeTag += 10;
                CGRect frame2 = label.frame;
                frame2.origin.x += kOneLabelwidth+10;
                
                label.frame = frame2;
                self.canBornNewLabel =YES;
                return kHaveNoLabel;
            }
            else
            {
                label.placeTag += 10;
                CGRect frame2 = label.frame;
                frame2.origin.x += kOneLabelwidth+10;
                label.frame = frame2;
                self.canBornNewLabel = YES;
                if ([self selfStateIsValid:label andDirection:2] || [self  isFrontLabelEmpty:label andDirection:1]) {
                    [self checkFrontLabel:label andDirection:1];
                }
            }
            break;
        case 2: // left
            for (CLLuckyLabel *childLabel in self.currentExistArray) {
                if ((label.placeTag - 10 == childLabel.placeTag) && (label.numberTag == childLabel.numberTag)) {
                    
                    CGRect frame2 = label.frame;
                    frame2.origin.x -= kOneLabelwidth+10;
                    label.placeTag -= 10;
                    label.frame = frame2;
                    label.numberTag = label.numberTag*2;
                    label.text = [NSString stringWithFormat:@"%d",label.numberTag];
                    [self setStateFlagDirection:2 andPlace:label.placeTag%10];
                    [self.currentExistArray removeObject:childLabel];
                    [childLabel removeFromSuperview];
                    self.canBornNewLabel = YES;
                    self.isOver = NO;
                    return kHaveSameNumberLabel;
                }else if ((label.placeTag - 10 == childLabel.placeTag) && (label.numberTag!=childLabel.numberTag))
                {
                    
                    return kHaveDifferentLabel;
                }
            }
            //            label.placeTag += 10;
            if ((label.placeTag - 10)/10 == 1) {
                label.placeTag -= 10;
                CGRect frame2 = label.frame;
                frame2.origin.x -= kOneLabelwidth+10;
                
                label.frame = frame2;
                self.canBornNewLabel = YES;
                return kHaveNoLabel;
            }else
            {
                label.placeTag -= 10;
                CGRect frame2 = label.frame;
                frame2.origin.x -= kOneLabelwidth+10;
                label.frame = frame2;
                self.canBornNewLabel = YES;
                if ([self selfStateIsValid:label andDirection:2]) {
                    [self checkFrontLabel:label andDirection:2];
                }
                
            }
            break;
        case 3: // up
            for (CLLuckyLabel *childLabel in self.currentExistArray) {
                if ((label.placeTag - 1 == childLabel.placeTag) && (label.numberTag == childLabel.numberTag)) {
                    
                    CGRect frame3 = label.frame;
                    frame3.origin.y -= kOneLabelHeight+10;
                    label.placeTag -= 1;
                    label.frame = frame3;
                    label.numberTag = label.numberTag*2;
                    label.text = [NSString stringWithFormat:@"%d",label.numberTag];
                    [self setStateFlagDirection:3  andPlace:label.placeTag/10];
                    [self.currentExistArray removeObject:childLabel];
                    [childLabel removeFromSuperview];
                    self.canBornNewLabel = YES;
                    self.isOver = NO;
                    return kHaveSameNumberLabel;
                    
                }else if ((label.placeTag - 1 == childLabel.placeTag) && (label.numberTag!=childLabel.numberTag))
                {
                    return kHaveDifferentLabel;
                }
            }
            if ((label.placeTag - 1)%10 == 1) {
                label.placeTag -= 1;
                CGRect frame3 = label.frame;
                frame3.origin.y -= kOneLabelHeight+10;
                
                label.frame = frame3;
                self.canBornNewLabel = YES;
                return kHaveNoLabel;
            }else
            {
                label.placeTag -= 1;
                CGRect frame3 = label.frame;
                frame3.origin.y -= kOneLabelHeight+10;
                label.frame = frame3;
                self.canBornNewLabel = YES;
                if ([self selfStateIsValid:label andDirection:3]) {
                    [self checkFrontLabel:label andDirection:3];
                }
                
            }
            
            
            break;
        case 4: // down
            for (CLLuckyLabel *childLabel in self.currentExistArray) {
                if ((label.placeTag + 1 == childLabel.placeTag) && (label.numberTag == childLabel.numberTag)) {
                    
                    CGRect frame4 = label.frame;
                    frame4.origin.y += kOneLabelHeight+10;
                    label.placeTag += 1;
                    label.frame = frame4;
                    label.numberTag = label.numberTag*2;
                    label.text = [NSString stringWithFormat:@"%d",label.numberTag];
                    [self setStateFlagDirection:3  andPlace:label.placeTag/10];
                    [self.currentExistArray removeObject:childLabel];
                    [childLabel removeFromSuperview];
                    self.canBornNewLabel = YES;
                    self.isOver = NO;
                    return kHaveSameNumberLabel;
                    
                }else if ((label.placeTag +1 == childLabel.placeTag) && (label.numberTag!=childLabel.numberTag))
                {
                    return kHaveDifferentLabel;
                }
            }
            if ((label.placeTag + 1)%10 == 4) {
                label.placeTag += 1;
                CGRect frame4 = label.frame;
                frame4.origin.y += kOneLabelHeight+10;
                
                label.frame = frame4;
                self.canBornNewLabel = YES;
                return kHaveNoLabel;
            }else
            {
                label.placeTag += 1;
                CGRect frame4 = label.frame;
                frame4.origin.y += kOneLabelHeight+10;
                label.frame = frame4;
                self.canBornNewLabel = YES;
                if ([self selfStateIsValid:label andDirection:4]) {
                    [self checkFrontLabel:label andDirection:4];
                }
                
            }
            
            break;
            
        default:
            break;
    }
    
    return 0;
    
}
-(void)moveLabel:(int) directionFlag
{
    NSMutableArray *array1 = [[NSMutableArray alloc]initWithCapacity:4];
    NSMutableArray *array2 = [[NSMutableArray alloc]initWithCapacity:4];
    NSMutableArray *array3 = [[NSMutableArray alloc]initWithCapacity:4];
    NSMutableArray *array4 = [[NSMutableArray alloc]initWithCapacity:4];
    
    switch (directionFlag)
    {
        case 1: //right
            for (CLLuckyLabel *label in self.currentExistArray) {
                switch (label.placeTag/10) {
                    case 4:
                        [array1 addObject:label];
                        break;
                    case 3:
                        [array2 addObject:label];
                        break;
                    case 2:
                        [array3 addObject:label];
                        break;
                    case 1:
                        [array4 addObject:label];
                        break;
                    default:
                        break;
                }
            }
            for (CLLuckyLabel *childLabel in array2) {
                
                [self checkFrontLabel:childLabel andDirection:1];
            }
            for (CLLuckyLabel *childLabel in array3) {
                
                [self checkFrontLabel:childLabel andDirection:1];
            }
            for (CLLuckyLabel *childLabel in array4) {
                [self checkFrontLabel:childLabel andDirection:1];
            }
            break;
        case 2: //left
            for (CLLuckyLabel *label in self.currentExistArray) {
                switch (label.placeTag/10) {
                    case 1:
                        [array1 addObject:label];
                        break;
                    case 2:
                        [array2 addObject:label];
                        break;
                    case 3:
                        [array3 addObject:label];
                        break;
                    case 4:
                        [array4 addObject:label];
                        break;
                    default:
                        break;
                }
            }
            for (CLLuckyLabel *childLabel in array2) {
                [self checkFrontLabel:childLabel andDirection:2];
                
            }
            for (CLLuckyLabel *childLabel in array3) {
                [self checkFrontLabel:childLabel andDirection:2];
                
            }
            for (CLLuckyLabel *childLabel in array4) {
                [self checkFrontLabel:childLabel andDirection:2];
                
            }
            break;
        case 3: // up
            for (CLLuckyLabel *label in self.currentExistArray) {
                switch (label.placeTag%10) {
                    case 1:
                        [array1 addObject:label];
                        break;
                    case 2:
                        [array2 addObject:label];
                        break;
                    case 3:
                        [array3 addObject:label];
                        break;
                    case 4:
                        [array4 addObject:label];
                        break;
                    default:
                        break;
                }
            }
            for (CLLuckyLabel *childLabel in array2) {
                [self checkFrontLabel:childLabel andDirection:3];
            }
            for (CLLuckyLabel *childLabel in array3) {
                [self checkFrontLabel:childLabel andDirection:3];
            }
            for (CLLuckyLabel *childLabel in array4) {
                [self checkFrontLabel:childLabel andDirection:3];
            }
            break;
        case 4: // down
            for (CLLuckyLabel *label in self.currentExistArray) {
                switch (label.placeTag%10) {
                    case 4:
                        [array1 addObject:label];
                        break;
                    case 3:
                        [array2 addObject:label];
                        break;
                    case 2:
                        [array3 addObject:label];
                        break;
                    case 1:
                        [array4 addObject:label];
                        break;
                    default:
                        break;
                }
            }
            
            for (CLLuckyLabel *childLabel in array2) {
                [self checkFrontLabel:childLabel andDirection:4];
            }
            for (CLLuckyLabel *childLabel in array3) {
                [self checkFrontLabel:childLabel andDirection:4];
            }
            for (CLLuckyLabel *childLabel in array4) {
                [self checkFrontLabel:childLabel andDirection:4];
            }
            break;
        default:
            break;
    }
}
-(void)bornNewLabel
{
    if(self.currentExistArray.count<16){
        //设置空余方格的数列
        [self.emptyPlaceArray removeAllObjects];
        [self.emptyPlaceArray addObject:[NSNumber numberWithInt:11]];
        [self.emptyPlaceArray addObject:[NSNumber numberWithInt:21]];
        [self.emptyPlaceArray addObject:[NSNumber numberWithInt:31]];
        [self.emptyPlaceArray addObject:[NSNumber numberWithInt:41]];
        [self.emptyPlaceArray addObject:[NSNumber numberWithInt:12]];
        [self.emptyPlaceArray addObject:[NSNumber numberWithInt:22]];
        [self.emptyPlaceArray addObject:[NSNumber numberWithInt:32]];
        [self.emptyPlaceArray addObject:[NSNumber numberWithInt:42]];
        [self.emptyPlaceArray addObject:[NSNumber numberWithInt:13]];
        [self.emptyPlaceArray addObject:[NSNumber numberWithInt:23]];
        [self.emptyPlaceArray addObject:[NSNumber numberWithInt:33]];
        [self.emptyPlaceArray addObject:[NSNumber numberWithInt:43]];
        [self.emptyPlaceArray addObject:[NSNumber numberWithInt:14]];
        [self.emptyPlaceArray addObject:[NSNumber numberWithInt:24]];
        [self.emptyPlaceArray addObject:[NSNumber numberWithInt:34]];
        [self.emptyPlaceArray addObject:[NSNumber numberWithInt:44]];
        for (CLLuckyLabel *label in self.currentExistArray) {
            [self.emptyPlaceArray removeObject:[NSNumber numberWithInt:label.placeTag]];
        }
        
        //随机数必须小于空余方格的个数
        int random;
        if (self.emptyPlaceArray.count>1) {
            random=arc4random()%(self.emptyPlaceArray.count-1);
        }else{
            random=0;
        }
        
        //每次移动新增一个随机数字，设置每次移动的数字随机位置
        NSNumber *place=[self.emptyPlaceArray objectAtIndex:random];
        CLLuckyLabel *label=[[CLLuckyLabel alloc]init];
        label.placeTag=[place intValue];
        NSDictionary *dic=[self caculatePosition:place];
        
        //设置每次移动的数字大小
        int random2=arc4random()%2;
        NSNumber *textNumber=[self.labelArray objectAtIndex:random2];
        label.numberTag=[textNumber intValue];
        label.text=[NSString stringWithFormat:@"%@",textNumber];
        CGRect frame=CGRectMake([[dic objectForKey:kPlaceX] intValue], [[dic objectForKey:kPlaceY] intValue] , kOneLabelwidth, kOneLabelHeight);
        label.frame=frame;
        
        [self.currentExistArray addObject:label];
        [self.view addSubview:label];
    }
    else{
        [self isGameOver];
    }
}
-(void)isGameOver
{
    self.isOver = YES;
    //    [self moveLabel:1];
    //    [self moveLabel:2];
    //    [self moveLabel:3];
    //    [self moveLabel:4];
    
    if (self.isOver == YES) {
        
        UIAlertView *alertView =  [[UIAlertView alloc]initWithTitle:@"Game Over" message:[NSString stringWithFormat:@"恭喜你，获得了%d分，好棒哟！再来一局？",totalScore] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alertView show];
    }
    
}
-(NSDictionary *)caculatePosition:(NSNumber *)placeNumber
{
    int place=[placeNumber intValue];
    int x = 10+(kOneLabelwidth+10)*(place/10-1);
    int y = 65+(kOneLabelHeight+10)*(place%10-1);
    //    x = x-kOneLabelwidth/2;
    //    y = y-kOneLabelHeight/2;
    
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:
                         [NSNumber numberWithInt:x],kPlaceX,
                         [NSNumber numberWithInt:y],kPlaceY,
                         nil];
    
    return dic;
    
}
-(void)testBornLabel
{
    self.testArray =  [NSMutableArray arrayWithObjects:
                       [NSNumber numberWithInt:11],
                       [NSNumber numberWithInt:21],
                       [NSNumber numberWithInt:31],
                       [NSNumber numberWithInt:41],
                       [NSNumber numberWithInt:12],
                       [NSNumber numberWithInt:22],
                       [NSNumber numberWithInt:32],
                       [NSNumber numberWithInt:42],
                       [NSNumber numberWithInt:13],
                       [NSNumber numberWithInt:23],
                       [NSNumber numberWithInt:33],
                       [NSNumber numberWithInt:43],
                       [NSNumber numberWithInt:14],
                       [NSNumber numberWithInt:24],
                       [NSNumber numberWithInt:34],
                       [NSNumber numberWithInt:44],
                       
                       nil];
    
    for (int i=0; i<15; i++) {
        CLLuckyLabel *label = [[CLLuckyLabel alloc]init];
        label.placeTag = [[self.testArray objectAtIndex:i] intValue];
        label.numberTag = 2*(i+1);
        label.text = [NSString stringWithFormat:@"%d",label.numberTag];
        
        NSDictionary *dic =  [self caculatePosition:[NSNumber numberWithInt:label.placeTag]];
        
        CGRect frame =  CGRectMake([[dic objectForKey:kPlaceX] intValue]+1, [[dic objectForKey:kPlaceY] intValue]+1, kOneLabelwidth-2, kOneLabelHeight-2);
        
        label.frame = frame;
        [self.currentExistArray addObject:label];
        [self.view addSubview:label];
        
    }
    
}
-(void)setStateFlagDirection:(int)direction andPlace:(int) rORc
{
    
    if ((direction == kRight ) || (direction == kLeft)) {
        
        switch (rORc) {
            case 1:
                self.R_1 = NO;
                break;
            case 2:
                self.R_2 = NO;
                break;
            case 3:
                self.R_3 = NO;
                break;
            case 4:
                self.R_4 = NO;
                break;
                
            default:
                break;
        }
        
        
    }else if ((direction == kUp ) || (direction == kDown))
    {
        switch (rORc) {
            case 1:
                self.C_1 = NO;
                break;
            case 2:
                self.C_2 = NO;
                break;
            case 3:
                self.C_3 = NO;
                break;
            case 4:
                self.C_4 = NO;
                break;
                
            default:
                break;
        }
        
        
    }
    
    
    
}
-(BOOL)selfStateIsValid:(CLLuckyLabel *)label andDirection:(int)direction
{
    if ((direction == kRight ) || (direction == kLeft))
    {
        switch (label.placeTag%10) {
            case 1:
                return self.R_1;
                break;
            case 2:
                return self.R_2;
                break;
            case 3:
                return self.R_3;
                break;
            case 4:
                return self.R_4;
                break;
            default:
                break;
        }
        
    }else if ((direction == kUp ) || (direction == kDown))
    {
        
        switch (label.placeTag/10) {
            case 1:
                return self.C_1;
                break;
            case 2:
                return self.C_2;
                break;
            case 3:
                return self.C_3;
                break;
            case 4:
                return self.C_4;
                break;
            default:
                break;
        }
        
    }
    
    return NO;
    
}
-(BOOL)isFrontLabelEmpty:(CLLuckyLabel *)label andDirection:(int) direction
{
    
    switch (direction) {
        case kRight:
            for (CLLuckyLabel *childLabel in self.currentExistArray) {
                
                if ((label.placeTag+10) == childLabel.placeTag) {
                    return NO;
                }
            }
            break;
        case kLeft:
            for (CLLuckyLabel *childLabel in self.currentExistArray) {
                
                if ((label.placeTag-10) == childLabel.placeTag) {
                    return NO;
                }
            }
            break;
        case kUp:
            for (CLLuckyLabel *childLabel in self.currentExistArray) {
                
                if ((label.placeTag-1) == childLabel.placeTag) {
                    return NO;
                }
            }
            break;
        case kDown:
            for (CLLuckyLabel *childLabel in self.currentExistArray) {
                
                if ((label.placeTag+1) == childLabel.placeTag) {
                    return NO;
                }
            }
            break;
            
        default:
            break;
    }
    
    
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
