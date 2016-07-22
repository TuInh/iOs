//
//  AroundViewController.h
//  AutoHeightTable
//
//  Created by AnhLTV on 7/11/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import "AppConfig.h"
#import "AroundCollectionView.h"
#import "CategoryCollectionView.h"

@interface Top50ViewController : UIViewController<UIScrollViewDelegate>
@property(nonatomic, strong) UIScrollView* mainScrollView;


//CollectionView
@property(nonatomic, strong) UILabel* arroundLabel;
@property(nonatomic, strong) AroundCollectionView* aroundCollectionView;

@property(nonatomic, strong) UILabel* categoryLabel;
@property(nonatomic, strong) CategoryCollectionView* categoryCollectionView;



@end
