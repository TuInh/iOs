
//
//  AlbumsModel.m
//  LoadSearchView
//
//  Created by AnhLTV on 5/23/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

#import "AlbumsModel.h"

@implementation AlbumsModel
+(JSONKeyMapper*) keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"createdBy.name.full":@"username",
                                                       @"description":@"_description",
                                                      @"count.block":@"block"
                                                       }];
}

@end
