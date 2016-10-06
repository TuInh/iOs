//
//  AddressModel.h
//  AutoHeightTable
//
//  Created by AnhLTV on 5/16/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface AddressModel : JSONModel
@property (strong, nonatomic) NSString<Optional>* city;
@property (strong, nonatomic) NSString<Optional>* district;
@property (strong, nonatomic) NSString<Optional>* full;
@property (strong, nonatomic) NSString<Optional>* quater;
@property (strong, nonatomic) NSString<Optional>* short_address;
@property (strong, nonatomic) NSString<Optional>* street;
@end
