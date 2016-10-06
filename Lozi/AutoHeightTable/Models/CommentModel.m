//
//  CommentModel.m
//  LoadSearchView
//
//  Created by AnhLTV on 6/8/16.
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

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    if ([propertyName isEqualToString: @"rating"]) return YES;
    return NO;
}
@end
