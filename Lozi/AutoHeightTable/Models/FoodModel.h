//
//  FoodModel.h
//  AutoHeightTable
//
//  Created by AnhLTV on 5/17/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "DishModel.h"
#import "UploaderModel.h"
#import "FoodCountModel.h"


@interface FoodModel : JSONModel
@property (assign, nonatomic) float scale;
@property (strong, nonatomic) NSString* foodID;
@property (strong, nonatomic) NSString<Optional>* createdAt;
@property (strong, nonatomic) NSString<Optional>* caption;
@property (strong, nonatomic) NSString<Optional>* color;
@property (strong, nonatomic) NSString<Optional>* image;
@property (strong, nonatomic) DishModel* dish;
@property (strong, nonatomic) UploaderModel* createdBy;
@property (strong, nonatomic) FoodCountModel* foodCount;

@property (strong, nonatomic) NSArray<NSString*>* eateryCoords;
@end
