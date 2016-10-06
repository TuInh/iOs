//
//  DataLoader.m
//  AutoHeightTable
//
//  Created by AnhLTV on 6/11/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import "DataLoader.h"

@implementation DataLoader

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataView = nil;
        self.dataLoaderDelegate = nil;
        self.dataArray = [[NSMutableArray alloc]init];

    }
    return self;
}


-(void) SetView:(UICollectionView*) refView;
{
    self.dataView = refView;
}

-(void) ReloadData
{
    
}

-(void) GotoNextPage
{
    
}
@end
