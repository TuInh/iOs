//
//  EventModel.m
//  AutoHeightTable
//
//  Created by AnhLTV on 7/11/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import "EventModel.h"

@implementation EventModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"count.attended" : @"numberOfAttendee",
                                                       @"objects.contest.coverMobile":@"coverMobile",
                                                       @"objects.contest.createdAt":@"createdAt",
                                                       @"objects.contest.startTime":@"startTime",
                                                       @"objects.contest.endTime":@"endTime",
                                                       @"objects.contest.description":@"mota"
                                                       
                                                       }];
}
@end
