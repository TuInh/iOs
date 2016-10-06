//
//  UploaderProfileModel.h
//  AutoHeightTable
//
//  Created by AnhLTV on 5/16/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface UploaderProfileModel : JSONModel
@property (strong, nonatomic) NSString<Optional>* birthday;
@property (strong, nonatomic) NSString<Optional>* email;
@property (strong, nonatomic) NSString<Optional>* gender;
@property (strong, nonatomic) NSString<Optional>* phoneNumber;
@end
