//
//  ReadDetailViewController.m
//  GoodNight
//
//  Created by lanou3g on 15/8/20.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ReadDetailViewController.h"

#define kURL @"http://jtbk.vipappsina.com/yulu/card21/articleDetail.php?id="

@interface ReadDetailViewController ()

@end

@implementation ReadDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.readDetailWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    NSString *url = [kURL stringByAppendingString:self.read.id];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [self.view addSubview:_readDetailWebView];
    
    [self.readDetailWebView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
