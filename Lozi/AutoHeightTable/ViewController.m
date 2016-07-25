//
//  ViewController.m
//  AutoHeightTable
//
//  Created by AnhLTV on 5/8/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import "ViewController.h"
#import "AppConfig.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [AppConfig SetMainController:self];
    [self.view setBackgroundColor:[AppConfig GetAppBackgroundColor]];

    
    float viewMargin = [AppConfig GetViewMargin];
    float menuPadding = 5.0f;
    self.searchContainer = [[UIView alloc] init];
    [self.searchContainer setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.searchContainer];
    
    self.searchBar = [[UISearchBar alloc]init];
    [self.searchBar setText:@" "];
    [self.searchBar setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self.searchBar setSearchBarStyle:UISearchBarStyleMinimal];
    [self.searchBar setDelegate:self];
    
    [self.searchContainer addSubview:self.searchBar];
    
    float comboboxHeight = self.view.frame.size.height / 16.0f;
    float comboboxWidth = self.view.frame.size.width / 5.0f;
    self.comboTextField = [[UIButton alloc] initWithFrame:CGRectMake(menuPadding, menuPadding + 3.0f, comboboxWidth, comboboxHeight - 6.0f)];
    [self.searchContainer addSubview:self.comboTextField];
    
    self.comboTextField.layer.masksToBounds = false;
    [self.comboTextField setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.comboTextField.titleLabel setFont:[UIFont preferredFontForTextStyle: UIFontTextStyleCaption2]];
    [self.comboTextField setTitle: @" Hà Nội " forState:UIControlStateNormal];
    [self.comboTextField.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
    [self.comboTextField setImageEdgeInsets:UIEdgeInsetsMake(0.0f, -5.0f, 0.0f, 5.0f)];
    [self.comboTextField.layer setBorderWidth:1.0f];
    self.comboTextField.layer.cornerRadius = 3.0f;
    [self.comboTextField setImage: [UIImage imageNamed:@"ic_drop_down_nf"]   forState:UIControlStateNormal];
    self.comboTextField.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    self.comboTextField.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    self.comboTextField.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    [self.comboTextField addTarget:self action:@selector(onComboboxTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.searchContainer addSubview:self.comboTextField];
    
    
    float searchBarHeight = self.comboTextField.frame.size.height;
    float searchBarWidth = self.view.frame.size.width - viewMargin * 2.0f - self.comboTextField.frame.size.width - menuPadding;
    float searchContainterHeight = searchBarHeight + menuPadding* 2.0f;
    
    [self.searchContainer setFrame:CGRectMake(0.0f, 30.0f, self.view.frame.size.width, searchContainterHeight)];
    [self.searchBar setFrame:CGRectMake( viewMargin, menuPadding, searchBarWidth, searchBarHeight)];
    [self.comboTextField setFrame:CGRectMake(self.searchBar.frame.origin.x + self.searchBar.frame.size.width,
                                             menuPadding,
                                             self.comboTextField.frame.size.width + viewMargin,
                                             self.comboTextField.frame.size.height)];
    
    
    float swipeTabContainerTop = self.searchContainer.frame.origin.y + self.searchContainer.frame.size.height + 1.0f;
    self.swipeTabContainer = [[UIViewController alloc] init];
    [self.swipeTabContainer.view setFrame:CGRectMake(0, swipeTabContainerTop, self.view.frame.size.width, self.view.frame.size.height - swipeTabContainerTop)];
    [self.swipeTabContainer.view setBackgroundColor:[UIColor whiteColor]];
    [self addChildViewController:self.swipeTabContainer];
    [self.view addSubview:self.swipeTabContainer.view];
    
    self.aroundViewController = [[AroundViewController alloc]init];
    self.foodViewController = [[FoodViewController alloc]init];
    self.shopViewController = [[ShopViewController alloc]init];
    self.shipViewController = [[ShipViewController alloc]init];
    self.otherViewController = [[OtherViewController alloc]init];
    self.top50ViewController = [[Top50ViewController alloc]init];
    self.eventViewController = [[EventViewController alloc]init];
    
    self.items = @[@"Quanh đây", @"Đồ ăn", @"Góc con gái", @"Đồ ăn ship", @"Khác", @"Top 50", @"Sự kiện"];
    self.carbonTabSwipeNavigation = [[CarbonTabSwipeNavigation alloc] initWithItems:self.items delegate:self];
    [self.carbonTabSwipeNavigation insertIntoRootViewController:self.swipeTabContainer];
    [self style];
    [self.carbonTabSwipeNavigation setCurrentTabIndex:1];

    
    
}

- (void)style {
    
    //UIColor *color = [UIColor colorWithRed:24.0/255 green:75.0/255 blue:152.0/255 alpha:1];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    self.carbonTabSwipeNavigation.toolbar.translucent = NO;
    
    [self.carbonTabSwipeNavigation setIndicatorColor:[UIColor redColor]];
    [self.carbonTabSwipeNavigation setTabExtraWidth:20];
    
    
    // Custimize segmented control
    [self.carbonTabSwipeNavigation setNormalColor:[UIColor blackColor]
                                        font:[UIFont boldSystemFontOfSize:14]];
    [self.carbonTabSwipeNavigation setSelectedColor:[UIColor redColor]
                                          font:[UIFont boldSystemFontOfSize:14]];
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (nonnull UIViewController *)carbonTabSwipeNavigation:(nonnull CarbonTabSwipeNavigation *)carbontTabSwipeNavigation
                                 viewControllerAtIndex:(NSUInteger)index {
    
    if (index == 0)
    {
        return self.aroundViewController;
    }
    
    if (index == 1)
    {
        return self.foodViewController;
    }
    
    else if (index == 2)
    {
        
        return self.shopViewController;
    }
    
    else if (index == 3)
    {
        return self.shipViewController;
    }
    
    else if (index == 4)
    {
        return self.otherViewController;
    }
    
    
    else if (index == 5)
    {
        return self.top50ViewController;
    }
    
    else if (index == 6)
    {
        return self.eventViewController;
    }

    FoodViewController* foodViewController = [[FoodViewController alloc]init];
    return foodViewController;
}

- (UIBarPosition)barPositionForCarbonTabSwipeNavigation:(nonnull CarbonTabSwipeNavigation *)carbonTabSwipeNavigation {
    return UIBarPositionTop;
}


-(void)onComboboxTouch:(UIButton*)sender
{
    
    
    //CustomDropDownList* vc = [[CustomDropDownList alloc] initWithDictionary:self.urlDictionary];
    //[vc setDropDownDelegate:self];
    //[[AppConfig GetMainController] presentViewController:vc animated:NO completion:nil];
    
    
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
 
    SearchViewController* searchViewController = [[SearchViewController alloc] init];
    [self presentViewController:searchViewController animated:false completion:nil];
    return NO;
}

@end
