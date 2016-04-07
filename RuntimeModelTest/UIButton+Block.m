//
//  UIButton+Block.m
//  TEXT
//
//  Created by Apple on 15/9/18.
//  Copyright (c) 2015年 Zhipin. All rights reserved.
//

#import "UIButton+Block.h"
#import <objc/runtime.h>

static id key;

@implementation UIButton (Block)


- (void)initWithEvent:(UIControlEvents)event handler:(BLOCK)hanler{
    
    [self addTarget:self action:@selector(goAction:) forControlEvents:event];
    
    objc_setAssociatedObject(self, &key, hanler, OBJC_ASSOCIATION_COPY);
}

- (void)goAction:(UIButton *)sender{

    BLOCK block = (BLOCK)objc_getAssociatedObject(self, &key);
    if (block) {
        block(sender);
    }
}




@end
