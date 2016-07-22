//
//  FoodCollectionViewCell.h
//  AutoHeightTable
//
//  Created by AnhLTV on 5/8/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "CustomLabel.h"
#import "FoodModel.h"
#import "FoodCollectionViewCell.h"
#import "FoodDetailViewPager.h"




@interface FoodCollectionViewCellSmall : FoodCollectionViewCell

@property (strong, nonatomic) UIImageView *foodImageView;
@property (strong, nonatomic) CustomLabel *foodNameLabel;
@property (strong, nonatomic) CustomLabel *foodAddressLabel;

//View for food count
@property (strong, nonatomic) UIImageView *pinImageView;
@property (strong, nonatomic) CustomLabel *pinLabel;
@property (strong, nonatomic) UIImageView *likeImageView;
@property (strong, nonatomic) CustomLabel *likeLabel;
@property (strong, nonatomic) UIImageView *commentImageView;
@property (strong, nonatomic) CustomLabel *commentLabel;

//View for uploader
@property (strong, nonatomic) UIImageView *avatarImageView;
@property (strong, nonatomic) CustomLabel *nickNameLabel;
@property (strong, nonatomic) CustomLabel *descriptionLabel;
@property (strong, nonatomic) UIView *borderView;

@property (strong, nonatomic) FoodModel* dataModel;

-(void) refreshLayout;
-(void) setupView;

@end
