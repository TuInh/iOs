//
//  FoodCollectionViewCellBig.h
//  AutoHeightTable
//
//  Created by AnhLTV on 5/25/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "CustomLabel.h"
#import "FoodModel.h"
#import "FoodCollectionViewCell.h"
#import "FoodDetailViewPager.h"

@interface FoodCollectionViewCellBig : FoodCollectionViewCell
@property (strong, nonatomic) UIImageView *foodImageView;
@property (strong, nonatomic) CustomLabel *foodNameLabel;
@property (strong, nonatomic) CustomLabel *foodAddressLabel;

//View for food count
@property (strong, nonatomic) CustomLabel *countLabel;

//View for uploader
@property (strong, nonatomic) UIImageView *avatarImageView;
@property (strong, nonatomic) CustomLabel *nickNameLabel;
@property (strong, nonatomic) CustomLabel *shortNameLabel;

@property (strong, nonatomic) FoodModel* dataModel;


-(void) refreshLayout;
-(void) setupView;
@end
