//
//  Food.m
//  AutoHeightTable
//
//  Created by AnhLTV on 5/11/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import "FoodCollectionView.h"



@implementation FoodCollectionView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initViewLayout];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initViewLayout];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self initViewLayout];
    }
    return self;
}



-(void) initViewLayout
{
    if (self)
    {
        //self.scrollEnabled = false;
        self.numberOfItemPerRow = 2;
        [self setDataSource:self];
        [self setDelegate:self];
        
        
        [self registerClass:[FoodCollectionViewCellBig class] forCellWithReuseIdentifier:@"FoodCollectionViewCellBig"];
        [self registerClass:[FoodCollectionViewCellSmall class] forCellWithReuseIdentifier:@"FoodCollectionViewCellSmall"];
        [self setBackgroundColor:[AppConfig GetAppBackgroundColor]];
        
    }
}

-(void) setDataLoader:(DataLoader*) newDataLoader
{
    _dataLoader = newDataLoader;
    [self.dataLoader setDataView:self];
    [self.dataLoader ReloadData];
}


-(void) setDataLoader:(DataLoader*) newDataLoader withStartPage:(NSString*) url
{
    _dataLoader = newDataLoader;
    [self.dataLoader setDataView:self];
    [self.dataLoader ReloadDataWithURL:url];
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.dataLoader)
    {
        return self.dataLoader.dataArray.count;
    }
    
       
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // Configure the cell
    FoodCollectionViewCell* cell = nil;
    if (self.numberOfItemPerRow == 2)
    {
        
        
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FoodCollectionViewCellSmall" forIndexPath:indexPath];
        if (cell == nil)
        {
            cell = [[FoodCollectionViewCellSmall alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width / self.numberOfItemPerRow, 12)];
        }
        
        
    }
    else if (self.numberOfItemPerRow == 1)
    {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FoodCollectionViewCellBig" forIndexPath:indexPath];
        if (cell == nil)
        {
            cell = [[FoodCollectionViewCellBig alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width / self.numberOfItemPerRow, 12)];
        }
    }
    
    
    if (cell != nil)
    {
        FoodModel* foodModel = [self.dataLoader.dataArray objectAtIndex:indexPath.item];
        [cell loadDataModel:foodModel];
        [cell setFoodModelArray:self.dataLoader.dataArray];
    }
    
    
    return cell;
}

-(void)goToNextPage
{

    if (self.dataLoader)
    {
        [self.dataLoader GotoNextPage];
    }

}


#pragma mark <UICollectionViewDelegate>
@end