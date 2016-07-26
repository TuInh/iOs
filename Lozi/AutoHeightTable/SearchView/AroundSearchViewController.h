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
#import "AroundModel.h"
#import "FoodCollectionView.h"
#import "FoodCollectionViewLayout.h"
#import "DataLoader.h"

@interface AroundSearchViewController : UIViewController<MKMapViewDelegate, DataLoaderDelegate, UIScrollViewDelegate, CLLocationManagerDelegate>

@property (strong,nonatomic) UIView *viewBack;
@property (strong,nonatomic) UIView *viewImage;
@property (strong,nonatomic) MKMapView *map;
@property (strong,nonatomic) UIScrollView *scrollView;
@property (strong,nonatomic) UIImage *imgBackground;
@property(strong,nonatomic) FoodLoader* foodLoader;
@property(strong,nonatomic) FoodCollectionView *foodCollectionView;
@property(strong,nonatomic) CLLocation *currentLocaltion;
@property(strong,nonatomic) CLLocationManager *locationManager;
@property(strong,nonatomic) AroundModel* aroundModel;
@property(assign,nonatomic) bool isFirstLoadLocation;
@property(assign,nonatomic) bool isAnnotation;
@end

