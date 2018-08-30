//
//  RootBaseVC.m
//  ProjectTemplate
//
//  Created by 雨停 on 2017/9/28.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "RootBaseVC.h"



#import "ProgressHUD.h"
@interface RootBaseVC ()<UIGestureRecognizerDelegate>
{
    CGPoint startPoint;
    UIView *_mainViewNavigitionView;
}

@property (nonatomic, strong)UIView *clearView;
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic,strong)ProgressHUD * hud;
@end

@implementation RootBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
}



-(void)pushViewController:(RootBaseVC *)VC animated:(BOOL)animated{
    VC.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:VC animated:animated];
}
-(void)rootPushViewContreller:(RootBaseVC *)VC animated:(BOOL)animated{
    VC.hidesBottomBarWhenPushed =YES;
    [ self.navigationController popToViewController:VC animated:animated];
}

-(void)popNav{
    BOOL aninated =YES;
    if(self.navigationController.viewControllers.count==2){
       
        aninated =NO;
        
    }
    [self.navigationController popViewControllerAnimated:aninated];
}
- (NSMutableString *)webImageFitToDeviceSize:(NSMutableString *)strContent
{
    [strContent appendString:@"<html>"];
    [strContent appendString:@"<head>"];
    [strContent appendString:@"<meta charset=\"utf-8\">"];
    [strContent appendString:@"<meta id=\"viewport\" name=\"viewport\" content=\"width=device-width*0.9,initial-scale=1.0,maximum-scale=1.0,user-scalable=false\" />"];
    [strContent appendString:@"<meta name=\"apple-mobile-web-app-capable\" content=\"yes\" />"];
    [strContent appendString:@"<meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\" />"];
    [strContent appendString:@"<meta name=\"black\" name=\"apple-mobile-web-app-status-bar-style\" />"];
    [strContent appendString:@"<style>img{width:100%;}</style>"];
    [strContent appendString:@"<style>table{width:100%;}</style>"];
    [strContent appendString:@"<title>webview</title>"];
    return strContent;
}
- (void)setBackBarButtonItem {
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc] init];
    UIButton *btnleftView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    btnleftView.imageEdgeInsets =UIEdgeInsetsMake(0, -30, 0, 0);
    
    if ([self.navigationController.viewControllers count] > 1) {
        
        [btnleftView setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
        [btnleftView setContentMode:UIViewContentModeScaleAspectFit];
        [backItem  setCustomView:btnleftView];
        [btnleftView addTarget:self action:@selector(popNav) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = backItem;
        
    }
}

- (void)setNavLeftItemTitle:(NSString *)str andImage:(UIImage *)image {
    //    if ([self.navigationController.viewControllers count] ==1){
    if ([str isEqualToString:@""] || !str)
    {
        UIBarButtonItem *leftItem =[[UIBarButtonItem alloc] initWithImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick:)];
        self.navigationItem.leftBarButtonItem = leftItem;
    }
    else if(str&&image ){
        UIButton  * btn= [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(-10, 0, 80, 20);
        [btn setTitle:str  forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"zhankai"] forState:UIControlStateNormal];
        UIBarButtonItem *LeftBarButton = [[UIBarButtonItem alloc] initWithCustomView:btn];
        self.navigationItem.leftBarButtonItem =LeftBarButton;
        [btn addTarget:self action:@selector(location:) forControlEvents:UIControlEventTouchUpInside];
    }else if([str isEqualToString:@"返回"]){
        //创建一个UIButton
        UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 24)];
        backButton.adjustsImageWhenHighlighted = NO;
        //设置UIButton的图像
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        backButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        backButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        [backButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        //给UIButton绑定一个方法，在这个方法中进行popViewControllerAnimated
        [backButton addTarget:self action:@selector(leftItemClick:) forControlEvents:UIControlEventTouchUpInside];
        //然后通过系统给的自定义BarButtonItem的方法创建BarButtonItem
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
        //覆盖返回按键
        self.navigationItem.leftBarButtonItem = backItem;
    }
    else
    {
        UIBarButtonItem *leftItem =[[UIBarButtonItem alloc] initWithTitle:str style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick:)];
        self.navigationItem.leftBarButtonItem = leftItem;
    }
}

-(void)location :(id)sender{
}
- (void)setNavRightItemTitle:(NSString *)str andImage:(UIImage *)image
{
    if ([str isEqualToString:@""] || !str)
    {
        UIBarButtonItem *rightItem =[[UIBarButtonItem alloc] initWithImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick:)];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
    else
    {
        UIBarButtonItem *rightItem =[[UIBarButtonItem alloc] initWithTitle:str style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick:)];
        [rightItem setTintColor:[UIColor whiteColor]];
        [rightItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14],NSFontAttributeName, nil] forState:UIControlStateNormal];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
}

