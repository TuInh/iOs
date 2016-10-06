//
//  BannerLoader.h
//  AutoHeightTable
//
//  Created by AnhLTV on 6/11/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import "DataLoader.h"
#import "BannerPagerController.h"

@class BannerPagerController;

@interface BannerLoader : DataLoader
@property(nonatomic, strong) BannerPagerController* pageViewController;

-(void) setPageViewController:(BannerPagerController *)pageViewController;
@end
