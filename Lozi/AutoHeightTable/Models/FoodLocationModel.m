//
//  FoodLocationModel.m
//  LoadSearchView
//
//  Created by AnhLTV on 6/6/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

#import "FoodLocationModel.h"

@implementation FoodLocationModel
+(JSONKeyMapper*) keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"count.comment":@"comment",
                                                       @"count.visit":@"visit",
                                                       @"count.block":@"block",
                                                       @"address.full":@"fulladdress",
                                                       
                                                       }];
}

@end
