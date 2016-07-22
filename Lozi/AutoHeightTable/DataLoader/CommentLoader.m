//
//  CommentLoader.m
//  AutoHeightTable
//
//  Created by AnhLTV on 7/16/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import "CommentLoader.h"

@implementation CommentLoader
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tableView = nil;
    }
    return self;
}


- (void) ReloadData
{
    
    
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
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                      {
                                          self.isLoading = false;
                                          NSString *strData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                       
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
                                                          CommentModel* newCommentModel = [[CommentModel alloc] initWithDictionary:foodObject error:nil];
                                                          [self.dataArray insertObject:newCommentModel atIndex:self.dataArray.count];
                                                          
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
                                                  
                                                  if (self.tableView != nil)
                                                  {
                                                      
                                                      dispatch_async(dispatch_get_main_queue(),
                                                                     ^
                                                                     {
                                                                         [self.tableView reloadData];
                                                                         [self.tableView setFrame:CGRectMake(self.tableView.frame.origin.x, self.dataView.frame.origin.y, self.dataView.contentSize.width, self.self.dataView.contentSize.height)];
                                                                         
                                                                        
                                                                         if (self.dataLoaderDelegate != nil)
                                                                         {
                                                                             [self.dataLoaderDelegate onDataLoadedSucessWithData];
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
