//
//  FoodModel.m
//  AutoHeightTable
//
//  Created by AnhLTV on 5/17/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import "FoodModel.h"

@implementation FoodModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
        @"aspectRatio.block": @"scale",
        @"color.block": @"color",
        @"count": @"foodCount",
        @"_id": @"foodID"
    }];
}
@end
