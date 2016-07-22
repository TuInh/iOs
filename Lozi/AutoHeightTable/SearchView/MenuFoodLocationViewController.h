//
//  MenuFoodLocationViewController.h
//  LoadSearchView
//
//  Created by AnhLTV on 7/18/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTableView.h"
#import "MenuModel.h"
#import "AppConfig.h"
@interface MenuFoodLocationViewController : UIViewController
@property (strong,nonatomic) NSString *_id;
@property (strong,nonatomic) UIView *viewBack;
@property(nonatomic,strong) MyTableView *tableMenu;
@property (strong,nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) NSMutableArray* menuArray;
@property(nonatomic, strong) NSMutableArray* sectionMenuArray;

@end
