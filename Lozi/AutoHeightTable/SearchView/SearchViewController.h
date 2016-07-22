//
//  ViewController.h
//  LoadSearchView
//
//  Created by AnhLTV on 5/23/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodSearchModel.h"
#import "AlbumsModel.h"
#import "MyTableView.h"
#import "AlbumDetailViewController.h"
#import "SearchDetailFoodViewController.h"
#import "UserDetailViewController.h"
#import "UserModel.h"
#import "AppConfig.h"

@interface SearchViewController : UIViewController<UISearchBarDelegate>

@property(nonatomic, strong) NSMutableArray* sectionContentArray;
@property(nonatomic, strong) MyTableView* myTableView;
@property(nonatomic, strong) UIButton* backButton;
@property(nonatomic, strong) UISearchBar* searchBar;

-(void) SendRequestWithQueryString:(NSString*) queryString;
-(void) onBackButtonTouch:(UIButton*)sender;
@end

