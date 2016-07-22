//
//  NameModel.m
//  AutoHeightTable
//
//  Created by AnhLTV on 5/24/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import "NameModel.h"

@implementation NameModel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"short": @"short_name"
                                                       }];
}

@end
