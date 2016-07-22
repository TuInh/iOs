//
//  UploaderInfoModel.m
//  AutoHeightTable
//
//  Created by AnhLTV on 5/16/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import "UploaderModel.h"

@implementation UploaderModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
        @"count": @"uploaderCount"
        }];
}
@end
