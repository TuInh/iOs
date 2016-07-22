//
//  AlbumDetailViewController.h
//  LoadSearchView
//
//  Created by AnhLTV on 7/5/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumsModel.h"
#import "CustomViewSearch.h"
#import <MapKit/MapKit.h>
#import "AnnotationMap.h"
#import "AppConfig.h"
#import "UserModel.h"
#import "FoodCollectionView.h"
#import "FoodCollectionViewLayout.h"
#import "DataLoader.h"

@interface AlbumDetailViewController : UIViewController<MKMapViewDelegate, DataLoaderDelegate>
@property (strong,nonatomic) AlbumsModel *album;
@property (strong,nonatomic) UIView *viewBack;
@property (strong,nonatomic) UIView *viewImage;
@property (strong,nonatomic) UIView *viewDescription;
@property (strong,nonatomic) UIView *viewFollower;
@property (strong,nonatomic) MKMapView *map;
@property (strong,nonatomic) UIScrollView *scrollView;
@property (strong,nonatomic) UIImage *imgBackground;
@property(strong,nonatomic) NSString *cityID;
@property(strong,nonatomic) FoodLoader* foodLoader;

@property (strong, nonatomic) NSMutableArray* followerArray;
@property(strong,nonatomic) FoodCollectionView *foodCollectionView;
@end

