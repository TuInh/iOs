//
//  CollectionViewCell.h
//  Around
//
//  Created by AnhLTV on 6/29/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryModel.h"

@interface CategoryCollectionViewCell : UICollectionViewCell
@property (strong,nonatomic) UIImageView *avatar;
@property(strong,nonatomic) UILabel *type;
-(void)setupView;
-(void) setModelData:(CategoryModel*) dataModel;
@end
