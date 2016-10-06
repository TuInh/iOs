//
//  EventCollectionView.m
//  AutoHeightTable
//
//  Created by AnhLTV on 7/13/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import "EventCollectionView.h"

@implementation EventCollectionView


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
        self.dataSource = self;
        self.delegate = self;
        
        [self registerClass:[EventCollectionViewCell class] forCellWithReuseIdentifier:[EventCollectionViewCell getClassIndentifier]];
        [self setBackgroundColor:[AppConfig GetAppBackgroundColor]];
        
        self.dataLoader = [[EventLoader alloc] init];
        self.dataLoader.dataView = self;
        [self.dataLoader ReloadData];
        
        
    }
}




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.dataLoader.dataArray.count;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    EventCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[EventCollectionViewCell getClassIndentifier] forIndexPath:indexPath];
    EventModel *model =  [self.dataLoader.dataArray objectAtIndex:indexPath.item];
    [cell setModelData: model];
    
    if (self.dataLoader != nil)
    {
        if (indexPath.item == self.dataLoader.dataArray.count)
        {
            [self.dataLoader GotoNextPage];
        }
    }
    return cell;
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float inset = 5.0f;
    float layoutWidht = self.frame.size.width-2.0f*inset;
    EventModel *model =  [self.dataLoader.dataArray objectAtIndex:indexPath.row];
    
    EventCollectionViewCell *cell = [[EventCollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, layoutWidht, 12)];    
    [cell setModelData: model];
    return CGSizeMake(layoutWidht, cell.frame.size.height);
    
}




@end
