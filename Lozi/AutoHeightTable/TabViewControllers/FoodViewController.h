//
//  FoodViewController.h
//  AutoHeightTable
//
//  Created by AnhLTV on 6/11/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import "AppConfig.h"
#import "BannerPagerController.h"
#import "FoodCollectionViewLayout.h"
#import "FoodCollectionView.h"
#import "CustomComboBox.h"


@interface FoodViewController : UIViewController<UIScrollViewDelegate, CustomDropDownListDelegate>
@property(nonatomic, strong) UIScrollView* mainScrollView;

@property(nonatomic, strong) BannerPagerController* bannerViewControler;

@property(nonatomic, strong) UIView* menuView;
@property(nonatomic, strong) UIButton* comboTextField;
@property(nonatomic, strong) UILabel* viewTypeLabel;
@property(nonatomic, strong) UIButton* viewButton1;
@property(nonatomic, strong) UIButton* viewButton2;

@property(nonatomic, strong) UIView* descriptionView;
@property(nonatomic, strong) CustomLabel* descriptionLable1;
@property(nonatomic, strong) CustomLabel* descriptionLable2;
@property(nonatomic, strong) CustomLabel* descriptionLable3;

@property(nonatomic, strong) NSMutableDictionary* urlDictionary;

@property(nonatomic, strong) FoodCollectionView* foodCollectionView;

@end

