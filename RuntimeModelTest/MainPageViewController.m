//
//  MainPageViewController.m
//  RuntimeModelTest
//
//  Created by beyond on 15/8/27.
//  Copyright (c) 2015年 beyond. All rights reserved.
//
// 自定义宏命令
#define H_valueForKey(class,key) [class valueForKey:key]
#define H_URLWithStrin(s) [NSURL URLWithString:s]
#import "MainPageViewController.h"
#import "FXModelManager.h"

// views
#import "FXProductsCell.h"
#import "MainPageView.h"
#import "AppDelegate.h"
#import "UIButton+Block.h"

#import <objc/runtime.h>
#define IphoneWidth [UIScreen mainScreen].bounds.size.width

@interface MainPageViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    MainPageView *_mainPageView;
}
@end

@implementation MainPageViewController
{
    NSMutableArray *_mainPageModelArr; // 首页数据
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNavigationBar];
    
    
    _mainPageModelArr = [NSMutableArray new];
    // 创建视图
    [self creatView];
    
    // 实例
    if ([FXModelManager isPossesFromKey:@"MainPageDataModel"]) {
        [FXModelManager modelClassFromLocalDictionaryWithKey:@"MainPageDataModel"];
        // 解档
        [_mainPageModelArr addObjectsFromArray:[FXModelManager unarchiveObjectWithKey:@"MainPageDataModel"]];
        [_mainPageView.mainPageCollectionView reloadData];
        

    }
  
}

- (void)addNavigationBar{
    
    UIBarButtonItem *pushBarButton = [[UIBarButtonItem alloc] initWithTitle:@"清除" style:UIBarButtonItemStylePlain target:self action:@selector(push:)];
    self.navigationItem.leftBarButtonItem = pushBarButton;
    
    
    UIBarButtonItem *refreshBarButton = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(refresh)];
    self.navigationItem.rightBarButtonItem = refreshBarButton;
}

- (void)refresh{
    [self getMainPageRequest];
}
- (void)push:(id)obj{
    
    // 清除
    [FXModelManager removeObjectWithKey:@"MainPageDataModel"];
    [_mainPageModelArr removeAllObjects];
    [_mainPageView.mainPageCollectionView reloadData];
    

}

#pragma mark - ================ 视图创建方法 ==========
- (void)creatView
{
    
    // 整个大view = self.view
    _mainPageView = [[MainPageView alloc]initWithFrame:self.view.bounds];
    _mainPageView.mainPageCollectionView.delegate = self;
    _mainPageView.mainPageCollectionView.dataSource = self;
    self.view = _mainPageView;
}


// 首页请求
- (void)getMainPageRequest
{
    // 把请求格式分开到netWork处理，返回需要的数据类型
    [FXNetWork networkMainRequest:@{@"type":@"0",@"page":@"1"} whileSuccess:^(id responsObject) {
        
        // 数据赋值到全局数组内
        _mainPageModelArr = responsObject;
    
        // 归档
        [FXModelManager archiveObject:responsObject toKey:@"MainPageDataModel"];
        
        [_mainPageView. mainPageCollectionView reloadData];
        
    } orFail:^(id responsObject) {
        ;
    }];
    
    
    
}


#pragma mark - ================= 协议代理方法 =========
#pragma mark UICollectionView

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 使用注册过的cell
    static NSString *cellString = @"productCell";
    FXProductsCell *productCell = [collectionView dequeueReusableCellWithReuseIdentifier:cellString forIndexPath:indexPath];
    [productCell fillModelToCell:[_mainPageModelArr objectAtIndex:indexPath.row]];
    return productCell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    // item的数目为数组数目
    return [_mainPageModelArr count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(IphoneWidth / 2.0 -10, 300);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    return CGSizeMake(IphoneWidth, 20.0f);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",_mainPageModelArr[indexPath.row]);
    
    UIImageView *img = [[UIImageView alloc]init];
    [img sd_setImageWithURL:H_valueForKey(_mainPageModelArr[indexPath.row], @"zs_pic")];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:img.image forState:UIControlStateNormal];
    [button setBackgroundImage:img.image forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(dismissACTION:) forControlEvents:UIControlEventTouchUpInside];
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [button setBackgroundColor:[UIColor whiteColor]];
    [button setFrame:app.window.bounds];
    button.alpha = 0;
    [UIView animateWithDuration:0.3f animations:^{
        [button setAlpha:1];
    }];
    [app.window addSubview:button];
    
}
- (void)dismissACTION:(UIButton *)btn{
    [UIView animateWithDuration:0.2f animations:^{
        btn.alpha = 0;
    }completion:^(BOOL finished) {
        [btn removeFromSuperview];
    }];
}


@end
