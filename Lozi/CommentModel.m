//
//  CommentModel.m
//  LoadSearchView
//
//  Created by Tu Inh Le on 6/8/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"createdBy.username": @"username",
                                                       @"createdBy.avatar":@"avatar",
                                                       @"createdBy.name.short":@"shortname"
                                                       }];
}

@end
