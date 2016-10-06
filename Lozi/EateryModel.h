//
//  EateryModel.h
//  AutoHeightTable
//
//  Created by haipv on 5/17/16.
//  Copyright © 2016 haipv. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "AddressModel.h"
@protocol EateryModel

@end
@interface EateryModel : JSONModel
    @property (strong, nonatomic) NSString* category;
    @property (strong,nonatomic) NSString *name;
    @property (strong,nonatomic) NSString *slug;
    @property (strong,nonatomic) NSString *avatar;
    @property (strong, nonatomic) AddressModel* address;
@end
