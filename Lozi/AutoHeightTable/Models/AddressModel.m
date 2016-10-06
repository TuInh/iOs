//
//  AddressModel.m
//  AutoHeightTable
//
//  Created by AnhLTV on 5/16/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import "AddressModel.h"

@implementation AddressModel
    +(JSONKeyMapper*)keyMapper
    {
        return [[JSONKeyMapper alloc] initWithDictionary:@{
            @"short": @"short_address"
        }];
    }
@end
