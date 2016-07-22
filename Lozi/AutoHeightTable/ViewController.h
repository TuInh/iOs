//
//  ViewController.h
//  AutoHeightTable
//
//  Created by AnhLTV on 5/8/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodCollectionViewLayout.h"
#import "CustomLabel.h"
#import "FoodCollectionView.h"
#import "DataLoader/FoodLoader.h"
#import "FoodViewController.h"
#import "CarbonKit.h"
#import "AroundViewController.h"
#import "FoodViewController.h"
#import "ShopViewController.h"
#import "ShipViewController.h"
#import "OtherViewController.h"
#import "Top50ViewController.h"
#import "EventViewController.h"
#import "UISearchBar+Extend.h"
#import "SearchViewController.h"



@interface ViewController : UIViewController<CarbonTabSwipeNavigationDelegate, UISearchBarDelegate>
@property(strong, nonatomic) NSArray *items;

@property(strong, nonatomic) UIView *searchContainer;
@property(strong, nonatomic) UISearchBar *searchBar;
@property(nonatomic, strong) UIButton* comboTextField;

@property(strong, nonatomic) UIViewController *swipeTabContainer;
@property(strong, nonatomic) CarbonTabSwipeNavigation *carbonTabSwipeNavigation;
@property(strong, nonatomic) AroundViewController *aroundViewController;
@property(strong, nonatomic) FoodViewController *foodViewController;
@property(strong, nonatomic) ShopViewController *shopViewController;
@property(strong, nonatomic) ShipViewController *shipViewController;
@property(strong, nonatomic) OtherViewController *otherViewController;
@property(strong, nonatomic) Top50ViewController *top50ViewController;
@property(strong, nonatomic) EventViewController *eventViewController;



@end

