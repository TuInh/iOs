//
//  AlbumDetailViewController.m
//  LoadSearchView
//
//  Created by AnhLTV on 7/5/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

#import "AroundSearchViewController.h"

@interface AroundSearchViewController ()

@end

@implementation AroundSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isFirstLoadLocation = true;
    // Do any additional setup after loading the view.
    self.isAnnotation = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    CGSize size = [UIScreen mainScreen].bounds.size;
    CGFloat w = size.width;
    CGFloat h = size.height;
    CGFloat borderWidth = 3.0f;
    // Add view for navigation
    _viewBack = [[UIView alloc]init];
    _viewBack.backgroundColor = [UIColor grayColor];
    _viewBack.frame = CGRectMake(0, 25, w, h*0.07);
    CGFloat marginTop = (h*0.07 - h*0.05)/2;
    //CGFloat marginTopBtn = (h*0.07-h*0.03)/2;
    
    // add background for annotation
    UIImage *imgInitial = [UIImage imageNamed:@"marker"];
    _imgBackground = imgInitial;
    
    //add btn back to previous scene
    UIButton *btnBack = [[UIButton alloc]init];
    btnBack.frame = CGRectMake(0, 0, h*0.03+20, _viewBack.frame.size.height);
    [btnBack setImage:[UIImage imageNamed:@"leftArrowBlue"] forState:UIControlStateNormal];
    [btnBack.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [btnBack addTarget:self action:@selector(backToPrevious:) forControlEvents:UIControlEventTouchUpInside];
    [_viewBack addSubview:btnBack];
    
    CustomViewSearch *searchView = [[CustomViewSearch alloc]initWithFrame:CGRectMake(btnBack.frame.origin.x + btnBack.frame.size.width , marginTop, w*0.75, h*0.05) type:2
                                    ];
    searchView.frame = CGRectInset(searchView.frame, -borderWidth, -borderWidth);
    searchView.layer.borderWidth = borderWidth;
    searchView.layer.borderColor = [UIColor blackColor].CGColor;
    [searchView.txtSearch setText:self.aroundModel.name];
    
    [_viewBack addSubview:searchView];

    [self.view addSubview:_viewBack];

    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _viewBack.frame.origin.y+_viewBack.frame.size.height, w, h-_viewBack.frame.size.height-_viewBack.frame.origin.y)];
    
    [self.view addSubview:_scrollView];
    
    //Init current location
    self.currentLocaltion = [[CLLocation alloc] initWithLatitude: 21.017324f longitude:105.784054f];
    
    // add map
    _map = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0, w, h/2)];
    _map.delegate = self;
    [_scrollView addSubview:_map];
    _map.mapType = MKMapTypeStandard;
    _map.zoomEnabled = YES;
    _map.scrollEnabled = YES;
    [_map setCenterCoordinate:self.currentLocaltion.coordinate];
    
    //Init Location Manager
    _locationManager = [CLLocationManager new];
    _locationManager.delegate = self;
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;

    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 &&
        [CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse
        //[CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedAlways
       ) {
         // Will open an confirm dialog to get user's approval 
        [_locationManager requestWhenInUseAuthorization]; 
        //[_locationManager requestAlwaysAuthorization];
    } else {
        [_locationManager startUpdatingLocation]; //Will update location immediately 
    }
    
    
    //http://latte.lozi.vn/v1/newsfeed/photos?lng=105.83046851679683&topics=999&t=around&r=320&cityId=1&lat=21.01592557483175
    NSString *remainUrlBlock =[NSString stringWithFormat:@"%@/newsfeed/photos?lng=%f&topics=%@&t=around&r=320&cityId=%ld&lat=%f", [AppConfig GetBaseNextPageUrl], self.currentLocaltion.coordinate.longitude, self.aroundModel.idAround, [AppConfig GetCityID], self.currentLocaltion.coordinate.latitude];
   FoodCollectionViewLayout* collectionLayout = [[FoodCollectionViewLayout alloc] init];
    self.foodCollectionView = [[FoodCollectionView alloc] initWithFrame:CGRectMake(0, self.map.frame.origin.y+self.map.frame.size.height, w, 10) collectionViewLayout:collectionLayout];
    self.foodCollectionView.showsVerticalScrollIndicator = false;
    [self.foodCollectionView setParentScrollView:self.scrollView];
    self.foodCollectionView.parentViewContoller = self;
    _foodLoader = [[FoodLoader alloc] init];
    [_foodLoader setDataLoaderDelegate:self];
    [self.foodCollectionView setDataLoader:_foodLoader withStartPage:remainUrlBlock];
    [_scrollView addSubview:self.foodCollectionView];
    _scrollView.contentSize = CGSizeMake(w, _foodCollectionView.frame.origin.y + _foodCollectionView.frame.size.height);

    [_scrollView setDelegate: self];
    
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager*)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
    case kCLAuthorizationStatusNotDetermined: {
        NSLog(@"User still thinking..");
    } break;
    case kCLAuthorizationStatusDenied: {
        NSLog(@"User hates you");
    } break;
    case kCLAuthorizationStatusAuthorizedWhenInUse:
    case kCLAuthorizationStatusAuthorizedAlways: {
        [_locationManager startUpdatingLocation]; //Will update location immediately
    } break;
    default:
        break;
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    if (self.isFirstLoadLocation == true)
    {
        self.isFirstLoadLocation = false;
        self.currentLocaltion = [locations lastObject];
        [_map setCenterCoordinate:self.currentLocaltion.coordinate];
        NSString *remainUrlBlock =[NSString stringWithFormat:@"%@/newsfeed/photos?lng=%f&topics=%@&t=around&r=320&cityId=%ld&lat=%f", [AppConfig GetBaseNextPageUrl], self.currentLocaltion.coordinate.longitude, self.aroundModel.idAround, [AppConfig GetCityID], self.currentLocaltion.coordinate.latitude];
        [self.foodCollectionView setDataLoader:_foodLoader withStartPage:remainUrlBlock];
        [self.locationManager stopUpdatingLocation];
    }
}


