//
//  AppConfig.m
//  AutoHeightTable
//
//  Created by AnhLTV on 6/11/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import "AppConfig.h"

@implementation AppConfig


//Main Controller
static UIViewController* mainController = nil;

//View Layout Config
static float mViewMargin = 10.0f;

//User Profile Config
static long mCityID =1;
static NSString* mCityString = @"ha-noi";
static long mClientID = 1;
static UIColor* backgroupColor = nil;


//Request URL Config
static NSString* baseUrlNextPage = @"http://latte.lozi.vn/v1";

//Around Base URL
static NSString* aroundBaseURL = @"/around/topics?cityId=";

//Category Base URL
static NSString* categoryBaseURL = @"/newsfeed/categories/top?cityId=";

//Event Base URL
static NSString* eventBaseURL = @"/events?cityId=";


static NSString* firstFoodPage = @"/topics/1/photos?t=popular";
static NSString *slugSearchBase = @"http://latte.lozi.vn/v1/eateries/slug:";
static NSString *slugAlbumBase = @"http://latte.lozi.vn/v1/albums/";

+(NSString*) GetBaseNextPageUrl
{
    return baseUrlNextPage;
}

+(void) LoadAppConfig
{
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    if (preferences != nil)
    {
        
        if ([preferences objectForKey: @"CityID"] == nil)
        {
            mCityID = [preferences integerForKey:@"CityID"];
        }
        
        
        if ([preferences objectForKey: @"CityString"] == nil)
        {
            mCityString = [preferences stringForKey:@"CityString"];
        }
    }
    else
    {
        printf("Shared Reference: Load Failed !");
    }
}

+ (float)GetViewMargin
{
    return mViewMargin;
}

+(void) SaveAppConfig
{
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    
    if (preferences != nil)
    {
        [preferences setInteger:mCityID forKey:@"CityID"];
        [preferences setValue:mCityString forKey:@"CityString"];
        
        const bool didSave = [preferences synchronize];
        if (!didSave)
        {
            printf("Shared Reference: Save Failed !");
        }
    }
    
    else
    {
        printf("Shared Reference: Load Failed !");
    }
    
   
}


+(long) GetCityID
{
    return mCityID;
    
}

+(void) SetCityID:(int)cityID
{
    mCityID = cityID;
    [AppConfig SaveAppConfig];
}


+(NSString*) GetCityString
{
    return mCityString;
}

+(void) SetCityString:(NSString*) cityString
{
    mCityString = cityString;
    [AppConfig SaveAppConfig];
}

+(long) GetClientID
{
    return mClientID;
}


+(void) SetClienID:(long)clientID
{
    mClientID = clientID;
    [AppConfig SaveAppConfig];
}

+(UIViewController*) GetMainController
{
    return mainController;
}

+(void) SetMainController:(UIViewController*) controller
{
    mainController = controller;
}

+(UIColor*) GetAppBackgroundColor
{
    if (backgroupColor == nil)
    {
        backgroupColor = [UIColor colorWithRed:224.0f/255.0f green:224.0f/255.0f blue:224.0f/255.0f alpha:1.0f];;
        
    }
    
    return backgroupColor;
}

+(NSString*) GetAroundBaseURL
{
    return aroundBaseURL;
}


+(NSString*) GetCategoryBaseURL
{
    return categoryBaseURL;
}

+(NSString *)GetEventBaseURL
{
    return eventBaseURL;
}

+(NSString*) GetCommentURlWithID: (NSString*) commentID
{
    return [NSString stringWithFormat:@"%@/blocks/%@/comments?cityId=%ld", [AppConfig GetBaseNextPageUrl], commentID, [AppConfig GetCityID]];
}

+(NSString*) GetRelatedURlWithID: (NSString*) commentID
{
    return [NSString stringWithFormat:@"%@/blocks/%@/related?cityId=%ld", [AppConfig GetBaseNextPageUrl], commentID, [AppConfig GetCityID]];
}

+ (NSString *)GetFirstFoodPage
{
    return firstFoodPage;
}
+ (NSString *)GetSlugBase
{
    return slugSearchBase;
}
+(NSString *)GetSlugAlbumBase
{
    return slugAlbumBase;
}
@end
