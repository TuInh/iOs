//
//  UserModel.m
//  LoadSearchView
//
//  Created by AnhLTV on 5/26/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

+(JSONKeyMapper*) keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"name.full":@"fullname"
                                                       ,@"profile.gender":@"gender"
                                                       ,@"count.follower":@"follower"
                                                       ,@"count.followingUser":@"followingUser"
                                                       ,@"count.pin":@"pin"
                                                       }];
}
@end
