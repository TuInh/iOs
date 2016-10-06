//
//  BannerLoader.m
//  AutoHeightTable
//
//  Created by AnhLTV on 6/11/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import "BannerLoader.h"

@implementation BannerLoader
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (void) ReloadData
{

    [self.dataArray removeAllObjects];
    self.currentURl = [NSString stringWithFormat: @"%@/newsfeed/banners?cityId=%ld", [AppConfig GetBaseNextPageUrl], [AppConfig GetCityID]];
    self.nextURl = @"";
    [self SendRequest];
    
}

- (void) ReloadDataWithURL: (NSString*) url
{
    [self.dataArray removeAllObjects];
    self.currentURl = url;
    self.nextURl = @"";
    [self SendRequest];
    
}


-(void) setPageViewController:(BannerPagerController *)pageViewController
{
    _pageViewController = pageViewController;
}

- (void) SendRequest
{
    
    NSURL* url = [NSURL URLWithString:self.currentURl];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setValue: @"latte.lozi.vn"  forHTTPHeaderField:@"Host"];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                  {
                                      if ((data != nil) && (error == nil))
                                      {
                                          
                                          
                                          NSError *parsingError = nil;
                                          NSDictionary *jsonResult = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                                          
                                          if (jsonResult != nil)
                                          {
                                              //Add new item
                                              NSArray* dataObject = [jsonResult valueForKey:@"data"];
                                              
                                              if (dataObject != nil)
                                              {
                                                  for (NSDictionary* bannerObject in dataObject)
                                                  {
                                                      BannerModel* newFoodModel = [[BannerModel alloc] initWithDictionary:bannerObject error:nil];
                                                      [self.dataArray insertObject:newFoodModel atIndex:self.dataArray.count];
                                                      
                                                  }
                                              }
                                              
                                              //Update next page url
                                              NSDictionary* paginationObject = [jsonResult valueForKey:@"pagination"];
                                              if (paginationObject != nil)
                                              {
                                                  NSString* nextUrl = [paginationObject valueForKey:@"nextUrl"];
                                                  if ((nextUrl != nil) && (nextUrl.length > 0))
                                                  {
                                                      self.nextURl = nextUrl;
                                                  }
                                                  else
                                                  {
                                                      self.nextURl = @"";
                                                  }
                                              }
                                              
                                              if (self.pageViewController != nil)
                                              {
                                                  dispatch_async(dispatch_get_main_queue(),
                                                                 ^
                                                                 {
                                                                     [self.pageViewController loadDataWithModelList: self.dataArray];
                                                                     
                                                                 });
                                                  
                                                  
                                              }
                                              
                                          }
                                          
                                      }
                                  }];
    [task resume];
    
}


-(void) GotoNextPage
{
}
@end
