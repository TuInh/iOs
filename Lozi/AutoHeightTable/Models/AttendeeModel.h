//
//  AttendeeModel.h
//  AutoHeightTable
//
//  Created by AnhLTV on 7/11/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "AddressModel.h"
#import "NameModel.h"

@interface AttendeeModel : JSONModel
@property (strong,nonatomic) AddressModel *address;
@property (strong,nonatomic) NameModel *name;
@property (strong,nonatomic) NSString *avatar;
@property (strong,nonatomic) NSString *username;
@end
