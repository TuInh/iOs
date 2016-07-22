//
//  FoodLoader.m
//  AutoHeightTable
//
//  Created by AnhLTV on 5/17/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import "FoodLoader.h"



@implementation FoodLoader

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
    self.currentURl = [NSString stringWithFormat: @"%@/topics/1/photos?t=popular", [AppConfig GetBaseNextPageUrl]];
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
                            FoodModel* newFoodModel = [[FoodModel alloc] initWithDictionary:foodObject error:nil];
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
                    
                    if (self.dataView != nil)
                    {
                       
                        dispatch_async(dispatch_get_main_queue(),
                           ^
                           {
                               if (!self.isFirstLoad)
                               {
                                   [UIView performWithoutAnimation:^{
                                        [self.dataView reloadSections:[NSIndexSet indexSetWithIndex:0]];

                                   }];
                               }
                               else
                               {
                                   [self.dataView reloadData];
                               }
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
