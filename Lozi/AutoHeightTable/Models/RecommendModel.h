//
//  RecommendModel.h
//  LoadSearchView
//
//  Created by AnhLTV on 6/26/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
@interface RecommendModel : JSONModel

@property (strong,nonatomic) NSString *avatar;
@property (strong,nonatomic) NSString *fullAddress;
@property (strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSString *priceCouple;
@property(strong,nonatomic) NSArray<NSDictionary*> *operatingTime;
@property (assign,nonatomic) float rating;
@property(assign,nonatomic) NSString *slug;

@end
