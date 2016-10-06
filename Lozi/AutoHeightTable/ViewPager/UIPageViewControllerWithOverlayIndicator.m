//
//  UIPageViewControllerWithOverlayIndicator.m
//  AutoHeightTable
//
//  Created by AnhLTV on 6/11/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import "UIPageViewControllerWithOverlayIndicator.h"

@interface UIPageViewControllerWithOverlayIndicator ()

@end

@implementation UIPageViewControllerWithOverlayIndicator

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    
    for (UIView *subview in self.view.subviews) {
        if ([subview isKindOfClass:[UIPageControl class]]) {
            if (self.isShowIndicator)
            {
                UIPageControl* mPageControl = (UIPageControl *)subview;
                mPageControl.pageIndicatorTintColor = [UIColor grayColor];
                mPageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
                mPageControl.backgroundColor = [UIColor clearColor];
                [self.view bringSubviewToFront:subview];
            }
        }
        
        else if ([subview isKindOfClass:[UIScrollView class]])
        {
            UIScrollView *mScrollView = (UIScrollView*) subview;
            [mScrollView setFrame:self.view.bounds];
        }
    }
    
    [super viewDidLayoutSubviews];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