- (void)rightItemClick:(id)sender {
    
}

- (void)leftItemClick:(id)sender{
    
}

- (float)getTextWidth:(float)textHeight text:(NSString *)text font:(UIFont *)font {
    if (!text.length) {
        return 0;
    }
    float origin = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, textHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: font} context:nil].size.width;
    return ceilf(origin);
}

- (float)getTextHeight:(float)textWidth text:(NSString *)text font:(UIFont *)font {
    if (!text.length) {
        return 0;
    }
    float origin = [text boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: font} context:nil].size.height;
    return ceilf(origin);
}


- (void)loadNewData {
    
}
- (void)loadMoreData{
    
}
- (void)setSubviews {
    
}
- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}

- (CGFloat)naviGationH{
    CGFloat h =0;
    // 状态栏(statusbar)
    
    CGRect StatusRect = [[UIApplication sharedApplication] statusBarFrame];
    
    //标题栏
    
    CGRect NavRect = self.navigationController.navigationBar.frame;
    
    h= StatusRect.size.height+NavRect.size.height;
    
    return h;
    
}
- (CGFloat)tabBarH{

    if ([self naviGationH]>64){
        return 83;
    }
    return 49;
}

-(void)dealloc
{
    //[self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 判断是否是手机号码
 
 @param str 手机号
 @return  NO 不是手机号，YES 是手机号
 */
-(Boolean)isPhone:(NSString*)str
{
    if ((Nil == str) ||(str.length == 0)) {
        return NO;
    }
    NSString *regEx = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    return [self baseCheckForRegEx:regEx data:str];
}
/**
 *  基本的验证方法
 *
 *  @param regEx 校验格式
 *  @param data  要校验的数据
 *
 *  @return YES:成功 NO:失败
 */
-(BOOL)baseCheckForRegEx:(NSString *)regEx data:(NSString *)data{
    NSPredicate *card = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
    if (([card evaluateWithObject:data])) {
        return YES;
    }
    return NO;
}

-(void)showProgressTitle:(NSString *)title autoHide:(BOOL)hidePro{
    self.hud = [ProgressHUD showHUDAddedTo:[UIApplication  sharedApplication].keyWindow animated:YES];
    self.hud.detailsLabel.text = title;
    self.hud.label.font = [UIFont systemFontOfSize:12.0];
    //大背景底色
    self.hud.backgroundView.style = ProgressHUDBackgroundStyleSolidColor;
    self.hud.backgroundView.color =[UIColor colorWithWhite:0.9f alpha:0.1f];
    self.hud.backgroundView.backgroundColor =[UIColor colorWithWhite:0.2f alpha:0.1f];
    self.hud.bezelView.color    =[UIColor whiteColor];
    //菊花和文字颜色
    self.hud.contentColor = [UIColor whiteColor];
    //文字颜色
    self.hud.label.textColor =  [UIColor whiteColor];
    // self.hud.userInteractionEnabled= NO;
    // self.hud.customView = [[UIImageView alloc] initWithImage:icon];  // 设置图片
    self.hud.bezelView.style = ProgressHUDBackgroundStyleSolidColor;
    self.hud.bezelView.backgroundColor = [UIColor blackColor];    //背景颜色
    // 设置图片
    //self.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    // self.hud.mode = ProgressHUDModeIndeterminate;
    
    // 隐藏时候从父控件中移除
    // self.hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    //3[self.hud hideAnimated:YES afterDelay:1.5];
    /*显示HUD的步骤：1.创建MBProgressHUD对象 2.将对象添加到视图  3.调用show方法*/
    /*隐藏HUD的两种方法：1.hide：  2.hid：afterDelay：*/
    
    //self.hud
    /**1.设置hud的模式：loading动画视图的效果*/
    //    self.hud.mode = ProgressHUDModeIndeterminate;//菊花样式，默认值
    
    //    self.hud.mode = ProgressHUDModeDeterminate;//圆饼图
    
    //    self.hud.mode = MBProgressHUDModeDeterminateHorizontalBar;//进度条
    
    //    self.hud.mode = ProgressHUDModeAnnularDeterminate;//圆环进度条
    
    //    self.hud.mode = MBProgressHUDModeCustomView;//设置自定义视图时，设置属性值为这个
    
    // self.hud.mode = ProgressHUDModeText;//只显示文本，通过labelText设置文本内容
    
    //    self.hud.labelText = @"输入有误 ";
    
    /**2.HUD背景框的属性*/
    //           self.hud.opacity = 0.1;//设置背景框的透明度，默认为0.8，设置完颜色和颜色通道之后该属性失效
    //
    //        self.hud.color = [UIColor blackColor];//设置背景颜色
    //
    //        self.hud.color = [self.hud.color colorWithAlphaComponent:0.5];//设置背景色通道
    //
    //        self.hud.cornerRadius = 20;//设置背景框的圆角值，默认是10
    //
    //        self.hud.xOffset = 80;//设置提示框相对于父视图中心点的偏移值
    //
    //        self.hud.yOffset = 80;//
    
    self.hud.margin = 15;//设置各个元素距离矩形边框的距离，可以根据这个设置提示框的大小
    
    self.hud.minSize = CGSizeMake(10, 10);//背景框的最小大小
    self.hud.tintColor =[UIColor whiteColor];
    // self.hud.square = YES;
    
    /**3.设置详情框的属性*/
    //    self.hud.detailsLabelColor = [UIColor orangeColor];//设置详情文本颜色
    //
    //    self.hud.detailsLabelFont = [UIFont systemFontOfSize:13];//设置详情文本大小
    //
    //    self.hud.detailsLabelText = @"loading...";//设置详情文本内容
    //
    
    /**4.设置标题框的属性*/
    
    
    /**设置显示和消失切换时的动画效果*/
    
    self.hud.animationType = ProgressHUDAnimationFade;//渐变消失
    
    //self.hud.animationType = ProgressHUDAnimationZoomOut;//缩小消失
    
    //    self.hud.animationType = MBProgressHUDAnimationZoomIn;//放大消失
    
    //    self.hud.minShowTime = 3;//设置最短显示时间，避免显示后立刻被隐藏  默认是0
    
    
    
    
    //    /**其他设置*/
    // self.hud.activityIndicatorColor = [UIColor greenColor];//设置菊花（活动指示器）颜色
    //
    //= [[UIView alloc]initWithFrame:CGRectMake(0, 0, ugliestKScreenWidth, ugliestKScreenHeight)];//设置一个渐变背景层
    //
    //    self.hud.removeFromSuperViewOnHide = NO;//设置隐藏的时候是否从父视图中移除，默认是no
    //
    //    self.hud.progress = 0.5;//进度指示器  模式是0，取值从0.0-1.0
    
    //    self.hud.minShowTime = 3;//设置最短显示时间
    
    //[self.hud show:YES];//设置完成后显示hud
    
    //    [self.hud hide:YES];//隐藏hud
    if (hidePro){
        self.hud.mode = ProgressHUDModeText;
        [self.hud hideAnimated:YES  afterDelay:1];
    }
    //[self.hud hide:YES afterDelay:5];//5秒后隐藏HUD
    
    //隐藏hud后调用的block
    //    self.hud.completionBlock = ^{
    //        NSLog(@"----------block");
    //    };
    
    
    
}

-(void)showProgressTitle:(NSString *)title {
    self.hud = [ProgressHUD showHUDAddedTo:[UIApplication  sharedApplication].keyWindow animated:YES];
    self.hud.detailsLabel.text = title;
    self.hud.label.font = [UIFont systemFontOfSize:12.0];
    //大背景底色
    self.hud.backgroundView.style = ProgressHUDBackgroundStyleSolidColor;
    self.hud.backgroundView.color =[UIColor colorWithWhite:0.7f alpha:0.1f];
    self.hud.backgroundView.backgroundColor =[UIColor colorWithWhite:0.f alpha:0.5f];
    self.hud.bezelView.color    =[UIColor whiteColor];
    //菊花和文字颜色
    self.hud.contentColor = [UIColor whiteColor];
    //文字颜色
    self.hud.label.textColor =  [UIColor whiteColor];
    
    self.hud.bezelView.style = ProgressHUDBackgroundStyleSolidColor;
    self.hud.bezelView.backgroundColor = [UIColor blackColor];    //背景颜色
    self.hud.margin = 15;//设置各个元素距离矩形边框的距离，可以根据这个设置提示框的大小
    
    self.hud.minSize = CGSizeMake(10, 10);//背景框的最小大小
    self.hud.tintColor =[UIColor whiteColor];
    
    
    
    self.hud.animationType = ProgressHUDAnimationFade;//渐变消失
    
    
    
    
    
    
}


-(void)hideProgress{
    [self.hud hideAnimated:YES];
    
}
@end
