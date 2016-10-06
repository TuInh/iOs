//
//  DishModel.h
//  AutoHeightTable
//
//  Created by AnhLTV on 5/17/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "EateryModel.h"

@interface DishModel : JSONModel
@property (strong, nonatomic) NSString<Optional>* foodName;
@property (assign, nonatomic) float priceFloat;
@property (strong, nonatomic) EateryModel* eatery;
@end