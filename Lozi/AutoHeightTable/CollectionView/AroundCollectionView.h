//
//  AroundCollectionView.h
//  Around
//
//  Created by AnhLTV on 6/30/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AroundCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "AroundModel.h"
@interface AroundCollectionView : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegate>

@property(strong,nonatomic) NSMutableArray *aroundDataArray;
@property(strong,nonatomic) UIScrollView *parentView;
@property(nonatomic,assign) bool isScrollable;

- (instancetype)initWithFrame:(CGRect)frame withType: (bool) isScrollable;
@end
