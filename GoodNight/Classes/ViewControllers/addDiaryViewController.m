//
//  addDiaryViewController.m
//  GoodNight
//
//  Created by lanou3g on 15/8/20.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "addDiaryViewController.h"
#import <MapKit/MapKit.h>
#define zhuangtailan 64
@interface addDiaryViewController ()<UITextViewDelegate,CLLocationManagerDelegate>
@property (nonatomic,strong) UITextView * storyTextField;//输入框
@property (strong, nonatomic) IBOutlet UIView *backView;
@property (strong, nonatomic) UIView * lableView;//标题View
@property (strong,nonatomic) UIImageView * feelImageView;//心情图标
@property (strong,nonatomic) UIImageView * weatherImageView;//天气图标
@property (strong,nonatomic) UIImageView * addressImageView;//地址图标
@property (strong,nonatomic) UILabel * timeLable;//时间图标
@property (strong,nonatomic) UIView * allButtonView;//底部view
@property (strong,nonatomic) UIButton * buttonWeather;//天气按钮
@property (strong,nonatomic) UIButton * buttonAddress;//地址按钮
@property (strong,nonatomic) UIButton * buttonPicture;//图片按钮
@property (strong,nonatomic) UIButton * buttonFeel;//心情按钮
@property (strong,nonatomic) UIView * buttonDetailView;//button详情View
@property (strong,nonatomic) CLLocationManager * locationManager;//
@end

@implementation addDiaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:nil action:nil];
    self.navigationItem.rightBarButtonItem = rightButton;
    // Do any additional setup after loading the view from its nib.
    [self addTestField];//添加各种view
}
-(void)addTestField{
    /**
     背景View设置
     */
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, zhuangtailan, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-zhuangtailan)];
    //添加日记标题view
    self.lableView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, self.backView.frame.size.width-20, self.backView.frame.size.height/15)];
    _lableView.backgroundColor = [UIColor blueColor];
    
    //添加时间
    self.timeLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, self.lableView.frame.size.width/2, self.lableView.frame.size.height-20)];
    _timeLable.text = @"2015年8月21日";
    [_lableView addSubview:_timeLable];
    
    //添加心情
    self.feelImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.lableView.frame)-self.lableView.frame.size.height, 10, self.lableView.frame.size.height-20, self.lableView.frame.size.height-20)];
    _feelImageView.image = [UIImage imageNamed:@"katong.png"];
    [_lableView addSubview:_feelImageView];
    
    //添加天气
    self.weatherImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.lableView.frame)-(self.lableView.frame.size.height*2), 10, self.lableView.frame.size.height-20, self.lableView.frame.size.height-20)];
    _weatherImageView.image = [UIImage imageNamed:@"katong.png"];
    [_lableView addSubview:_weatherImageView];
    
    //添加地址
    self.addressImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.lableView.frame)-(self.lableView.frame.size.height*3), 10, self.lableView.frame.size.height-20, self.lableView.frame.size.height-20)];
    _addressImageView.image = [UIImage imageNamed:@"katong.png"];
    [_lableView addSubview:_addressImageView];
    
    [self.backView addSubview:_lableView];
    
    //添加日记TextField
    self.storyTextField = [[UITextView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.lableView.frame)+10, self.backView.frame.size.width-20, self.backView.frame.size.height-self.backView.frame.size.height/15-10-zhuangtailan)];
    _storyTextField.font= [UIFont fontWithName:@"Arial"size:30.0];
    _storyTextField.backgroundColor = [UIColor whiteColor];
    _storyTextField.delegate = self;
    //添加随键盘变化自定义View
    self.allButtonView = [[UIView alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(self.backView.frame)-self.backView.frame.size.height/15-10-zhuangtailan, self.backView.frame.size.width-20, self.backView.frame.size.height/3)];
    _allButtonView.backgroundColor = [UIColor whiteColor];
    //添加四个button
    //添加天气button
    self.buttonWeather = [UIButton buttonWithType:UIButtonTypeSystem];
    _buttonWeather.frame = CGRectMake(0, 0, CGRectGetMaxX(self.allButtonView.frame)/4, _allButtonView.frame.size.height/5);
    [_buttonWeather addTarget:self action:@selector(didWeather) forControlEvents:UIControlEventTouchUpInside];
    [_buttonWeather setBackgroundImage:[UIImage imageNamed:@"katong.png"] forState:UIControlStateNormal];
    [_allButtonView addSubview:_buttonWeather];
    
    self.buttonAddress = [UIButton buttonWithType:UIButtonTypeSystem];
    _buttonAddress.frame = CGRectMake(_allButtonView.frame.size.width/4*1, 0, _allButtonView.frame.size.width/4, _allButtonView.frame.size.height/5);
    [_buttonAddress addTarget:self action:@selector(didAddress) forControlEvents:UIControlEventTouchUpInside];
    [_buttonAddress setBackgroundImage:[UIImage imageNamed:@"katong.png"] forState:UIControlStateNormal];
    [_allButtonView addSubview:_buttonAddress];
    
    self.buttonPicture = [UIButton buttonWithType:UIButtonTypeSystem];
    _buttonPicture.frame = CGRectMake(_allButtonView.frame.size.width/4*2, 0, _allButtonView.frame.size.width/4, _allButtonView.frame.size.height/5);
    [_buttonPicture addTarget:self action:@selector(didPicture) forControlEvents:UIControlEventTouchUpInside];
    [_buttonPicture setBackgroundImage:[UIImage imageNamed:@"katong.png"] forState:UIControlStateNormal];
    [_allButtonView addSubview:_buttonPicture];
    
    self.buttonFeel = [UIButton buttonWithType:UIButtonTypeSystem];
    _buttonFeel.frame = CGRectMake(_allButtonView.frame.size.width/4*3, 0, _allButtonView.frame.size.width/4, _allButtonView.frame.size.height/5);
    [_buttonFeel addTarget:self action:@selector(didFeel) forControlEvents:UIControlEventTouchUpInside];
    [_buttonFeel setBackgroundImage:[UIImage imageNamed:@"katong.png"] forState:UIControlStateNormal];
    [_allButtonView addSubview:_buttonFeel];
    //button详情的view
    self.buttonDetailView = [[UIView alloc]initWithFrame:CGRectMake(0, _buttonFeel.frame.size.height+10, _allButtonView.frame.size.width, _allButtonView.frame.size.height/5*4)];
    _buttonDetailView.backgroundColor = [UIColor whiteColor];
    [_allButtonView addSubview:_buttonDetailView];
    
    [self.backView addSubview:_allButtonView];
    [self.backView addSubview:_storyTextField];
    [self.view addSubview:_backView];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 点击按钮事件
