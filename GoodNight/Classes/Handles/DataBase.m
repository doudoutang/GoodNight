//
//  DataBase.m
//  GoodNight
//
//  Created by lanou3g on 15/8/20.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "DataBase.h"
#import "AFNetworking.h"
@implementation DataBase

#pragma mark - 创建单例
+ (id)shareInstance {
    
    static DataBase *dataBase = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataBase = [[DataBase alloc] init];
    });
    return dataBase;
}

#pragma mark - 通过网址解析阅读数据
- (void)getReadDataWithUrl:(NSString *)urlStr result:(void(^)(id result))resultion {
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    
    NSString *url = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        resultion(result);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"function == %s  line == %d  error == %@",__FUNCTION__,__LINE__,error);

    }];
    
}

@end
