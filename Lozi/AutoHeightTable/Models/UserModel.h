//
//  UserModel.h
//  LoadSearchView
//
//  Created by AnhLTV on 5/26/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
@protocol UserModel
@end
@interface UserModel : JSONModel
@property (strong, nonatomic) NSString *_id;
@property(strong,nonatomic) NSString *avatar;
@property(strong,nonatomic) NSString *city;
@property(strong,nonatomic) NSString *fullname;
@property(strong,nonatomic) NSString *follower;
@property(strong,nonatomic) NSString *followingUser;
@property(strong,nonatomic) NSString *pin;
@property(strong,nonatomic) NSString *gender;
@end
