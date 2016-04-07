//
//  FXProductsCell.m
//  RuntimeModelTest
//
//  Created by beyond on 15/8/27.
//  Copyright (c) 2015年 beyond. All rights reserved.
//

#import "FXProductsCell.h"
#import <objc/runtime.h>

// 自定义宏命令
#define H_valueForKey(class,key) [class valueForKey:key]
#define H_URLWithStrin(s) [NSURL URLWithString:s]



#define H_(class,key) [class valueForKey:key]

#define NS_StringWithFormat(s,t) [NSString stringWithFormat:s,t]

@implementation FXProductsCell

- (void)awakeFromNib {
    // Initialization code
}


// 填充model上面的值到cell上
- (void)fillModelToCell:(id)model
{

    // 产品图片
    [self.productImageView sd_setImageWithURL:H_valueForKey(model, @"zs_pic")];
    // 产品详情
    [self.detailLabel setText:H_valueForKey(model, @"describe")];
    // 店家按钮
    [self.shopNameButton setTitle:H_valueForKey(model, @"itemPicList") forState:UIControlStateNormal];
    // 店家头像
    [self.shopIcon sd_setImageWithURL:H_URLWithStrin(H_valueForKey(model, @"avatar_pic"))];
    
}


@end
