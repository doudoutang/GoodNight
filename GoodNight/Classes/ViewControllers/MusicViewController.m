//
//  MusicViewController.m
//  GoodNight
//
//  Created by lanou3g on 15/8/19.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MusicViewController.h"
#import "SDCycleScrollView.h"
@interface MusicViewController ()<SDCycleScrollViewDelegate>

@end

@implementation MusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *images = @[[UIImage imageNamed:@"h1.jpg"],
                            [UIImage imageNamed:@"h2.jpg"],
                            [UIImage imageNamed:@"h3.jpg"],
                            [UIImage imageNamed:@"h4.jpg"]];
    
    SDCycleScrollView *imageScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame)/3, self.view.bounds.size.width, CGRectGetHeight(self.view.frame)/3) imagesGroup:images];
    
    imageScrollView.delegate = self;
    
        [self.view addSubview:imageScrollView];

}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    NSLog(@"%lu",(long)index);
    
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
