//
//  ReadDetailViewController.m
//  GoodNight
//
//  Created by lanou3g on 15/8/20.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ReadDetailViewController.h"

#define kURL @"http://jtbk.vipappsina.com/yulu/card21/articleDetail.php?id="

@interface ReadDetailViewController ()<UIWebViewDelegate>

@end

@implementation ReadDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.read.title;
    
    self.readDetailWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    //设置代理
    self.readDetailWebView.delegate = self;
    
    NSString *url = [kURL stringByAppendingString:self.read.id];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [self.view addSubview:_readDetailWebView];
    
    [self.readDetailWebView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    UIView *backView = [[UIView alloc] initWithFrame:self.view.bounds];
    backView.tag = 101;
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0.5;
    [self.view addSubview:backView];
    
    UIActivityIndicatorView *activituIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    activituIndicatorView.center = self.view.center;
    activituIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    activituIndicatorView.tag = 102;
    [self.view addSubview:activituIndicatorView];
    [activituIndicatorView startAnimating];
    
}

#pragma mark - 加载完成
-(void)webViewDidFinishLoad:(UIWebView *)webView {
    
    UIActivityIndicatorView *activituIndicatorView = (UIActivityIndicatorView *)[self.view viewWithTag:102];
    [activituIndicatorView stopAnimating];
    UIView *backView = (UIView *)[self.view viewWithTag:101];
    [backView removeFromSuperview];
    
}

#pragma mark - 加载失败
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"网络连接失败,请刷新重试" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [alertC addAction:cancleAction];
    
    UIAlertAction *tureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        
        
    }];
    [alertC addAction:tureAction];
    [self presentViewController:alertC animated:YES completion:nil];

    
    UIActivityIndicatorView *activituIndicatorView = (UIActivityIndicatorView *)[self.view viewWithTag:102];
    [activituIndicatorView stopAnimating];
    UIView *backView = (UIView *)[self.view viewWithTag:101];
    [backView removeFromSuperview];
    
}

@end
