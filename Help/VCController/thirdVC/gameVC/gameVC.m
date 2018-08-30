//
//  gameVC.m
//  HELPXY
//
//  Created by GM on 2018/5/22.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "gameVC.h"
#import <AVFoundation/AVFoundation.h>
@interface gameVC ()<AVAudioPlayerDelegate>
{
    NSURL *inUrl;
    NSURL *outUrl;
    
    NSURL *inUrlB;
    NSURL *outUrlB;
    AVAudioPlayer *player;
}
@property (nonatomic,strong) UIImageView  * gifImageView;
@end

@implementation gameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubviews];
}
- (void) setSubviews{
    self.gifImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    self.gifImageView.image = [UIImage imageNamed:@"angry_00.jpg"];
    [self.view addSubview:self.gifImageView];
    [self.view addSubview:[self setButtonTitle:@"eat" frame:CGRectMake(0, KScreenHeight-270, 70, 88) tag:40]];
 
    [self.view addSubview:[self setButtonTitle:@"drink" frame:CGRectMake(0, KScreenHeight-180, 70, 88) tag:81]];
    
    [self.view addSubview:[self setButtonTitle:@"cymbal" frame:CGRectMake(0, KScreenHeight-90, 70, 88) tag:13]];
    [self.view addSubview:[self setButtonTitle:@"fart" frame:CGRectMake(KScreenWidth-70, KScreenHeight-270, 70, 88) tag:28]];
    
    [self.view addSubview:[self setButtonTitle:@"pie" frame:CGRectMake(KScreenWidth-70, KScreenHeight-180, 70, 88) tag:24]];
    
    [self.view addSubview:[self setButtonTitle:@"scratch" frame:CGRectMake(KScreenWidth-70, KScreenHeight-90, 70, 88) tag:56]];
    [self.view addSubview:[self setButtonTitle:@"footLeft" frame:CGRectMake(KScreenWidth/2.0, KScreenHeight-54, 50, 50) tag:30]];
    [self.view addSubview:[self setButtonTitle:@"footRight" frame:CGRectMake(KScreenWidth/2.0-50, KScreenHeight-54, 50, 50) tag:30]];
    [self.view addSubview:[self setButtonTitle:@"stomach" frame:CGRectMake(KScreenWidth/2.0-70, KScreenHeight-200, 140, 140) tag:34]];
     [self.view addSubview:[self setButtonTitle:@"angry" frame:CGRectMake(KScreenWidth/2.0-100, KScreenHeight-417, 200, 140) tag:26]];
      [self.view addSubview:[self setButtonTitle:@"knockout" frame:CGRectMake(KScreenWidth/2.0-100, KScreenHeight-487, 200, 70) tag:81]];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)Action:(UIButton *)sender {
   
    [self setAnimations:sender.titleLabel.text AndInteger:(int)sender.tag];
}
-(void)setAnimations:(NSString* )name AndInteger:(int)integer{
    if ([self.gifImageView isAnimating]) return;
    NSMutableArray* arr=[NSMutableArray array];
    for (int i=0; i<integer; i++) {
        NSString* imageName=[NSString stringWithFormat:@"%@_%02d.jpg",name,i];
        NSString* path=[[NSBundle mainBundle]pathForResource:imageName ofType:nil];
        UIImage* image=[UIImage imageWithContentsOfFile:path];
        [arr addObject:image];
    }
    if ([name isEqualToString:@"eat"]){
            [self playSoundWithFile:@"p_eat"];
    }else if([name isEqualToString:@"drink"]){
            [self playSoundWithFile:@"p_drink_milk"];
    }else if([name isEqualToString:@"cymbal"]){
            [self playSoundWithFile:@"cymbal"];
    }else if([name isEqualToString:@"fart"]){
            [self playSoundWithFile:@"fart003_11025"];
    }else if([name isEqualToString:@"pie"]){
            [self playSoundWithFile:@"slap6"];
    }else if([name isEqualToString:@"scratch"]){
            [self playSoundWithFile:@"scratch_kratzen"];
    }else if([name isEqualToString:@"footLeft"]){
            [self playSoundWithFile:@"p_foot3"];
    }else if([name isEqualToString:@"footRight"]){
            [self playSoundWithFile:@"p_foot3"];
    }else if([name isEqualToString:@"stomach"]){
            [self playSoundWithFile:@"p_belly1"];
    }else if([name isEqualToString:@"angry"]){
            [self playSoundWithFile:@"angry"];
    }else if([name isEqualToString:@"knockout"]){
            [self playSoundWithFile:@"p_stars2s"];
    }
    self.gifImageView.animationImages=arr;
    self.gifImageView.animationRepeatCount=1;
    self.gifImageView.animationDuration=arr.count*0.075;
    [self.gifImageView startAnimating];
    //动画结束后，清理内存
    [self.gifImageView performSelector:@selector(setAnimationImages:) withObject:nil afterDelay:self.gifImageView.animationDuration];
}
- (UIButton *)setButtonTitle:(NSString *)title frame:(CGRect)frame tag:(NSInteger)tag{
    UIButton * btn = [[UIButton alloc]initWithFrame:frame];
    btn.tag=tag;
    btn.titleLabel.text =title;
    btn.titleLabel.textColor = [UIColor clearColor];
    [btn setImage:[UIImage imageNamed:title] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(Action:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
-(void)playSoundWithFile:(NSString*)filename
{
    [[SCListener sharedListener] stop];
    
    NSString *outputSound = [[NSBundle mainBundle] pathForResource:filename ofType:@"wav"];
    outUrlB = [NSURL fileURLWithPath:outputSound];
    
    NSError *error = nil;
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:outUrlB error:&error];
    if (error)
        NSLog(@"AVAudioPlayer error %@, %@", error, [error userInfo]);
    
    [player play];
    player.delegate = self;
}
@end