#pragma mark 天气事件
-(void)didWeather{
    [self changeAllButtonView];
    UIView * buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.buttonDetailView.frame.size.width, self.buttonDetailView.frame.size.height)];
    buttonView.backgroundColor = [UIColor cyanColor];
    [_buttonDetailView addSubview: buttonView];
}
#pragma mark 位置事件
-(void)didAddress{
    [self changeAllButtonView];
    UIView * buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.buttonDetailView.frame.size.width, self.buttonDetailView.frame.size.height)];
    buttonView.backgroundColor = [UIColor greenColor];
    [_buttonDetailView addSubview: buttonView];
    
    [self.locationManager requestAlwaysAuthorization];
    _locationManager.delegate = self;
    [_locationManager startUpdatingLocation];
}
#pragma mark 图片事件
-(void)didPicture{
    [self changeAllButtonView];
    UIView * buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.buttonDetailView.frame.size.width, self.buttonDetailView.frame.size.height)];
    buttonView.backgroundColor = [UIColor redColor];

    [_buttonDetailView addSubview: buttonView];
}
#pragma mark 心情事件
-(void)didFeel{
    [self changeAllButtonView];
    UIView * buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.buttonDetailView.frame.size.width, self.buttonDetailView.frame.size.height)];
    buttonView.backgroundColor = [UIColor yellowColor];

    [_buttonDetailView addSubview: buttonView];
}
#pragma mark - 改变底部view位置
-(void)changeAllButtonView{
    self.storyTextField.frame =CGRectMake(10, CGRectGetMaxY(self.lableView.frame)+10, self.backView.frame.size.width-20, self.backView.frame.size.height-self.backView.frame.size.height/3-20-zhuangtailan);
    self.allButtonView.frame = CGRectMake(10,CGRectGetMaxY(self.storyTextField.frame)+10, self.backView.frame.size.width-20, self.backView.frame.size.height/5);
}
#pragma mark - 变回来底部View
-(void)changBackButtonView{
    self.storyTextField.frame = CGRectMake(10, CGRectGetMaxY(self.lableView.frame)+10, self.backView.frame.size.width-20, self.backView.frame.size.height-self.backView.frame.size.height/15-10-zhuangtailan);
    self.allButtonView.frame =CGRectMake(10,CGRectGetMaxY(self.backView.frame)-self.backView.frame.size.height/15-10-zhuangtailan, self.backView.frame.size.width-20, self.backView.frame.size.height/5);

}

#pragma mark - 回收键盘触发时间
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_storyTextField resignFirstResponder];
    [self changBackButtonView];
}
#pragma mark - 实现协议里的方法监听键盘
-(void)textViewDidBeginEditing:(UITextView *)textView{
    
}
-(void)textViewDidChange:(UITextView *)textView{
    
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    
}
-(void)textViewDidChangeSelection:(UITextView *)textView{
    
}
#pragma mark - 各种懒加载
-(CLLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc]init];
    }
    return _locationManager;
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
