//
//  imgShowVC.m
//  Help
//
//  Created by GM on 2018/9/10.
//  Copyright © 2018年 Ugliest. All rights reserved.
//

#import "imgShowVC.h"
#import "UITapGestureRecognizer+Block.h"
@interface imgShowVC ()
@property (nonatomic,strong)UIImageView * image;
@end

@implementation imgShowVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"展示";
    __weak typeof(self)weakself =self;
    self.image = [[UIImageView alloc]init];
    self.image.userInteractionEnabled =YES;
    [self.image addGestureRecognizer:[UISwipeGestureRecognizer getureRecognizerWithActionBlock:^(id gestureRecognizer) {
        [weakself popNav];
        NSLog(@"viewM点击事件-------");
    }]];
    self.image.contentMode = UIViewContentModeScaleAspectFit;
    [self.view sd_addSubviews:@[self.image]];
    self.image.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake([self naviGationH], 0, 0, 0));
    [self.image sd_setImageWithURL:imgUrl(self.imgUrl) placeholderImage:placeholdImg];
    
    self.image.image = [self createShareImage:self.image.image Context:@"助老.在线"];
    // Do any additional setup after loading the view.
}
// imageName 图片名字， text 需画的字体
- (UIImage *)createShareImage:(UIImage *)sourceImage Context:(NSString *)text
{

    CGSize imageSize; //画的背景 大小
    imageSize = [sourceImage size];
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    [sourceImage drawAtPoint:CGPointMake(0, 0)];
    //获得 图形上下文
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextDrawPath(context, kCGPathStroke);
    CGFloat nameFont = 20.f;
    //画 自己想要画的内容
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:nameFont]};
    CGRect sizeToFit = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, nameFont) options:NSStringDrawingUsesDeviceMetrics attributes:attributes context:nil];
    NSLog(@"图片: %f %f",imageSize.width,imageSize.height);
    NSLog(@"sizeToFit: %f %f",sizeToFit.size.width,sizeToFit.size.height);
    //CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetRGBFillColor(context, 0, 0, 0, 1);
    [text drawAtPoint:CGPointMake(imageSize.width-sizeToFit.size.width-20 ,imageSize.height-sizeToFit.size.height-20) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:nameFont]}];
    //返回绘制的新图形
    
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return newImage;
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
