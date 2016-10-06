//
//  CategoryModel.m
//  AutoHeightTable
//
//  Created by AnhLTV on 7/11/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import "CategoryModel.h"

@implementation CategoryModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       
                                                       @"description":@"mota"
                                                       
                                                       }];
}

@end
