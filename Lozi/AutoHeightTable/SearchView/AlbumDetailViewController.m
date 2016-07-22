//
//  AlbumDetailViewController.m
//  LoadSearchView
//
//  Created by AnhLTV on 7/5/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

#import "AlbumDetailViewController.h"

@interface AlbumDetailViewController ()

@end

@implementation AlbumDetailViewController
BOOL isAnnotation;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    isAnnotation = NO;
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
    CGFloat marginTopBtn = (h*0.07-h*0.03)/2;
    
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
    
    [_viewBack addSubview:searchView];

    [self.view addSubview:_viewBack];

    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _viewBack.frame.origin.y+_viewBack.frame.size.height, w, h-_viewBack.frame.size.height-_viewBack.frame.origin.y)];
    
    [self.view addSubview:_scrollView];
    
    // add map
    _map = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0, w, h/2)];
    _map.delegate = self;
    [_scrollView addSubview:_map];
    _map.mapType = MKMapTypeStandard;
    _map.zoomEnabled = YES;
    _map.scrollEnabled = YES;
    
    _cityID = @"50";
    NSString *urlComment = [NSString stringWithFormat:@"%@%@/followers?cityId=%@",[AppConfig GetSlugAlbumBase],_album._id,_cityID];
    NSLog(@"%@",urlComment);
    [self SendRequest:urlComment];
    // initial data
    _followerArray = [[NSMutableArray alloc]init];
    //add view Image
    
    _viewImage = [[UIView alloc] initWithFrame:CGRectMake(0, _map.frame.origin.y+_map.frame.size.height, w, h*0.12)];
    [self.scrollView addSubview:_viewImage];
    UIImageView *background = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _viewImage.frame.size.width, _viewImage.frame.size.height)];
    _viewImage.backgroundColor = [UIColor redColor];
    [background sd_setImageWithURL:[NSURL URLWithString: [_album.thumbnails objectAtIndex:0]] ];
    background.contentMode = UIViewContentModeScaleAspectFill;
    background.clipsToBounds = YES;
    background.alpha = 0.9;
   // [_viewImage addSubview:background];
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    
    blurEffectView.frame =  _viewImage.bounds;
   // [background addSubview:blurEffectView];

    CGFloat marginLeft = w *0.11;
    marginTop = _viewImage.frame.size.height*0.1;
    UILabel *lblName = [[UILabel alloc]initWithFrame:CGRectMake(marginLeft, marginTop, w-2*marginLeft, _viewImage.frame.size.height - 2*marginTop)];
    
    [lblName setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]];
    lblName.font = [UIFont boldSystemFontOfSize:lblName.font.pointSize];
    lblName.text = _album.name;
    [lblName setTextColor:[UIColor whiteColor]];
   // [lblName setLineBreakMode:NSLineBreakByWordWrapping];
    [lblName setNumberOfLines:2];
    lblName.adjustsFontSizeToFitWidth = NO;
    lblName.lineBreakMode = NSLineBreakByTruncatingTail;
    lblName.textAlignment = NSTextAlignmentCenter;
    [_viewImage addSubview:lblName];
    
    // add view description about Album
    _viewDescription = [[UIView alloc]initWithFrame:CGRectMake(0, _viewImage.frame.origin.y+_viewImage.frame.size.height, w, h*0.2)];
    [self.scrollView addSubview:_viewDescription];
    UILabel *lblUser = [[UILabel alloc]initWithFrame:CGRectMake(0, _viewDescription.frame.size.height *0.05, _viewDescription.frame.size.height, _viewDescription.frame.size.height*0.2)];
    [lblUser setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleCaption2]];
    lblUser.font = [UIFont boldSystemFontOfSize:lblUser.font.pointSize];
    lblUser.text = _album.username;
    [lblUser setTextColor:[UIColor blackColor]];
    [_viewDescription addSubview:lblUser];
    [lblUser sizeToFit];
    [lblUser setFrame:CGRectMake((_viewDescription.frame.size.width-lblUser.frame.size.width)/2, lblUser.frame.origin.y, lblUser.frame.size.width, lblUser.frame.size.height)];
    
    UILabel *lblDescription = [[UILabel alloc]initWithFrame:CGRectMake(w*0.1, lblUser.frame.origin.y+ lblUser.frame.size.height + _viewDescription.frame.size.height*0.05, _viewDescription.frame.size.width - w *0.2, _viewDescription.frame.size.height - lblUser.frame.origin.y - lblUser.frame.size.height - _viewDescription.frame.size.height*0.05)];
    
    [lblDescription setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleCaption1]];
    lblDescription.text = _album._description;
    [lblDescription setTextColor:[UIColor blackColor]];
    [lblDescription setLineBreakMode:NSLineBreakByWordWrapping];
    [lblDescription setNumberOfLines:0];
    [lblDescription sizeToFit];
    [_viewDescription addSubview:lblDescription];

    
    // add view for avatar of follower
    _viewFollower = [[UIView alloc]initWithFrame:CGRectMake(0, _viewDescription.frame.origin.y+_viewDescription.frame.size.height, w, h*0.16)];
     _viewFollower.backgroundColor = [UIColor colorWithRed:228.0f/255.0f green:228.0f/255.0f blue:228.0f/255.0f alpha:1];
    [self.scrollView addSubview:_viewFollower];
    UILabel *lblCount = [[UILabel alloc]initWithFrame:CGRectMake(0, _viewFollower.frame.size.height*0.1, w,1)];
   
    [lblCount setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleCaption2]];
    lblCount.font = [UIFont boldSystemFontOfSize:lblCount.font.pointSize];
    lblCount.text = [NSString stringWithFormat:@"%@ người quan tâm",_album.block];
    [lblCount setTextColor:[UIColor blackColor]];
    [lblCount setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [lblCount setLineBreakMode:NSLineBreakByWordWrapping];
    [lblCount setNumberOfLines:0];
    [lblCount sizeToFit];
    marginLeft = (w-lblCount.frame.size.width)/2;
    [lblCount setFrame:CGRectMake(marginLeft, lblCount.frame.origin.y, lblCount.frame.size.width, lblCount.frame.size.height)];
    lblCount.textAlignment = NSTextAlignmentCenter;
    [_viewFollower addSubview:lblCount];

    _scrollView.contentSize = CGSizeMake(w, _viewFollower.frame.size.height+_viewFollower.frame.origin.y+0);
    
    NSString *remainUrlBlock =[NSString stringWithFormat:@"/albums/%@/blocks?cityId=%@",_album._id,_cityID];
   FoodCollectionViewLayout* collectionLayout = [[FoodCollectionViewLayout alloc] init];
    self.foodCollectionView = [[FoodCollectionView alloc] initWithFrame:CGRectMake(0, _viewFollower.frame.origin.y+_viewFollower.frame.size.height, w, 3000) collectionViewLayout:collectionLayout];
    self.foodCollectionView.showsVerticalScrollIndicator = false;
    _foodLoader = [[FoodLoader alloc] init];
    [_foodLoader setDataLoaderDelegate:self];
    [self.foodCollectionView setDataLoader:_foodLoader withStartPage:remainUrlBlock];
    [_scrollView addSubview:self.foodCollectionView];
    _scrollView.contentSize = CGSizeMake(w, _foodCollectionView.frame.origin.y + _foodCollectionView.frame.size.height);

    
}


