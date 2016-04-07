//
//  MainPageView.m
//  RuntimeModelTest
//
//  Created by beyond on 15/8/27.
//  Copyright (c) 2015年 beyond. All rights reserved.
//

#import "MainPageView.h"

@implementation MainPageView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:(CGRect)frame];
    if (self) {
        [self creatView];
    }
    return self;
}

- (void)creatView
{
    // CollectionView布局
    UICollectionViewFlowLayout *mainPageCollectionViewLayout = [[UICollectionViewFlowLayout alloc]init];
    mainPageCollectionViewLayout.minimumLineSpacing = 10;
    //    mainPageCollectionViewLayout.minimumInteritemSpacing = 10;
    // 首页CollectionView
    _mainPageCollectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:mainPageCollectionViewLayout];
    _mainPageCollectionView.backgroundColor = [UIColor orangeColor];
   
    
    // 注册cell
    [_mainPageCollectionView registerNib:[UINib nibWithNibName:@"FXProductsCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"productCell"];
   
    
    [self addSubview:_mainPageCollectionView];
}




@end
