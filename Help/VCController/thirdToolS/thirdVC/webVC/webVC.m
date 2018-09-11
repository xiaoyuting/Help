//
//  webVC.m
//  HELPXY
//
//  Created by GM on 2018/8/28.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "webVC.h"

#import <WebKit/WKWebView.h>
@interface webVC ()
@property (nonatomic,strong)WKWebView * webView;
@end

@implementation webVC
- (instancetype)init{
    if (self=[super init]){
        self.type =0;
    }
    return  self;
}
- (void)setSubviews{
    NSString * str =[NSString string];
    if (self.type==1){
        str =@"http://yxyzl.cn/mssh";
    }else if (self.type==2){
        str =@"http://yxyzl.cn/fjly";
    }else if (self.type==3){
        str =@"http://yxyzl.cn/zxzx";
    }else if (self.type==4){
        str =@"http://yxyzl.cn/qyzn";
    }
    self.webView = [[WKWebView alloc]init];
   // self.webView.navigationDelegate =self;
    //self.webView.UIDelegate  =self;
    NSURL * url = [NSURL URLWithString:str];
    NSURLRequest  * request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    [self.view sd_addSubviews:@[self.webView]];
    self.webView.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake([self naviGationH], 0, 0, 0));
}
- (void)viewDidLoad {
    [self setSubviews];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)rightItemClick:(id)sender{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
        
    }else{
        [self.view resignFirstResponder];
        [self popNav];
    }
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
