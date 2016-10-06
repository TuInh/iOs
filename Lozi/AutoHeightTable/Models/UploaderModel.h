//
//  UploaderInfoModel.h
//  AutoHeightTable
//
//  Created by AnhLTV on 5/16/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "AddressModel.h"
#import "UploaderCountModel.h"
#import "UploaderProfileModel.h"
#import "NameModel.h"

@interface UploaderModel : JSONModel
@property (strong, nonatomic) AddressModel* address;
@property (strong, nonatomic) UploaderCountModel* uploaderCount;
@property (strong, nonatomic) UploaderProfileModel* profile;
@property (strong, nonatomic) NSString<Optional>* avatar;
@property (strong, nonatomic) NSString<Optional>* username;
@property (strong, nonatomic) NameModel* name;
@end
