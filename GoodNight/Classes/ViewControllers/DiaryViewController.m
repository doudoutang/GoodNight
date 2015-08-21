//
//  DiaryViewController.m
//  GoodNight
//
//  Created by lanou3g on 15/8/20.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "DiaryViewController.h"
#import "addDiaryViewController.h"
@interface DiaryViewController ()
- (IBAction)addDiary:(UIButton *)sender;

@end

@implementation DiaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)addDiary:(UIButton *)sender {
    addDiaryViewController * writeDiaryVC = [[addDiaryViewController alloc]init];
    [self.navigationController pushViewController:writeDiaryVC animated:YES];
}
@end
