//
//  FoodCollectionViewLayout.m
//  AutoHeightTable
//
//  Created by AnhLTV on 5/23/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import "FoodCollectionViewLayout.h"

@implementation FoodCollectionViewLayout


- (void)prepareLayout
{
    [super prepareLayout];
    if ( !self.attributeArray)
    {
        self.attributeArray = [[NSMutableDictionary alloc] init];
    }
    [self.attributeArray removeAllObjects];
    
    FoodCollectionView* foodCollectionView = (FoodCollectionView*) self.collectionView;
    
    int numberOfColumn = foodCollectionView.numberOfItemPerRow;
    float padding = [AppConfig GetViewMargin];
    
    float itemWidth = (foodCollectionView.frame.size.width - (padding) * (float)(numberOfColumn + 1)) / (float)numberOfColumn;
    float contentHeight = 0;
    
    NSMutableArray* columnArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < numberOfColumn; i++)
    {
        [columnArray insertObject:[NSNumber numberWithFloat:0.0f] atIndex:i];
    }
    
    NSMutableArray* foodArray = foodCollectionView.dataLoader.dataArray;
    for (int i = 0; i < foodArray.count; i++)
    {
        
        float tempX = 0;
        float tempY = 0;
        float itemHeight = 0;
     
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        FoodCollectionViewCell* cell = nil;
        if (numberOfColumn == 2)
        {
            
            cell = [[FoodCollectionViewCellSmall alloc] initWithFrame:CGRectMake(0, 0, itemWidth, 12)];
            
            
            
        }
        else if (numberOfColumn == 1)
        {
            cell = [[FoodCollectionViewCellBig alloc] initWithFrame:CGRectMake(0, 0, itemWidth, 12)];
            
        }
        
        else if (numberOfColumn == 3)
        {
            itemHeight = itemWidth;
            
        }
        
        
        if (cell != nil)
        {
            FoodModel* foodModel = foodArray[i];
            [cell loadDataModel:foodModel];
            itemHeight = cell.frame.size.height;
        }
        
        //Find Column Has Min Height
        float minHeight = 0;
        int minIndex = 0;
        
        if (numberOfColumn > 0)
        {
            minHeight = [columnArray[0] floatValue];
        }
        for (int colIndex = 0; colIndex < numberOfColumn; colIndex++)
        {
            if (minHeight > [columnArray[colIndex] floatValue])
            {
                minHeight = [columnArray[colIndex] floatValue];
                minIndex = colIndex;
            }
        }

        
        //Insert to Column has min height
        tempX = padding + (itemWidth + padding) * (float) minIndex;
        tempY = minHeight + padding;
        columnArray[minIndex] = [NSNumber numberWithFloat: tempY + itemHeight];
        
        UICollectionViewLayoutAttributes* attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.frame = CGRectMake(tempX, tempY, itemWidth, itemHeight);
      
        
        float newContentHeight = tempY + padding + itemHeight + padding;
        if (newContentHeight > contentHeight)
        {
            contentHeight = newContentHeight;
        }

        [self.attributeArray setObject:attributes forKey: indexPath];
        
    }
    

    self.contentSize = CGSizeMake(foodCollectionView.frame.size.width, contentHeight);
    
    
    [foodCollectionView setFrame:CGRectMake(self.collectionView.frame.origin.x,
                                            self.collectionView.frame.origin.y,
                                            self.collectionView.frame.size.width,
                                            contentHeight)];
    
    
    
    if (foodCollectionView.parentScrollView)
    {
        foodCollectionView.parentScrollView.contentSize = CGSizeMake(foodCollectionView.parentScrollView.frame.size.width, foodCollectionView.frame.origin.y + contentHeight + padding * 3.0f);
    }
    
}

#pragma mark -
#pragma mark - Required methods


- (CGSize)collectionViewContentSize
{
    return self.contentSize;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.attributeArray objectForKey:indexPath];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray* retVal = [[NSMutableArray alloc] init];
    
    for (NSIndexPath *indexPath in self.attributeArray)
    {
        UICollectionViewLayoutAttributes* attributes = [self.attributeArray objectForKey:indexPath];
        if (CGRectIntersectsRect(attributes.frame, rect))
        {
            [retVal addObject:attributes];
        }
    }
    return retVal;
}

@end
