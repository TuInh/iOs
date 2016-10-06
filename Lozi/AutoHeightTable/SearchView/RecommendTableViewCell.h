//
//  RecommendTableViewCell.h
//  LoadSearchView
//
//  Created by AnhLTV on 6/24/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface RecommendTableViewCell : UITableViewCell
@property (strong,nonatomic) UIView *mainView;
@property (strong,nonatomic) UIView *subView;
@property (strong,nonatomic) UIImageView *imgBackground;
@property (strong,nonatomic) UIImageView *imgAvatar;
@property (strong,nonatomic) UILabel *lblName;
@property (strong,nonatomic) UILabel *lblAddress;
@property (strong,nonatomic) UILabel *lblRating;
@property (strong,nonatomic)UILabel *lblCost;
@property (strong,nonatomic) UILabel *lblTime;
@property (strong,nonatomic) UILabel *lblDistance;
-(void) loadDataModel :(RecommendModel*) recommendModel;
-(UIImage *)roundedImage:(UIImage *)image size:(CGSize)imageSize corlorBorder:(UIColor*) borderColor;
@end
