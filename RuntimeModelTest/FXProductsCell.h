//
//  FXProductsCell.h
//  RuntimeModelTest
//
//  Created by beyond on 15/8/27.
//  Copyright (c) 2015年 beyond. All rights reserved.
//

#import <UIKit/UIKit.h>
// sdwebImage图片缓存库
#import "UIImageView+WebCache.h"

@interface FXProductsCell : UICollectionViewCell





@property (strong, nonatomic) IBOutlet UIImageView *productImageView;
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;
@property (strong, nonatomic) IBOutlet UIButton *shopNameButton;
@property (strong, nonatomic) IBOutlet UIImageView *shopIcon;

// 填充model上面的值到cell上
- (void)fillModelToCell:(id)model;
@end
