//
//  DiaryTableViewCell.m
//  GoodNight
//
//  Created by lanou3g on 15/8/20.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "DiaryTableViewCell.h"
@interface DiaryTableViewCell()
@property (strong, nonatomic) IBOutlet UILabel *yearMouthTime;
@property (strong, nonatomic) IBOutlet UILabel *weekName;
@property (strong, nonatomic) IBOutlet UIImageView *weatherImage;
@property (strong, nonatomic) IBOutlet UIImageView *feelImage;
@property (strong, nonatomic) IBOutlet UIImageView *addressImage;
@property (strong, nonatomic) IBOutlet UIImageView *pictureImage;
@property (strong, nonatomic) IBOutlet UILabel *storyLable;

@end
@implementation DiaryTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
