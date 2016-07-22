//
//  Food.h
//  AutoHeightTable
//
//  Created by AnhLTV on 5/11/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodCollectionViewCellSmall.h"
#import "FoodCollectionViewCellBig.h"
#import "DataLoader.h"
#import "FoodLoader.h"




@interface FoodCollectionView : UICollectionView <UICollectionViewDelegate, UICollectionViewDataSource>
@property(nonatomic, assign) float paddingInPixcel;
@property(nonatomic, strong) DataLoader* dataLoader;
@property(nonatomic, assign) int numberOfItemPerRow;
@property(nonatomic, assign) UIScrollView* parentScrollView;

-(void) initViewLayout;
-(void) setDataLoader:(DataLoader*) newDataLoader;
-(void) setDataLoader:(DataLoader*) newDataLoader withStartPage:(NSString*) url;
-(void) goToNextPage;
@end
