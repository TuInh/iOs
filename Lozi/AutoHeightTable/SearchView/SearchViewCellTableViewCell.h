//
//  SearchViewCellTableViewCell.h
//  LoadSearchView
//
//  Created by AnhLTV on 5/26/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodSearchModel.h"
@interface SearchViewCellTableViewCell : UITableViewCell
@property (strong,nonatomic) UIImageView *imgView;
@property (strong,nonatomic) UILabel *foodName;
@property (strong,nonatomic) UILabel *foodDescription;

@end
