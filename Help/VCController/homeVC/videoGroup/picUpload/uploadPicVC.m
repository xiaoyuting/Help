//
//  uploadPicVC.m
//  HELPXY
//
//  Created by GM on 2018/5/11.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "uploadPicVC.h"
 

//static const CGFloat kPhotoViewMargin = 12.0;
@interface uploadPicVC ()< UIImagePickerControllerDelegate,UITextViewDelegate>


@property (strong, nonatomic) UIScrollView * scrollView;
@property (strong, nonatomic) UITextView   * textView;
@property (strong, nonatomic) UILabel      * count ;



@end

@implementation uploadPicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubviews];
}
- (void)setSubviews{
    self.title =@"上传";
    self.view.backgroundColor = [UIColor whiteColor];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    self.textView = [[UITextView alloc]init];
    self.textView.layer.borderWidth  = 1;
    self.textView.layer.cornerRadius = 5;
    self.textView.delegate = self;
    //self.textView. placeholder = @"21321";
    self.textView.layer.borderColor  = [UIColor lightGrayColor].CGColor;
    self.count    = [[UILabel alloc]init];
    self.count.font = SYSTEMFONT(13);
    self.count.text = @"0/200";
    self.count.textAlignment = NSTextAlignmentRight;
    
    CGFloat width = scrollView.frame.size.width;
  
    [self.scrollView sd_addSubviews:@[self.textView,self.count]];
    self.textView.sd_layout
    .leftSpaceToView(  self.scrollView, 5)
    .topSpaceToView(   self.scrollView, +5)
    .rightSpaceToView( self.scrollView, 5)
    .heightIs(200);
    self.count.sd_layout
    .topSpaceToView(   self.textView, 5)
    .leftSpaceToView(  self.scrollView, 5)
    .rightSpaceToView( self.scrollView, 5)
    .heightIs(20);
  
    
    
}


- (void)textViewDidChange:(UITextView *)textView
{
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    
    if (existTextNum >200)
    {
        //截取到最大位置的字符
        NSString *s = [nsTextContent substringToIndex:500];
        
        [textView setText:s];
    }
    
    //不让显示负数
    self.count.text = [NSString stringWithFormat:@"%ld/200",MAX(0,200 - existTextNum)];
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text

{
    if (![text isEqualToString:@""])
    {
       // self.btnPush.userInteractionEnabled=YES;
       // [self.btnPush setBackgroundColor:mainColor];
        
    }
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1)
    {
       // self.btnPush.userInteractionEnabled=NO;
       // [self.btnPush setBackgroundColor:[UIColor lightGrayColor]];
        
    }
    
    
    NSString * comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    NSInteger caninputlen = 200 - comcatstr.length;
    
    if (caninputlen >= 0)
    {
        
        return YES;
    }
    else
    {
        NSInteger len = text.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        
        if (rg.length > 0)
        {
            NSString *s = [text substringWithRange:rg];
            
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
        }
        return NO;
    }
    
    
    return YES;
}

@end
