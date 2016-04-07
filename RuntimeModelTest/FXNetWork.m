//
//  FXNetWork.m
//  RuntimeModelTest
//
//  Created by beyond on 15/8/27.
//  Copyright (c) 2015年 beyond. All rights reserved.
//

#import "FXNetWork.h"
#import "FXModelManager.h"

#define KHostURL @"http://app.api.repaiapp.com"
#define FXMainPageURL KHostURL@"/sx/yangshijie/1406aitao/show.php"

@implementation FXNetWork


#pragma mark - 首页请求
+ (void)networkMainRequest:(id)parmas whileSuccess:(SuccessBlock)successBlock orFail:(FailBlock)failBlock
{
    //网络请求管理类
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //    默认http请求传递格式：name=zdd&id=1001&age=12
    //    json传递格式：{"name":"zdd","id":"100","age":"12"}
    
    // 请求格式化(默认http请求，json数据请求)
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    // 响应格式化（默认data类型，json数据类型）
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:FXMainPageURL parameters:parmas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 创建一个数据类型是数组的类型返回
        NSMutableArray *mainPageModelArr = [NSMutableArray array];
        
        // 通过data解析成字典格式
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:1 error:nil];
        
        // 遍历dataDic下的data，获取data下的字典类型kvc为mainPageDataModel赋值
        
        for (NSDictionary *modelDic in dataDic[@"data"]) {
            
            id mainPageDataModel = [FXModelManager modelClassWith:@"MainPageDataModel"
                                                    keysAndValues:modelDic];
            
            [mainPageModelArr addObject:mainPageDataModel];
            
        }
        
        if ([dataDic[@"data"] count ] > 0) {
            [FXModelManager saveModelDic:dataDic[@"data"][0] forKey:@"MainPageDataModel"];
        }
        
        
        // 只要成功，数组封装成数组传递到控制器上
        successBlock(mainPageModelArr);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 失败，把错误信息传递到控制器上
        failBlock(error);
    }];
}

@end
