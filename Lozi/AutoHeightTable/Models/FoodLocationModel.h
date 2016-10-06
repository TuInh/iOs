//
//  FoodLocationModel.h
//  LoadSearchView
//
//  Created by AnhLTV on 6/6/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
@interface FoodLocationModel : JSONModel
@property (strong,nonatomic)NSString *name;
@property (strong,nonatomic)NSString *_id;
@property (strong,nonatomic)NSString *slug;
@property(strong,nonatomic) NSString *avatar;
@property(strong,nonatomic) NSString *category;
@property(strong,nonatomic) NSString *fulladdress;
@property(assign,nonatomic) float latitude;
@property(assign,nonatomic) float longitude;
@property(assign,nonatomic) float comment;
@property(assign,nonatomic) float visit;
@property(assign,nonatomic) float block;
@property(strong,nonatomic) NSString* phoneNumber;
@property(strong,nonatomic) NSArray<NSDictionary*> *operatingTime;
@property(strong,nonatomic) NSArray<NSString *>*photos;
@property(strong,nonatomic) NSString *priceCouple;
@end
