//
//  HomeViewController.m
//  WanAn1.0
//
//  Created by lanou3g on 15/8/19.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "HomeViewController.h"
#import "SleepRecordViewController.h"
#import "MusicViewController.h"
#import "DiaryViewController.h"
#import "ReadTableViewController.h"
@interface HomeViewController ()
- (IBAction)startSleep:(UIButton *)sender;
- (IBAction)mySleep:(UIButton *)sender;
- (IBAction)feelingStory:(UIButton *)sender;
- (IBAction)musicButton:(UIButton *)sender;
- (IBAction)chickenSoup:(UIButton *)sender;

@end

@implementation HomeViewController

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

- (IBAction)startSleep:(UIButton *)sender {
}

- (IBAction)mySleep:(UIButton *)sender {
    SleepRecordViewController * sleepRecord = [[SleepRecordViewController alloc]init];
    NSMutableArray * array = [NSMutableArray arrayWithObjects:@"15",@"6",@"7",@"8",@"9",@"10",@"1",nil];
    sleepRecord.allSleepTimeArray = array;
    [self.navigationController pushViewController:sleepRecord animated:YES];
    
}

- (IBAction)feelingStory:(UIButton *)sender {
    DiaryViewController * diary = [[DiaryViewController alloc]init];
    [self.navigationController pushViewController:diary animated:YES];
    
}

- (IBAction)musicButton:(UIButton *)sender {
    MusicViewController * musicVC = [[MusicViewController alloc]init];
    [self.navigationController pushViewController:musicVC animated:YES];
    
    
}

- (IBAction)chickenSoup:(UIButton *)sender {
    
    ReadTableViewController *readTVC = [[ReadTableViewController alloc] init];
    
    [self.navigationController pushViewController:readTVC animated:YES];
    
}
@end
