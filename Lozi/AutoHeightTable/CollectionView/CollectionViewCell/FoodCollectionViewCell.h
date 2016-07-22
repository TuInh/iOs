//
//  FoodCollectionViewCell.h
//  AutoHeightTable
//
//  Created by AnhLTV on 7/5/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodModel.h"

@interface FoodCollectionViewCell : UICollectionViewCell
@property(nonatomic, strong) NSArray<FoodModel*>* foodModelArray;
-(void) loadDataModel:(FoodModel*) foodModel;
@end
