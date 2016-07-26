//
//  AroundCollectionView.h
//  Around
//
//  Created by AnhLTV on 6/30/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface CategoryCollectionView : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegate>
@property(strong,nonatomic) NSMutableArray *categoryDataArray;
@property(strong,nonatomic) UIScrollView *parentView;
@property(strong,nonatomic) UIViewController *parentViewController;
@end
