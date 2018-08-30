//
//  RootBaseBar.m
//  ProjectTemplate
//
//  Created by 雨停 on 2017/9/28.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "RootBaseBar.h"
#import "RootBaseVC.h"
#import "RootBaseNav.h"

@interface RootBaseBar ()

@end

@implementation RootBaseBar

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationVC];
    [self setTabBarItemTheme];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setTabBarItemTheme{
   /*     [self.tabBar setTintColor:mainColor];
    self.tabBar.translucent=NO;
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor blackColor],
                                                       NSForegroundColorAttributeName,
                                                       FontSize (10),
                                                       NSFontAttributeName,nil]
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       mainColor,
                                                       NSForegroundColorAttributeName,
                                                       FontSize(10),
                                                       NSFontAttributeName,nil]
                                             forState:UIControlStateSelected];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth ,  1)];
    lineView.backgroundColor = [UIColor whiteColor];
    [self.tabBar addSubview: lineView];
    //[self.tabBar setShadowImage: Img (@"new")];
    [self.tabBar setBackgroundImage: [[UIImage alloc]init]];*/
}
-(void)addNavigationVC{
    
        
        NSArray *titleArr        = @[@"亲朋",@"友邻",@"对话",@"工具",@"我的"];
        NSArray *vcNameArr       = @[@"Home",@"info",@"chat",@"third",@"me"];
        NSArray *tabIconNameArr  = @[@"bi1",@"bi2",@"bi3",@"bi4",@"bi5"];
        NSArray *tabSIconNameArr = @[@"bis1",@"bis2",@"bis3",@"bis4",@"bis5"];
        NSMutableArray *vcArr = [NSMutableArray array];
        for (NSInteger i = 0; i < titleArr.count ; i++) {
            NSString *vcName = [NSString stringWithFormat: @"%@VC",vcNameArr[i]];
            
            Class class = NSClassFromString(vcName);
            RootBaseVC * vc  = [[class alloc]init];
            RootBaseNav *nav = [[RootBaseNav alloc]initWithRootViewController:vc];
            nav.navigationBar.barTintColor=ColorFF(0x78C34E);
            // 设置 tabbarItem 选中状态下的文字颜色(不被系统默认渲染,显示文字自定义颜色)
            NSDictionary *dictHome = [NSDictionary dictionaryWithObject:ColorFF(0x78C34E) forKey:NSForegroundColorAttributeName];
            [nav.tabBarItem setTitleTextAttributes:dictHome forState:UIControlStateSelected];
          
            nav.tabBarItem.title = titleArr[i];
            nav.tabBarItem.image = [UIImage  imageNamed:tabIconNameArr[i]];
            UIImage *imageHome =  [UIImage  imageNamed:tabSIconNameArr[i]];
            imageHome = [imageHome imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            [nav.tabBarItem setSelectedImage:imageHome];
            vc.navigationController.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
            [vc.navigationController.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -2)];
            [vcArr   addObject:nav];
            
     }
//       listChatView * chat = [[listChatView alloc]init];
//    RootBaseNav *nav = [[RootBaseNav alloc]initWithRootViewController:chat];
//    nav.navigationBar.barTintColor=ColorFF(0x78C34E);
//    nav.tabBarItem.title = @"聊天";
    // 设置 tabbarItem 选中状态下的文字颜色(不被系统默认渲染,显示文字自定义颜色)
//    NSDictionary *dictHome = [NSDictionary dictionaryWithObject:ColorFF(0x78C34E) forKey:NSForegroundColorAttributeName];
//    [nav.tabBarItem setTitleTextAttributes:dictHome forState:UIControlStateSelected];
//    nav.tabBarItem.image = [UIImage  imageNamed:@"bi3"];
//    UIImage *imageHome = [UIImage imageNamed:@"bis3"];
//    imageHome = [imageHome imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    [nav.tabBarItem setSelectedImage:imageHome];
    
//    [chat.navigationController.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -2)];
//    [vcArr insertObject:nav atIndex:2];
        self.viewControllers  = vcArr;
         
    
}

@end
