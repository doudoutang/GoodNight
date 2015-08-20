//
//  ReadFlowLayout.h
//  GoodNight
//
//  Created by lanou3g on 15/8/20.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReadFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) CGSize itemSize;

@property (nonatomic, assign) UIEdgeInsets sectionInsets;

@property (nonatomic, assign) CGFloat insertItemSpacing;

@property (nonatomic, assign) NSUInteger numberOfColums;

@end
