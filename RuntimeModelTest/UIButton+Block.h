//
//  UIButton+Block.h
//  TEXT
//
//  Created by Apple on 15/9/18.
//  Copyright (c) 2015年 Zhipin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BLOCK) (UIButton *sender);


@interface UIButton (Block)

- (void)initWithEvent:(UIControlEvents)event handler:(BLOCK)hanler;


@end
