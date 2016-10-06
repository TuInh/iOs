//
//  BannerModel.h
//  AutoHeightTable
//
//  Created by AnhLTV on 6/6/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface BannerModel : JSONModel
@property(strong, nonatomic) NSString* image;
@property(strong, nonatomic) NSString* link;
@property(strong, nonatomic) NSString* name;
@property(strong, nonatomic) NSString* objType;
@property(strong, nonatomic) NSString* slug;
@end
