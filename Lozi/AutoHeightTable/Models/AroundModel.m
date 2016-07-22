//
//  AroundModel.m
//  Around
//
//  Created by AnhLTV on 6/29/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

#import "AroundModel.h"

@implementation AroundModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       
                                                       @"id":@"idAround"
                                                       
                                                       }];
}
@end
