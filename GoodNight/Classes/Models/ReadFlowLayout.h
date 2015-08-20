//
//  ReadFlowLayout.h
//  GoodNight
//
//  Created by lanou3g on 15/8/20.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ReadFlowLayoutDelegate <NSObject>

//获取每一个item的高度
- (CGFloat)heightForItemIndexPath:(NSIndexPath *)indexPath;

@end

@interface ReadFlowLayout : UICollectionViewFlowLayout

//item大小
@property (nonatomic, assign) CGSize itemSize;

//内边距
@property (nonatomic, assign) UIEdgeInsets sectionInsets;

//间隙
@property (nonatomic, assign) CGFloat insertItemSpacing;

//列数
@property (nonatomic, assign) NSUInteger numberOfColums;

@property (nonatomic, weak) id<ReadFlowLayoutDelegate>delegate;

@end
