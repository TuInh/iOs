//
//  UploaderStatisticModel.h
//  AutoHeightTable
//
//  Created by AnhLTV on 5/16/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface UploaderCountModel : JSONModel
@property (assign, nonatomic) int album;
@property (assign, nonatomic) int follower;
@property (assign, nonatomic) int followingAlbum;
@property (assign, nonatomic) int followingUser;
@property (assign, nonatomic) int photo;
@property (assign, nonatomic) int pin;
@end
