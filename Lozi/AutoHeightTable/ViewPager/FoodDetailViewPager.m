//
//  FoodDetailViewPager.m
//  AutoHeightTable
//
//  Created by AnhLTV on 7/19/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import "FoodDetailViewPager.h"


@implementation FoodDetailViewPager
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setFrame:[[UIScreen mainScreen] bounds]];
    [self.view setBackgroundColor:[AppConfig GetAppBackgroundColor]];
    
    float searchContainerHeight = self.view.frame.size.height / 16.0f;
    float marginSearch = 5.0f;
    float searchBarHeight = searchContainerHeight - 2.0f * marginSearch;
    float searchBarWidth = self.view.frame.size.width - 4.0f * marginSearch - searchBarHeight * 2.0f;

    self.searchViewContainer = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 40.0f, self.view.frame.size.width, searchContainerHeight)];
    [self.searchViewContainer setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.searchViewContainer];
    
    self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(marginSearch, marginSearch, searchBarHeight, searchBarHeight)];
    [self.backButton setBackgroundColor:[UIColor whiteColor]];
    [self.backButton setImage:[UIImage imageNamed:@"leftArrowBlue"] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(onBackButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.searchViewContainer addSubview:self.backButton];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(self.backButton.frame.origin.x + self.backButton.frame.size.width + marginSearch, marginSearch, searchBarWidth, searchBarHeight)];
    [self.searchBar setBackgroundColor:[UIColor whiteColor]];
    [self.searchBar setSearchBarStyle:UISearchBarStyleMinimal];
    [self.searchBar setShowsCancelButton:NO];
    [self.searchBar setDelegate:self];

    [self.searchViewContainer addSubview:self.searchBar];
    
    self.actionButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - marginSearch - searchBarHeight, marginSearch, searchBarHeight, searchBarHeight)];
    [self.actionButton setBackgroundColor:[UIColor whiteColor]];
    [self.actionButton setImage:[UIImage imageNamed:@"ic_more"] forState:UIControlStateNormal];
    [self.searchViewContainer addSubview:self.actionButton];
    
    
    self.pageController = [[UIPageViewControllerWithOverlayIndicator alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    float pagerTop = self.searchViewContainer.frame.origin.y + searchContainerHeight;
    [[self.pageController view] setFrame:CGRectMake(0, self.searchViewContainer.frame.origin.y + searchContainerHeight, self.view.frame.size.width, self.view.frame.size.height - pagerTop)];
    [self.view addSubview:self.pageController.view];
    [self addChildViewController:self.pageController];
    
    if (self.foodModelArray.count > 0)
    {
        FoodDetailViewController* newViewController = [[FoodDetailViewController alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        [newViewController setFoodModel:self.foodModelArray[0]];
    
        [self.searchBar setText: [self.foodModelArray objectAtIndex:0].dish.foodName];
        [self.searchBar setClearButtonMode:UITextFieldViewModeWhileEditing];
        NSArray *initArray = [NSArray arrayWithObject:newViewController];
        [self.pageController setViewControllers:initArray direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        [self.pageController didMoveToParentViewController:self];
    }


}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    int index = 0;
    FoodDetailViewController* controller = (FoodDetailViewController*)viewController;
    if (controller != nil)
    {
        for (int i = 0; i < self.foodModelArray.count; i++)
        {
            if ([self.foodModelArray objectAtIndex:i].foodID == controller.foodModel.foodID)
            {
                index = i;
                [self.searchBar setShowsCancelButton:NO];
                break;
            }
        }
    }
    else
    {
        return nil;
    }
    
    if (index <= 0) {
        return nil;
    }
    
    index--;
    
    FoodDetailViewController* newViewController = [[FoodDetailViewController alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [newViewController setFoodModel:self.foodModelArray[index]];
    
    [self.searchBar setText: [self.foodModelArray objectAtIndex:index].dish.foodName];
    return newViewController;
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    int index = 0;
    FoodDetailViewController* controller = (FoodDetailViewController*)viewController;
    if (controller != nil)
    {
        for (int i = 0; i < self.foodModelArray.count; i++)
        {
            if ([self.foodModelArray objectAtIndex:i].foodID == controller.foodModel.foodID)
            {
                index = i;
                [self.searchBar setText: [self.foodModelArray objectAtIndex:index].dish.foodName];
                [self.searchBar setShowsCancelButton:NO];
                break;
            }
        }
    }
    
    index++;
    if (index >= self.foodModelArray.count) {
        return nil;
    }
    
    FoodDetailViewController* newViewController = [[FoodDetailViewController alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [newViewController setFoodModel:self.foodModelArray[index]];
    
    
    return newViewController;

    
}




- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
    return self.foodModelArray.count;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return 0;
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return NO;
}


-(void)onBackButtonTouch:(UIButton*)sender
{
    [self dismissViewControllerAnimated:false completion:nil];
}

@end
