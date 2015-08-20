//
//  SleepRecordViewController.m
//  WanAn1.0
//
//  Created by lanou3g on 15/8/19.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "SleepRecordViewController.h"

@interface SleepRecordViewController ()
@property (nonatomic,strong) UIView * allSleepBack;//柱状图底面
@property (nonatomic,strong) UIImageView * allSleepBackImage;//
@property (nonatomic,strong) UIImageView * sleepTime1;//单个柱状图
@property (nonatomic,strong) UIImageView * viewBackGroundImageView;//大背景
@property (nonatomic,strong) UILabel * sleepBottonLable;//柱状图说明
@property (nonatomic,strong) UIImageView * katongCat;//猫
@property (nonatomic,strong) UIImageView * katongSay;//对话框
@end

@implementation SleepRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //设置背景
    [self backGroundimage];
    
    //柱状图
    [self histogram];
    
    //对话框
    [self catSayToPeople];
}
#pragma mark - 背景设置
-(void)backGroundimage{
    self.viewBackGroundImageView = [[UIImageView alloc]initWithFrame:[[UIScreen mainScreen]bounds ]];
    _viewBackGroundImageView.image = [UIImage imageNamed:@"sleepBackImage.png"];
    [self.view addSubview:_viewBackGroundImageView];
}
#pragma mark - 柱状图
-(void)histogram{
    //位置
    self.allSleepBack = [[UIView alloc]initWithFrame:CGRectMake(70, 250,280,0)];
    //北京透明
    _allSleepBack.backgroundColor = [UIColor clearColor];
    //柱状图生成
    for (int i=0; i<7; i++) {
        int a = [self changTimeToLong:_allSleepTimeArray[i]];
        self.sleepTime1 = [[UIImageView alloc]initWithFrame:CGRectMake((_allSleepBack.frame.size.width/7)*i, 0, _allSleepBack.frame.size.width/7,- (self.view.frame.size.height/3 * a /24))];
        _sleepTime1.image = [UIImage imageNamed:@"sleepStrip.png"];
        [self.allSleepBack addSubview:_sleepTime1];
    }
    //侧边文字说明
    for (int i=1;i<5 ;i++ ) {
    UILabel *num =[[UILabel alloc]initWithFrame:CGRectMake(70,220-i*(self.view.frame.size.height/12), -40,50)];
    num.backgroundColor = [UIColor clearColor];
    num.text = [NSString stringWithFormat:@"%d:0",i*6];
    num.textColor = [UIColor whiteColor];
    num.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:num];
    }
    //下边文字说明
    self.sleepBottonLable =[[UILabel alloc]initWithFrame:CGRectMake(_allSleepBack.frame.size.width/4+50, 250, _allSleepBack.frame.size.width/2,50)];
    _sleepBottonLable.backgroundColor = [UIColor clearColor];
    _sleepBottonLable.text = @"最近一周睡眠状况";
    _sleepBottonLable.textColor = [UIColor whiteColor];
    _sleepBottonLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_sleepBottonLable];
    //加入柱状图
    [self.view addSubview:_allSleepBack];

}
//猫给人说话的View
-(void)catSayToPeople{
    //猫画面
    self.katongCat = [[UIImageView alloc]initWithFrame:CGRectMake(70+_allSleepBack.frame.size.width*2/3, 250+70, _allSleepBack.frame.size.width/3,  _allSleepBack.frame.size.width/3)];
    _katongCat.image = [UIImage imageNamed:@"katong.png"];
    [self.view addSubview:_katongCat];
    //对话框
    self.katongSay = [[UIImageView alloc]initWithFrame:CGRectMake(70, 250+50, _allSleepBack.frame.size.width*2/3,  _allSleepBack.frame.size.width/2)];
    _katongSay.image = [UIImage imageNamed:@"sayImage.png"];
    [self.view addSubview:_katongSay];
    //文字
    UILabel * sayText = [[UILabel alloc]initWithFrame:CGRectMake(70+20, 250+50+20, _allSleepBack.frame.size.width*2/3-40,  _allSleepBack.frame.size.width/2-40)];
    sayText.text = [self catSayDetail];
    sayText.numberOfLines = 0;
    [self.view addSubview:sayText];
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


//对话内容
-(NSString*)catSayDetail{
    NSInteger bo = [self panduanSleep];
    if (bo ==1) {
        return @"亲  你睡得太少了\n 请注意休息哦";
    }else if (bo == 2){
        return @"亲你的睡眠很正常\n好好保持呦";
    }else{
        return  @"你是猪吗?????????";
    }
}
//柱状图数据转换
-(int )changTimeToLong:(NSString*)time{
    int a = [time intValue];
    return a ;
}
//判断睡眠情况
-(NSInteger)panduanSleep{
    NSInteger all = 0;
    for (int i=0; i<[_allSleepTimeArray count]-1; i++) {
        all = all + [_allSleepTimeArray[i] integerValue];
    }
    NSInteger every = all/_allSleepTimeArray.count;
    if (([_allSleepTimeArray[_allSleepTimeArray.count - 1] integerValue]/every )< 0.8) {
        return 1;
    }else if(([_allSleepTimeArray[_allSleepTimeArray.count - 1] integerValue]/every )> 0.8&&([_allSleepTimeArray[_allSleepTimeArray.count - 1] integerValue]/every )< 1.2){
        return 2;
    }else{
        return 3;
    }
}





@end
