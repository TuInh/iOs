//
//  RecommendModel.m
//  LoadSearchView
//
//  Created by AnhLTV on 6/26/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

#import "RecommendModel.h"

@implementation RecommendModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       
                                                       @"address.full":@"fullAddress"
                                                       
                                                       }];
}
@end
