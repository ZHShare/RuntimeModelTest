//
//  FXParentModel.m
//  RuntimeModelTest
//
//  Created by beyond on 15/8/27.
//  Copyright (c) 2015年 beyond. All rights reserved.
//

#import "FXParentModel.h"
@implementation FXParentModel
/*
 1.不能有系统关键字，有的话需要做修改
 2.需要对NSNumber做判断转化成NSString
 3.如果后台多给你些参数，要重写setValueForUndefineKey
 */
- (void)setValue:(id)value forKey:(NSString *)key
{
    // 父类完成转换成NSNumber工作
    if ([value isKindOfClass:[NSNumber class]]) {
        
        value = [NSString stringWithFormat:@"%@",value];
       
    }
    // 父类完成NSNull转换
    if ([value isKindOfClass:[NSNull class]]) {
        
        value = @"";
    }
    // 父类完成id字段转换
    if ([key isEqualToString:@"id"]) {
        
        [self setValue:value forKey:@"sid"];
        
    }
    
    [super setValue:value forKey:key];
}

// 后台多加字段调用方法
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    // NSStringFromClass获取自己类的名字
    NSLog(@"%@类没有定义%@属性",NSStringFromClass([self class]),key);
}






// 归档、、解档
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self == [super init]) {
        
        
        unsigned int count      = 0;
        Ivar *ivars             = class_copyIvarList([self class], &count);
        
        for (int i = 0; i < count; i++) {
            
            // 取出i位置对应的成员变量
            Ivar ivar           = ivars[i];
            
            // 查看成员变量
            const char *name    = ivar_getName(ivar);
            
            // 归档
            NSString   *key     = [NSString stringWithUTF8String:name];
            id          value   = [aDecoder decodeObjectForKey:key];
            
            // 设置成员变量
            [self setValue:value forKey:key];
            
            
        }
        
        // 释放内存
        free(ivars);
        
    }
    return self;
    
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    unsigned int count          = 0;
    Ivar *ivars                 = class_copyIvarList([self class], &count);
    
    for (int i = 0 ; i < count; i++) {
        
        
        Ivar ivar               = ivars[i];
        const char *name        = ivar_getName(ivar);
        
        NSString *key           = [NSString stringWithUTF8String:name];
        id      value           = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
        
        
    }
    
    free(ivars);
    
    
}




@end
