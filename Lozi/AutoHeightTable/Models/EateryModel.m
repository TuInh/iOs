//
//  EateryModel.m
//  AutoHeightTable
//
//  Created by AnhLTV on 5/17/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import "EateryModel.h"

@implementation EateryModel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id": @"eateryID"
                                                       }];
}
@end
