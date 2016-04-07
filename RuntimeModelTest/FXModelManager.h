//
//  FXModelManager.h
//  RuntimeModelTest
//
//  Created by beyond on 15/8/27.
//  Copyright (c) 2015年 beyond. All rights reserved.
//

#import "FXParentModel.h"

@interface FXModelManager : FXParentModel


/**
 *  字典转模型
 *
 *  @param str 自定义类名
 *  @param dic 字典
 *
 *  @return 模型类
 */
+ (id)modelClassWith:(NSString *)str
       keysAndValues:(NSDictionary *)dic;

/**
 *  对象归档
 *
 *  @param obj 归档对象
 *  @param key 归档key
 *
 *  @return YES/NO
 */
+ (BOOL)archiveObject:(id)obj
                toKey:(NSString *)key;

/**
 *  对象解档
 *
 *  @param key 对应key
 *
 *  @return 对象
 */
+ (id)unarchiveObjectWithKey:(NSString *)key;

// 移除key对应的对象
+ (BOOL)removeObjectWithKey:(NSString *)key;


/**
 *  保存一个字典
 *
 *  @param dic 字典
 *  @param key key
 */
+ (void)saveModelDic:(NSDictionary *)dic
              forKey:(NSString *)key;

// 从key取出字典并实例注册一个类
+ (void)modelClassFromLocalDictionaryWithKey:(NSString *)key;

// 判断key有没有保存对象
+ (BOOL)isPossesFromKey:(NSString *)key;

@end
