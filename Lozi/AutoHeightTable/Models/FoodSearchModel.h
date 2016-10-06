//
//  FoodSearchModel.h
//  LoadSearchView
//
//  Created by AnhLTV on 5/23/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
#import "AlbumsModel.h"
#import "FoodModel.h"
#import "EateryModel.h"
#import "UserModel.h"



@interface FoodSearchModel : JSONModel
@property (strong,nonatomic) NSArray<AlbumsModel> *albums;
@property(strong,nonatomic) NSArray<FoodModel *> *foods;
@property(strong,nonatomic) NSArray<EateryModel> *eateries;
@property(strong,nonatomic) NSArray<UserModel> *users;
@end