-(void)onDataLoadedSucessWithData
{
    

     dispatch_async(dispatch_get_main_queue(),
     ^
     {
         [self.foodCollectionView reloadData];
         if(isAnnotation == NO && _foodLoader.dataArray.count >0)
         {
             isAnnotation = YES;
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
             NSLog(@"number annotation %lu", (unsigned long)_map.annotations.count);
             
         }
     });
     
    
}

-(void)setupView
{
    CGFloat count = _followerArray.count;
    if (count > 7) {
        count = 7;
        
    }
    CGFloat sizeImage = _viewFollower.frame.size.height/3;
    CGFloat distance = 5.0f;
    CGFloat marginLeft = ([UIScreen mainScreen].bounds.size.width - (count-1)*distance - count*sizeImage)/2;
    for (int i=0; i<count; i++) {
        UserModel *user  = [_followerArray objectAtIndex:i];
        UIImageView *imgView = [[UIImageView alloc] init];
        
        CGFloat x = marginLeft + i*sizeImage + i*distance;
        [imgView setFrame:CGRectMake(x, _viewFollower.frame.size.height -sizeImage, sizeImage, sizeImage)];
        imgView.layer.cornerRadius = sizeImage/2.0f;
        imgView.layer.masksToBounds = TRUE;
        imgView.layer.borderColor = [UIColor grayColor].CGColor;
        imgView.layer.borderWidth = 1;
        [imgView setBackgroundColor: [UIColor brownColor]];
        [imgView sd_setImageWithURL:[NSURL URLWithString: user.avatar]];
        [_viewFollower addSubview:imgView];
        
        
    }

}

//Selector for back button
-(IBAction)backToPrevious:(id)sender
{
    NSLog(@"Back btn");
    
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


-(void) SendRequest : (NSString*) urlBase
{
   
      NSURL* url = [NSURL URLWithString:urlBase];
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data.length > 0 && error== nil) {
            
            NSDictionary *jsonResult = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            if (jsonResult != nil) {
                
                NSArray *dataObject = [jsonResult valueForKey:@"data"];
                if (dataObject != nil)
                {
                    for (NSDictionary* followerObj in dataObject)
                    {
                        UserModel* newUserModel = [[UserModel alloc] initWithDictionary:followerObj error:nil];
                        [self.followerArray insertObject:newUserModel atIndex:self.followerArray.count];
                                            }
                    dispatch_async(dispatch_get_main_queue(), ^{
                       
                        [self setupView];
                        
                    });
                    
                    
                }
            }
            
        }
    }];
    [task resume];
    
    
    //NSURL *url= NSURL URLWithString:(nonnull NSString *)
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
