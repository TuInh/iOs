//
//  AppConfig.h
//  AutoHeightTable
//
//  Created by AnhLTV on 6/11/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppConfig : NSObject

+(NSString*) GetBaseNextPageUrl;

+(void) LoadAppConfig;
+(void) SaveAppConfig;

+(float) GetViewMargin;

+(long) GetCityID;
+(void) SetCityID:(int)cityID;

+(long) GetClientID;
+(void) SetClienID:(NSString*)clientID;



+(NSString*) GetCityString;
+(void) SetCityString:(NSString*) cityString;


+(UIViewController*) GetMainController;
+(void) SetMainController:(UIViewController*) controller;

+(UIColor*) GetAppBackgroundColor;
+(NSString*) GetAroundBaseURL;
+(NSString*) GetCategoryBaseURL;
+(NSString*) GetEventBaseURL;
+(NSString*) GetCommentURlWithID: (NSString*) commentID;
+(NSString*) GetRelatedURlWithID: (NSString*) commentID;

+ (NSString *)GetSlugBase;
+ (NSString *)GetSlugAlbumBase;
+ (NSString*) GetFirstFoodPage;
@end
