//
//  FXNetWork.h
//  RuntimeModelTest
//
//  Created by beyond on 15/8/27.
//  Copyright (c) 2015年 beyond. All rights reserved.
//

// 请求库
// 实体层下的 —— (业务管理层）
#import "AFNetworking.h"
#import <Foundation/Foundation.h>
typedef void (^SuccessBlock)(id responsObject);
typedef void (^FailBlock)(id responsObject);
@interface FXNetWork : NSObject


/**
 *  首页请求
 *
 *  @param parmas       字典类型参数
 *  @param successBlock 成功回调
 *  @param failBlock    失败回调
 */
+ (void)networkMainRequest:(id)parmas whileSuccess:(SuccessBlock)successBlock orFail:(FailBlock)failBlock;




@end
