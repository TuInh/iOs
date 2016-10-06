//
//  FoodDetailViewController.h
//  AutoHeightTable
//
//  Created by AnhLTV on 7/15/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentTableView.h"
#import "FoodCollectionView.h"
#import "FoodLoader.h"

@class FoodCollectionView;

@interface FoodDetailViewController : UIViewController<DataLoaderDelegate>

@property(nonatomic, strong) UIScrollView* scrollViewContainer;

@property(nonatomic, strong) UIView* foodContainer;

@property(nonatomic, strong) UIImageView* foodImageView;
@property(nonatomic, strong) UILabel* foodNameLabel;
@property(nonatomic, strong) UILabel* foodPriceLabel;

@property(nonatomic, strong) UIView* countViewContainer;

@property(nonatomic, strong) UIView* pinViewContainer;
@property(nonatomic, strong) UILabel* pinLabel;
@property(nonatomic, strong) UIImageView* pinIcon;


@property(nonatomic, strong) UIView* likeViewContainer;
@property(nonatomic, strong) UILabel* likeLabel;
@property(nonatomic, strong) UIImageView* likeIcon;

@property(nonatomic, strong) UIView* commentContainer;
@property(nonatomic, strong) UILabel* commentLabel;
@property(nonatomic, strong) UIImageView* commentIcon;



@property(nonatomic, strong) UIView* shopViewContainer;
@property(nonatomic, strong) UILabel* shopNameLabel;
@property(nonatomic, strong) UILabel* shopAddressLabel;
@property(nonatomic, strong) UILabel* shopTimeLabel;
@property(nonatomic, strong) UIButton* shopButton;
@property(nonatomic, strong) UIImageView* shopTimeIcon;

@property(nonatomic, strong) UIView* captionViewContainer;
@property(nonatomic, strong) UIImageView* captionAvartImage;
@property(nonatomic, strong) UILabel* captionUserLabel;
@property(nonatomic, strong) UILabel* captionPlaceLabel;
@property(nonatomic, strong) UILabel* captionMessageLabel;
@property(nonatomic, strong) UILabel* captionTimeLabel;

@property(nonatomic, strong) CommentTableView* commentTableView;

@property(nonatomic, strong) UILabel* albumLabel;
@property(nonatomic, strong) UIView* abumViewContainer;

@property(nonatomic, strong) UILabel* relatedLabel;
@property(nonatomic, strong) FoodCollectionView* relateCollectionView;

@property(nonatomic, strong) FoodModel* foodModel;

@property(nonatomic, strong) FoodLoader* foodLoader;
@property(nonatomic, strong) CommentLoader* commentLoader;

-(void) setFoodModel:(FoodModel*) foodModel;
-(instancetype) initWithFrame:(CGRect) frame;
@end
