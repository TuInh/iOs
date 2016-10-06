//
//  EventCollectionView.h
//  AutoHeightTable
//
//  Created by AnhLTV on 7/13/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "EventCollectionViewCell.h"
#import "EventLoader.h"

@interface EventCollectionView : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegate>
@property(strong,nonatomic) EventLoader *dataLoader;
@end
