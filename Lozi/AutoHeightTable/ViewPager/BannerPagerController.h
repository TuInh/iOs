//
//  BannerView.h
//  AutoHeightTable
//
//  Created by AnhLTV on 6/6/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "BannerModel.h"
#import "BannerLoader.h"
#import "BannerViewController.h"
#import "UIPageViewControllerWithOverlayIndicator.h"

@class BannerLoader;

@interface BannerPagerController : UIViewController <UIPageViewControllerDataSource>
    @property (strong, nonatomic) UIPageViewControllerWithOverlayIndicator *pageController;
    @property (strong, nonatomic) NSMutableArray* viewControllerArray;
    @property (strong, nonatomic) BannerLoader* bannerLoader;


- (void) loadDataWithModelList:(NSMutableArray<BannerModel*>*) modelList;
@end
