//
//  MenuModel.m
//  LoadSearchView
//
//  Created by AnhLTV on 7/19/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

#import "MenuModel.h"

@implementation MenuModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"dish.foodName": @"foodName",
                                                       @"dish.price":@"price"
                                                      
                                                       }];
}
@end