-(void)onDataLoadedSucessWithData
{
    

     dispatch_async(dispatch_get_main_queue(),
     ^
     {
         if(self.isAnnotation == NO && _foodLoader.dataArray.count >0)
         {
             self.isAnnotation = YES;
             
             if (_foodLoader.dataArray.count > 0)
             {
                 FoodModel *foodmodel = [_foodLoader.dataArray objectAtIndex:0];
                 CLLocationDegrees lattitude = [[foodmodel.eateryCoords objectAtIndex:1] floatValue];
                 CLLocationDegrees longtitude = [[foodmodel.eateryCoords objectAtIndex:0] floatValue];
                
                 CLLocationDegrees latDelta = 0.045;
                 CLLocationDegrees lonDelta = 0.045;
                 MKCoordinateSpan span = MKCoordinateSpanMake(latDelta, lonDelta);
                 CLLocationCoordinate2D location = CLLocationCoordinate2DMake(lattitude, longtitude);
                 MKCoordinateRegion region =  MKCoordinateRegionMake(location, span);
                 [_map setRegion:region];
                 
                

                 for(int i=0; i<_foodLoader.dataArray.count;i++)
                 {
                     // Add custom annotation for mapkit
                     FoodModel *foodmodel = [_foodLoader.dataArray objectAtIndex:i];
                     CLLocationDegrees lattitude = [[foodmodel.eateryCoords objectAtIndex:1] floatValue];
                     CLLocationDegrees longtitude = [[foodmodel.eateryCoords objectAtIndex:0] floatValue];
                     CLLocationCoordinate2D location = CLLocationCoordinate2DMake(lattitude, longtitude);
                     AnnotationMap *annotation = [[AnnotationMap alloc]init];
                     annotation.coordinate = location;
                     annotation.tag = i;
                     [_map addAnnotation:annotation];
                 }
             }
             
         }
     });
     
    
}

-(void)setupView
{
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
        [self.foodCollectionView goToNextPage];
    }
    
    
    if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
        [self.foodCollectionView goToNextPage];
    }
}

//Selector for back button
-(IBAction)backToPrevious:(id)sender
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
        
    });
}
// Custom annotation view for map
-(MKAnnotationView*) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKAnnotationView *pinView = nil;
    if (annotation != mapView.userLocation) {
        static NSString *defaultPinid = @"idAnnotation";
        if (pinView == nil) {
            pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:defaultPinid];
            pinView.canShowCallout = YES;
            pinView.image = _imgBackground;
            
            SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
            int tagOfAnnotation = ((AnnotationMap *)annotation).tag;
            FoodModel *model = [_foodLoader.dataArray objectAtIndex:tagOfAnnotation];
            NSURL *imageURL = [NSURL URLWithString: model.image];
            [downloader downloadImageWithURL:imageURL
                                     options:0
                                    progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                        // progression tracking code
                                    }
                                   completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                                       if (image && finished) {
                                           // do something with imag
                                           UIImage *imgAnnotation = [self roundedImageFromImage:image size:CGSizeMake(_imgBackground.size.width-4, _imgBackground.size.width-4) withCornerRadius:_imgBackground.size.width/2-2];
                                           pinView.image = imgAnnotation;
                                           
                                       }
                                   }];
            
        }
    }
    else
    {
        [mapView.userLocation setTitle:@"Location Here"];
    }
    return pinView;
}
-(UIImage*) roundedImageFromImage:(UIImage *)image size:(CGSize)imageSize withCornerRadius:(float)cornerRadius
{
    // create circle image with white border
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, image.scale);
    CGRect bounds = (CGRect){.origin = CGPointZero,.size = imageSize};
    UIColor *borderColor = [UIColor whiteColor];
    [borderColor setFill];
    CGRect interiorBox = CGRectInset(bounds, 2.0f, 2.0f);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:interiorBox];
    [path addClip];
    [image drawInRect:bounds];
    UIImage *circleImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // overlay circle image on background image
    
    UIGraphicsBeginImageContextWithOptions(_imgBackground.size, NO, 0.0);
    [_imgBackground drawInRect:CGRectMake(0, 0, _imgBackground.size.width, _imgBackground.size.height)];
    [circleImage drawInRect:CGRectMake(2, 2, imageSize.width, imageSize.height)];
    UIImage *resultimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultimage;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
