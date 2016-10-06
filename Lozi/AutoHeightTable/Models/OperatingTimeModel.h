//
//  OperatingTimeModel.h
//  AutoHeightTable
//
//  Created by AnhLTV on 7/17/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface OperatingTimeModel : JSONModel
@property (strong,nonatomic) NSString<Optional>* start;
@property (strong,nonatomic) NSString<Optional>* finish;
@end
