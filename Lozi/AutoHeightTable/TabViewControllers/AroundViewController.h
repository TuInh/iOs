//
//  AroundViewController.h
//  AutoHeightTable
//
//  Created by AnhLTV on 7/11/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import "AppConfig.h"
#import "AroundCollectionView.h"

@interface AroundViewController : UIViewController<UIScrollViewDelegate>
@property(nonatomic, strong) UIScrollView* mainScrollView;

//Header
@property(nonatomic, strong) UIView* headerView;
@property(nonatomic, strong) UILabel* headerTitleLabel;
@property(nonatomic, strong) UILabel* headerDescriptionLabel;
@property(nonatomic, strong) UIImageView* headerImage;
@property(nonatomic, strong) UIButton* headerButton;

//CollectionView
@property(nonatomic, strong) AroundCollectionView* aroundCollectionView;


@end
