//
//  ReadFlowLayout.m
//  GoodNight
//
//  Created by lanou3g on 15/8/20.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ReadFlowLayout.h"

@interface ReadFlowLayout ()

//item的数量
@property (nonatomic, assign) NSUInteger numberOfItems;

//保存每一列的高度
@property (nonatomic, strong) NSMutableArray *columnHeights;

//item的属性数组
@property (nonatomic, strong) NSMutableArray *itemAttributrs;

//最长列索引
- (NSInteger)p_indexForLongestColumn;

//最短列索引
- (NSInteger)p_indexForShortestColumn;


@end

@implementation ReadFlowLayout

- (NSMutableArray *)columnHeights {
    if (!_columnHeights) {
        self.columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}

- (NSMutableArray *)itemAttributrs {
    if (!_itemAttributrs) {
        self.itemAttributrs = [NSMutableArray array];
    }
    return _itemAttributrs;
}

//获取最长列索引
- (NSInteger)p_indexForLongestColumn {
    
    NSInteger longestIndex = 0;
    CGFloat longestH = 0;
    
    for (int i = 0; i < self.numberOfColums; i++) {
        CGFloat currentH = [self.columnHeights[i] floatValue];
        if (currentH > longestH) {
            longestH = currentH;
            longestIndex = i;
        }
    }
    return longestIndex;
}

//获取最短列索引
- (NSInteger)p_indexForShortestColumn {
    NSInteger shortestIndex = 0;
    CGFloat shortestH = MAXFLOAT;
    for (int i = 0; i < self.numberOfColums; i++) {
        CGFloat currentH = [self.columnHeights[i] floatValue];
        
        if (currentH < shortestH) {
            shortestH = currentH;
            shortestIndex = i;
        }
    }
    return shortestIndex;
}

//准备布局
- (void)prepareLayout {
    
    [super prepareLayout];
    
    for (int i = 0; i < self.numberOfColums; i++) {
        self.columnHeights[i] = @(self.sectionInsets.top);
    }
    
    //获取item的数量
    self.numberOfItems = [self.collectionView numberOfItemsInSection:0];
    
    //为每一个item设置frame 和 indexPath
    for (int i = 0; i < self.numberOfItems; i++) {
        
        NSInteger shortestIndex = [self p_indexForShortestColumn];
        
        CGFloat shortestH = [self.columnHeights[shortestIndex] floatValue];
        
        //计算Y
        CGFloat detalY = shortestH + self.insertItemSpacing;
        
        //计算detalX
        CGFloat detalX = self.sectionInsets.left + (self.itemSize.width + self.insertItemSpacing) * shortestIndex;
        
        //生成indexPath
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        CGFloat itemH = 0;
        
        if (_delegate && [_delegate respondsToSelector:@selector(heightForItemIndexPath:)]) {
            itemH = [_delegate heightForItemIndexPath:indexPath];
        }
        
        //生成属性对象
        UICollectionViewLayoutAttributes *layoutAttr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        //设置frame
        layoutAttr.frame = CGRectMake(detalX, detalY, self.itemSize.width, itemH);
        
        [self.itemAttributrs addObject:layoutAttr];
        
        //更新高度
        self.columnHeights[shortestIndex] = @(detalY + itemH);
    }
    
}

- (CGSize)collectionViewContentSize {
    
    //最长列索引
    NSInteger longestIndex = [self p_indexForLongestColumn];
    //获取最长高度
    CGFloat longestH = [self.columnHeights[longestIndex] floatValue];
    
    CGSize contentSize = self.collectionView.frame.size;
    
    //更改高度
    contentSize.height = longestH + self.sectionInsets.bottom;
    
    return contentSize;
    
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.itemAttributrs;
}


@end
