//
//  UserDetailViewController.h
//  LoadSearchView
//
//  Created by AnhLTV on 7/9/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"
#import "CustomViewSearch.h"
#import <MapKit/MapKit.h>
#import "AnnotationMap.h"
#import "AppConfig.h"
#import "UserModel.h"
#import "FoodCollectionView.h"
#import "FoodCollectionViewLayout.h"
#import "AlbumsModel.h"
#import "MyTableView.h"
@interface UserDetailViewController : UIViewController<DataLoaderDelegate>
@property (strong,nonatomic) UserModel *user;
@property (strong,nonatomic) UIView *viewBack;
@property (strong,nonatomic) UILabel *lblTitleAlbum;
@property (strong,nonatomic) UIView *viewAvatar;
@property (strong,nonatomic) UIScrollView *scrollView;
@property (strong,nonatomic) MyTableView *tableViewAlbumUser;
@property (strong,nonatomic) UIView *viewFollower;
@property (strong, nonatomic) NSMutableArray* albumUserArray;
@property (strong, nonatomic) NSMutableArray* sectionAlbumUserArray;
@property (strong,nonatomic) FoodCollectionView *foodCollectionView;
@property(strong,nonatomic) FoodLoader* foodLoader;
@property(strong,nonatomic) NSString * cityId;

@end

