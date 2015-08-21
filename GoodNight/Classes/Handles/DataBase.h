//
//  DataBase.h
//  GoodNight
//
//  Created by lanou3g on 15/8/20.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataBase : NSObject

/**
 *  创建单例
 *
 *  @return 返回一个单例对象
 */
+ (id)shareInstance;

/**
 *  通过网址解析阅读数据
 *
 *  @param urlStr 阅读网址
 */
- (void)getReadDataWithUrl:(NSString *)urlStr result:(void(^)(id result))resultion;

@end
