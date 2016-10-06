//
//  FoodCount.h
//  AutoHeightTable
//
//  Created by AnhLTV on 5/17/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface FoodCountModel : JSONModel
@property (assign, nonatomic) int pin;
@property (assign, nonatomic) int like;
@property (assign, nonatomic) int comment;
@end
