//
//  EventLoader.m
//  AutoHeightTable
//
//  Created by AnhLTV on 7/12/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import "EventLoader.h"

@implementation EventLoader
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (void) ReloadData
{
    self.isFirstLoad = true;
    [self.dataArray removeAllObjects];
    
    self.currentURl = [NSString stringWithFormat: @"%@%@%ld", [AppConfig GetBaseNextPageUrl], [AppConfig GetEventBaseURL], [AppConfig GetCityID]];
    self.nextURl = @"";
    [self SendRequest];
    
}


- (void) ReloadDataWithURL: (NSString*) url
{
    self.isFirstLoad = true;
    [self.dataArray removeAllObjects];
    self.currentURl = url;
    self.nextURl = @"";
    [self SendRequest];
    
}


- (void) SendRequest
{
    if (!self.isLoading)
    {
        NSURL* url = [NSURL URLWithString:self.currentURl];
        NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
        [request setValue: @"latte.lozi.vn"  forHTTPHeaderField:@"Host"];
        [request setValue: [NSString stringWithFormat:@"%ld", [AppConfig GetCityID]] forHTTPHeaderField:@"X-City-ID"];
        [request setValue: @"http://m.lozi.vn"  forHTTPHeaderField:@"Origin"];
        [request setValue: [NSString stringWithFormat:@"%ld", [AppConfig GetClientID]]  forHTTPHeaderField:@"X-Lozi-Client"];
        [request setValue: [NSString stringWithFormat: @"http://m.lozi.vn/a/%@", [AppConfig GetCityString]] forHTTPHeaderField:@"Referer"];
        
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                      {
                                          self.isLoading = false;
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
                                                      for (NSDictionary* foodObject in dataObject)
                                                      {
                                                          EventModel* newFoodModel = [[EventModel alloc] initWithDictionary:foodObject error:nil];
                                                          [self.dataArray insertObject:newFoodModel atIndex:self.dataArray.count];
                                                          
                                                      }
                                                  }
                                                  
                                                  //Update next page url
                                                  NSDictionary* paginationObject = [jsonResult valueForKey:@"pagination"];
                                                  if (paginationObject != nil)
                                                  {
                                                      NSString* nextUrl = [paginationObject valueForKey:@"nextUrl"];
                                                      if (nextUrl == nil)
                                                      {
                                                          self.nextURl = @"";
                                                          
                                                      }
                                                      else
                                                      {
                                                          self.nextURl = nextUrl;
                                                      }

                                                  }
                                                  
                                                  if (self.dataView != nil)
                                                  {
                                                      
                                                      dispatch_async(dispatch_get_main_queue(),
                                                                     ^
                                                                     {
                                                                         [self.dataView reloadData];
                                                                     });
                                                      
                                                      
                                                      
                                                  }
                                                  
                                              }
                                              
                                          }
                                      }];
        
        
        self.isLoading = true;
        [task resume];
        
    }
    
}


-(void) GotoNextPage
{
    if (self.nextURl.length > 0)
    {
        self.isFirstLoad = false;
        self.currentURl = [[AppConfig GetBaseNextPageUrl] stringByAppendingString: self.nextURl];
        [self SendRequest];
    }
}

@end
