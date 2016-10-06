//
//  DataLoader.h
//  AutoHeightTable
//
//  Created by AnhLTV on 6/11/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodModel.h"
#import "AppConfig.h"

@protocol DataLoaderDelegate <NSObject>
-(void) onDataLoadedSucessWithData;
@end

@interface DataLoader : NSObject
@property (strong, nonatomic) NSString* currentURl;
@property (strong, nonatomic) NSString* nextURl;
@property (strong, nonatomic) NSMutableArray* dataArray;
@property (assign, nonatomic) bool isLoading;
@property UICollectionView* dataView;
@property bool isFirstLoad;
@property (strong, nonatomic) id<DataLoaderDelegate> dataLoaderDelegate;

-(void) SetView:(UICollectionView*) refView;
-(void) SendRequest;
-(void) ReloadData;
-(void) ReloadDataWithURL: (NSString*) url;
-(void) GotoNextPage;
@end
