//
//  FXModelManager.m
//  RuntimeModelTest
//
//  Created by beyond on 15/8/27.
//  Copyright (c) 2015年 beyond. All rights reserved.
//

#import "FXModelManager.h"


@implementation FXModelManager

+ (id)modelClassWith:(NSString *)str
       keysAndValues:(NSDictionary *)dic{
    
    
    // creat class
    const char *charClassName = [str UTF8String];
    Class class = NSClassFromString(@"FXParentModel");
    Class modelClass = objc_allocateClassPair([class class], charClassName, 0);
    
    // add Ivar 创建模型属性
    for (NSString *key in [dic allKeys]) {
        class_addIvar(modelClass, [key UTF8String], sizeof([NSString class]), log2(sizeof([NSString class])), "@");
    }
    
    // register class 注册类
    if (NSStringFromClass([modelClass class])) {
        objc_registerClassPair(modelClass);
    }
    
    //  instantiate 实例化一个模型
    id model = [[NSClassFromString(str) alloc]init];
    
    // set class key and value from modelDic 给模型赋值
    for (NSString *key in [dic allKeys]) {
        [model setValue:dic[key] forKey:key];
    }
    
    return model;
}

void dayinName(id model){
    NSLog(@"dayinName方法\n %s",class_getName([model class]));
}
#pragma mark - ================ 归档 解档
+ (BOOL)archiveRootObject:(NSArray *)arr
                    toKey:(NSString *)key{
    
    return [self archiveRootObject:nil
                                  :arr
                             toKey:key];
}
+ (BOOL)archiveRootObject:(id)obj
                         :(NSArray *)arr
                    toKey:(NSString *)key{
    
    
    NSString *filePath = [self getFilePath:key];
   
    BOOL bol = '\0';
    if (obj) {
        bol = [NSKeyedArchiver archiveRootObject:obj
                                          toFile:filePath];
    }
    
    if (arr) {
        bol = [NSKeyedArchiver archiveRootObject:arr
                                          toFile:filePath];
    }
    
    return bol;
}
+ (BOOL)archiveObject:(id)arr
                toKey:(NSString *)key{
    
    return [self archiveRootObject:arr
                                  :nil
                             toKey:key];
}

+ (id)unarchiveObjectWithKey:(NSString *)key{
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self getFilePath:key]];
    
}
#pragma mark - ========= 对象移除
+ (BOOL)removeObjectWithKey:(NSString *)key{
    
    return [[NSFileManager defaultManager]removeItemAtPath:[self getFilePath:key] error:nil];
    
}
#pragma mark - ========= 获取路径
+ (NSString *)getFilePath:(NSString *)key{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *filePath = [docDir stringByAppendingPathComponent:key];
    return filePath;
}


#pragma mark - ========= 保存字典
+ (void)saveModelDic:(NSDictionary *)dic
              forKey:(NSString *)key{
    
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:key];
}

+ (void)modelClassFromLocalDictionaryWithKey:(NSString *)key{
    
    NSDictionary *dic   = [[NSUserDefaults standardUserDefaults]objectForKey:key];
    [self modelClassWith:key keysAndValues:dic];
}
+ (BOOL)isPossesFromKey:(NSString *)key{
    NSString *dic = [[NSUserDefaults standardUserDefaults]objectForKey:key];
    if (dic) {
        return YES;
    }
    return NO;
}

@end
