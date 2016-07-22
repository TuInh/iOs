//
//  FoodCollectionViewLayout.h
//  AutoHeightTable
//
//  Created by AnhLTV on 5/23/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodCollectionView.h"
#import "AppConfig.h"

@interface FoodCollectionViewLayout : UICollectionViewLayout
//@property(nonatomic, strong) NSMutableArray* attributeArray;
@property(nonatomic, strong) NSMutableDictionary* attributeArray;
@property(nonatomic) CGSize contentSize;
@end
