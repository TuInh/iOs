//
//  EateryModel.h
//  AutoHeightTable
//
//  Created by AnhLTV on 5/17/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "AddressModel.h"
#import "OperatingTimeModel.h"

@protocol OperatingTimeModel
@end

@protocol EateryModel

@end

@interface EateryModel : JSONModel
    @property (strong,nonatomic) NSString<Optional>*eateryID;
    @property (strong,nonatomic) NSString<Optional>*slug;
    @property (strong,nonatomic) NSString<Optional>*avatar;
    @property (strong, nonatomic) NSString<Optional>* category;
    @property (strong, nonatomic) NSString<Optional>* name;
    @property (strong, nonatomic) AddressModel* address;
    @property (strong, nonatomic) NSArray<OperatingTimeModel>* operatingTime;
    @property (strong, nonatomic) NSString<Optional>* finish;



@end
