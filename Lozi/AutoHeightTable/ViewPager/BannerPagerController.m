//
//  BannerView.m
//  AutoHeightTable
//
//  Created by AnhLTV on 6/6/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import "BannerPagerController.h"

@implementation BannerPagerController

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.viewControllerArray = [[NSMutableArray alloc] init];
    self.pageController = [[UIPageViewControllerWithOverlayIndicator alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    [[self.pageController view] setFrame:self.view.bounds];
    [self.view addSubview:self.pageController.view];
    [self addChildViewController:self.pageController];
    
    self.bannerLoader = [[BannerLoader alloc]init];
    [self.bannerLoader setPageViewController:self];
    [self.bannerLoader ReloadData];
    
}

- (void) loadDataWithModelList:(NSMutableArray<BannerModel*>*) modelList
{
    
    [self.viewControllerArray removeAllObjects];
    
    if (modelList.count > 0)
    {
        for(int i = 0; i < modelList.count; i++)
        {
            BannerViewController* controller = [[BannerViewController alloc] initWithFrame:self.view.bounds andUrl:modelList[i].image];
            [controller setIndex:i];
            [self.viewControllerArray addObject:controller];
            
        }
        
        NSArray *initArray = [NSArray arrayWithObject:self.viewControllerArray[0]];
        [self.pageController setViewControllers:initArray direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        [self.pageController didMoveToParentViewController:self];
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    int index = 0;
    BannerViewController* controller = (BannerViewController*)viewController;
    if (controller != nil)
    {
        index = controller.index;
    }
    
    if (index == 0) {
        return nil;
    }
    index--;
    
    return self.viewControllerArray[index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    int index = 0;
    BannerViewController* controller = (BannerViewController*)viewController;
    if (controller != nil)
    {
        index = controller.index;
    }
    index++;
    if (index >= self.viewControllerArray.count) {
        return nil;
    }
    
    BannerViewController* nextView = self.viewControllerArray[index];
    [nextView updateImageHeight:self.view.frame.size.height];
    
    return nextView;
    
}




- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
    return self.viewControllerArray.count;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return 0;
}


@end
