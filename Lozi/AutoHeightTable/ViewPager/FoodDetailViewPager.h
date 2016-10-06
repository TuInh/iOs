//
//  FoodDetailViewPager.h
//  AutoHeightTable
//
//  Created by AnhLTV on 7/19/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPageViewControllerWithOverlayIndicator.h"
#import "FoodDetailViewController.h"
#import "UISearchBar+Extend.h"

@interface FoodDetailViewPager : UIViewController <UIPageViewControllerDataSource, UISearchBarDelegate>

@property (strong, nonatomic) UIView *searchViewContainer;
@property (strong, nonatomic) UIButton *backButton;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) UIButton *actionButton;

@property (strong, nonatomic) UIPageViewControllerWithOverlayIndicator *pageController;
@property (strong, nonatomic) NSArray<FoodModel*>* foodModelArray;
@property (strong, nonatomic) FoodModel* firstFoodModel;
@end
