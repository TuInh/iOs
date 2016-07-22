//
//  SearchDetailFoodViewController.m
//  LoadSearchView
//
//  Created by AnhLTV on 6/2/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

#import "SearchDetailFoodViewController.h"
#import "AnnotationMap.h"
@interface SearchDetailFoodViewController ()

@end

@implementation SearchDetailFoodViewController


- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    // Send Request to get detail
    _slug = [[AppConfig GetSlugBase] stringByAppendingString: _slug];
     NSLog(@"%@",self.slug);
   [self SendRequest:_slug typeReQuest:1];
    _commentArray = [[NSMutableArray alloc]init];
    _recommendArray = [[NSMutableArray alloc]init];
    
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
    
    //add btn back to previous scene
    UIButton *btnBack = [[UIButton alloc]init];
    btnBack.frame = CGRectMake(0, 0, h*0.03+20, _viewBack.frame.size.height);
    [btnBack setImage:[UIImage imageNamed:@"leftArrowBlue"] forState:UIControlStateNormal];
    [btnBack.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [btnBack addTarget:self action:@selector(backToPrevious:) forControlEvents:UIControlEventTouchUpInside];
    [_viewBack addSubview:btnBack];
    
    // Add view to search food
    
    CustomViewSearch *searchView = [[CustomViewSearch alloc]initWithFrame:CGRectMake(btnBack.frame.origin.x + btnBack.frame.size.width , marginTop, w*0.75, h*0.05) type:2
                                    ];
    searchView.frame = CGRectInset(searchView.frame, -borderWidth, -borderWidth);
    searchView.layer.borderWidth = borderWidth;
    searchView.layer.borderColor = [UIColor blackColor].CGColor;
    
    [_viewBack addSubview:searchView];
    [self.view addSubview:_viewBack];
    
    // Add ScrollView for all
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _viewBack.frame.origin.y+_viewBack.frame.size.height, w, h-_viewBack.frame.size.height-_viewBack.frame.origin.y )];
    _scrollView.backgroundColor = [UIColor colorWithRed:228.0f/255.0f green:228.0f/255.0f blue:228.0f/255.0f alpha:1];
    
        // Add map into scrollview
    
    
    
    UIImage *imgInitial = [UIImage imageNamed:@"marker"];
    CGFloat widthBackground = h *0.08;
    CGFloat heightBackground = widthBackground* (imgInitial.size.height/imgInitial.size.width);
    _imgBackground = imgInitial;
  

    _scrollView.contentSize = CGSizeMake(w, h-_viewBack.frame.size.height -_viewBack.frame.origin.y );
    [self.view addSubview:_scrollView];
 
    
    // initial comment Array
    
    //section comment more
    _sectionCommentArray = [[NSMutableArray alloc] init];
    _sectionRecommentArray = [[NSMutableArray alloc]init];

    
    _tableComment = [[MyTableView alloc] initWithFrame:CGRectMake(20, 20, 400, 100)];
    _tableComment.myTable.scrollEnabled = NO;
    _tableComment.sectionContents = _sectionCommentArray;
    [_scrollView addSubview:_tableComment];
    // Add Notification with more comment
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMoreComment:) name:@"Jump More comment" object:nil];
    
    _tableRecommend = [[MyTableView alloc] initWithFrame:CGRectMake(30, 130, 400, 100)];
    _tableComment.myTable.scrollEnabled = NO;
    _tableRecommend.sectionContents = _sectionRecommentArray;
    [_scrollView addSubview:_tableRecommend];
    

}

// Call for more comment of user
-(void)showMoreComment:(NSNotification*) notification
{
    
    [self GotoNextPage];
}
-(void) setupView
{
  //create View for image
    _viewAvatar = [[UIView alloc]init];
    
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = [UIScreen mainScreen].bounds.size.height*0.3;
    [_viewAvatar setFrame:CGRectMake(0, 0, w, h)];
    [_scrollView addSubview:_viewAvatar];
    // Create UIImage Background
    UIImageView *imgBacground = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _viewAvatar.frame.size.width, _viewAvatar.frame.size.height)];
    imgBacground.contentMode = UIViewContentModeScaleAspectFill;
    imgBacground.clipsToBounds = YES;
    [imgBacground sd_setImageWithURL:[NSURL URLWithString: _foodLocationModel.avatar] ];
    [_viewAvatar insertSubview:imgBacground atIndex:0];

    // create label for name
    CGFloat a = h/10;
    CGFloat marginLeft = w *0.05;
    UILabel *lblName = [[UILabel alloc]initWithFrame:CGRectMake(0 ,h*0.5, w, h*1.3*a)];
    [lblName setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]];
    lblName.font = [UIFont boldSystemFontOfSize:lblName.font.pointSize];
    lblName.text = _foodLocationModel.name;
    [lblName setTextColor:[UIColor whiteColor]];
    [lblName setLineBreakMode:NSLineBreakByCharWrapping];
    [lblName setNumberOfLines:1];
    [lblName sizeToFit];
    marginLeft = (w-lblName.frame.size.width)/2;
    [lblName setFrame:CGRectMake(marginLeft, lblName.frame.origin.y, lblName.frame.size.width, lblName.frame.size.height)];
    lblName.textAlignment = NSTextAlignmentCenter;
    [_viewAvatar addSubview:lblName];
    
    //create label category   marginLeft  = w*0.1;
    UILabel *lblCategory = [[UILabel alloc]initWithFrame:CGRectMake(marginLeft, 6.9*a, w-2*marginLeft, 0.5*a)];
    [lblCategory setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleCaption2]];
    lblCategory.text = _foodLocationModel.category;
    [lblCategory setTextColor:[UIColor whiteColor]];
    [lblCategory setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [lblCategory setLineBreakMode:NSLineBreakByCharWrapping];
    [lblCategory setNumberOfLines:0];
    [lblCategory sizeToFit];
    marginLeft = (w-lblCategory.frame.size.width)/2;
   [lblCategory setFrame:CGRectMake(marginLeft, lblCategory.frame.origin.y, lblCategory.frame.size.width, lblCategory.frame.size.height)];
    lblCategory.textAlignment = NSTextAlignmentCenter;
    [_viewAvatar addSubview:lblCategory];
    
    // create label from
    UILabel *lblFrom = [[UILabel alloc]initWithFrame:CGRectMake(0, 8.3*a, w, 0.5*a)];
    [lblFrom setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleCaption2]];
    lblFrom.text = @" từ ";
    lblFrom.textColor = [UIColor whiteColor];
    [lblFrom setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [lblFrom setLineBreakMode:NSLineBreakByCharWrapping];
    [lblFrom setNumberOfLines:0];
    [lblFrom sizeToFit];
    [lblFrom setFrame:CGRectMake(0, lblFrom.frame.origin.y, lblFrom.frame.size.width, lblFrom.frame.size.height)];
    [lblFrom setTextAlignment:NSTextAlignmentCenter];
    [_viewAvatar addSubview:lblFrom];
    //
    NSInteger count = _commentArray.count ;
    a = lblFrom.frame.size.width *1.4;
    
    BOOL isRetain = NO;
    if (count>=6) {
        count = 6;
        isRetain = YES;
        
    }
    float distance = 3;
    if (isRetain == YES) {
        marginLeft = (w -(count+2)*distance-(count+2)*a - 1.2*a)/2;
    }
    else
    {
        marginLeft = (w - (count+1)*distance - (count+1)*a - 1.2*a)/2;
    }
    [lblFrom setFrame:CGRectMake(0, lblFrom.frame.origin.y, lblFrom.frame.size.width, a)];
    
    // Label rating
    UILabel *lblRating = [[UILabel alloc] initWithFrame:CGRectMake(marginLeft, lblFrom.frame.origin.y, lblFrom.frame.size.width*1.2, a/1.4)];
    [lblRating setBackgroundColor:[UIColor greenColor]];
    lblRating.layer.cornerRadius = 5.0f;
    lblRating.layer.masksToBounds = YES;
    lblRating.text = @"4.2";
    lblRating.textColor = [UIColor whiteColor];
    lblRating.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption2];
    lblRating.font = [UIFont boldSystemFontOfSize:lblRating.font.pointSize];
    lblRating.textAlignment = NSTextAlignmentCenter;
    [_viewAvatar addSubview:lblRating];
    [lblFrom setFrame:CGRectMake(lblRating.frame.origin.x +distance + lblRating.frame.size.width, lblRating.frame.origin.y,lblRating.frame.size.width, lblRating.frame.size.height)];
    CGFloat retainX = 0,retainY = 0;
    for (int i=0; i<count; i++) {
        CommentModel *comment  = [_commentArray objectAtIndex:i];
        UIImageView *imgView = [[UIImageView alloc] init];
    
        CGFloat x = lblFrom.frame.origin.x + lblFrom.frame.size.width +(i+1)*distance + i*a;
        [imgView setFrame:CGRectMake(x, lblFrom.frame.origin.y, a, a)];
        imgView.layer.cornerRadius = a/2.0f;
        imgView.layer.masksToBounds = TRUE;
        imgView.layer.borderColor = [UIColor blackColor].CGColor;
        imgView.layer.borderWidth = 1;
        [imgView setBackgroundColor: [UIColor brownColor]];
        [imgView sd_setImageWithURL:[NSURL URLWithString: comment.avatar]];
        [_viewAvatar addSubview:imgView];
        if (i == count -1) {
            retainX = imgView.frame.origin.x;
            retainY = imgView.frame.origin.y;
            
        }
        
    }
    if (isRetain == YES) {
        UILabel *lblRetain = [[UILabel alloc]initWithFrame:CGRectMake(retainX + a+ distance, retainY, a, a)];
        float retain = _foodLocationModel.comment - count;
        lblRetain.text =  [[NSNumber numberWithFloat: retain] stringValue];
        lblRetain.textColor = [UIColor whiteColor];
        lblRetain.backgroundColor = [UIColor clearColor];
        lblRetain.layer.cornerRadius = a/2;
        [lblRetain setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleCaption2]];
        lblRetain.layer.borderColor = [UIColor whiteColor].CGColor;
        lblRetain.layer.borderWidth = 0.7f;
        lblRetain.textAlignment = NSTextAlignmentCenter;
        [_viewAvatar addSubview:lblRetain];
        
    }
    distance = 5;
    NSArray *lstImage = [[NSArray alloc]init];
    lstImage = _foodLocationModel.photos;
    CGFloat margin = a/2;
    CGFloat heightOfImage = (w - distance*3 - 2* margin)/4;
    CGFloat posYOfMenuView = 0;
    for (int i =0; i< 4; i++) {
        CGFloat x = margin + i *distance + i * heightOfImage;
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(x,_viewAvatar.frame.origin.y + _viewAvatar.frame.size.height + margin,  heightOfImage, heightOfImage)];
        imgView.clipsToBounds = YES;
        imgView.layer.cornerRadius = 5.0f;
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView.backgroundColor = [UIColor whiteColor];
        if (i<lstImage.count) {
             [imgView sd_setImageWithURL:[NSURL URLWithString: [lstImage objectAtIndex:i]]];
        }
       
        [_scrollView addSubview:imgView];
        posYOfMenuView = imgView.frame.origin.y + imgView.frame.size.height + margin;
        
    }
    _viewMenu = [[UIView alloc]initWithFrame:CGRectMake(margin, posYOfMenuView, w - 2 *margin, heightOfImage*1.5)];
    _viewMenu.backgroundColor = [UIColor whiteColor];
    _viewMenu.layer.cornerRadius = 5.0f;
    _viewMenu.clipsToBounds = YES;
    [_scrollView addSubview:_viewMenu];
    margin = 10;
    UIImageView *imgViewMenu = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"meoTreoCay"]];
    [imgViewMenu setFrame:CGRectMake(margin, 0, _viewMenu.frame.size.height*2/3, _viewMenu.frame.size.height*2/3)];
    [_viewMenu addSubview:imgViewMenu];
    
    UILabel *lblTitleReason = [[UILabel alloc]initWithFrame:CGRectMake(imgViewMenu.frame.origin.x+imgViewMenu.frame.size.width+ margin, 0, w, 1)];
    [lblTitleReason setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleCaption2]];
    lblTitleReason.text = @"Mọi người đến đây vì: ";
    lblTitleReason.textColor = [UIColor blackColor];
    [lblTitleReason setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [lblTitleReason setLineBreakMode:NSLineBreakByCharWrapping];
    [lblTitleReason setNumberOfLines:0];
    [lblTitleReason sizeToFit];
    [lblTitleReason setTextAlignment:NSTextAlignmentLeft];
    
    UILabel *lblReason = [[UILabel alloc]initWithFrame:CGRectMake(lblTitleReason.frame.origin.x, lblTitleReason.frame.size.height+ lblTitleReason.frame.origin.y, w, 1)];
    [lblReason setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleCaption1]];
    if ([_foodLocationModel.name containsString:@"-"] == YES) {
        lblReason.text =[[ _foodLocationModel.name componentsSeparatedByString:@"-"] objectAtIndex:0] ;
    }
    
    lblReason.textColor = [UIColor blackColor];
    [lblReason setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [lblReason setLineBreakMode:NSLineBreakByCharWrapping];
    [lblReason setNumberOfLines:0];
    lblReason.font = [UIFont boldSystemFontOfSize:lblReason.font.pointSize];
    [lblReason sizeToFit];
    [lblReason setTextAlignment:NSTextAlignmentLeft];

    [lblTitleReason setFrame:CGRectMake(lblTitleReason.frame.origin.x, _viewMenu.frame.size.height/2 -( lblReason.frame.origin.y+lblReason.frame.size.height-lblTitleReason.frame.origin.y), lblTitleReason.frame.size.width, lblTitleReason.frame.size.height)];
    [lblReason setFrame:CGRectMake(lblReason.frame.origin.x, lblTitleReason.frame.size.height+lblTitleReason.frame.origin.y, lblReason.frame.size.width, lblReason.frame.size.height)];
    [_viewMenu addSubview:lblTitleReason];
    [_viewMenu addSubview:lblReason];
    
    imgViewMenu.contentMode = UIViewContentModeScaleAspectFit;
       UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, _viewMenu.frame.size.height*2/3)];
    [path addLineToPoint:CGPointMake(_viewMenu.frame.size.width,_viewMenu.frame.size.height*2/3 )];
    
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [path CGPath];
    shapeLayer.strokeColor = [[UIColor grayColor] CGColor];
    shapeLayer.lineWidth = 1.0;
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
   
    [_viewMenu.layer addSublayer:shapeLayer];
    
    
    UIButton *btnMenu = [[UIButton alloc] initWithFrame:CGRectMake(0, _viewMenu.frame.size.height * 4/6, _viewMenu.frame.size.width, _viewMenu.frame.size.height * 1/6)];
    [btnMenu setTitle:@"Xem toàn bộ Menu" forState:UIControlStateNormal];
    [btnMenu setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btnMenu.titleLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleCaption1]];
    btnMenu.titleLabel.font = [UIFont boldSystemFontOfSize:btnMenu.titleLabel.font.pointSize];
    [btnMenu sizeToFit];
    [btnMenu addTarget:self action:@selector(showMenu:) forControlEvents:UIControlEventTouchUpInside];
    [btnMenu setFrame:CGRectMake((_viewMenu.frame.size.width - btnMenu.frame.size.width)/2, _viewMenu.frame.size.height * 5/6 - btnMenu.frame.size.height/2, btnMenu.frame.size.width, btnMenu.frame.size.height)];
    [_viewMenu addSubview:btnMenu];
    _viewMap = [[UIView alloc]initWithFrame:CGRectMake(0, _viewMenu.frame.origin.y + margin+ _viewMenu.frame.size.height, w, h*1.5)];
    _viewMap.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_viewMap];
    
    
    
    // Add map View
    
    _map = [[MKMapView alloc]init];
    [_map setDelegate:self];
    _map.frame = CGRectMake(3, 3, _viewMap.frame.size.width-6, _viewMap.frame.size.height*0.37-3);
    _map.mapType = MKMapTypeStandard;
    _map.zoomEnabled = YES;
    _map.scrollEnabled = YES;
    //  [_scrollView addSubview:_mapView];
     CLLocationDegrees lattitude = _foodLocationModel.latitude;
     CLLocationDegrees longtitude = _foodLocationModel.longitude;
   // CLLocationDegrees lattitude = 0;
   // CLLocationDegrees longtitude = -79.006424;
    CLLocationDegrees latDelta = 0.005;
    CLLocationDegrees lonDelta = 0.005;
    MKCoordinateSpan span = MKCoordinateSpanMake(latDelta, lonDelta);
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(lattitude, longtitude);
    MKCoordinateRegion region =  MKCoordinateRegionMake(location, span);
    [_map setRegion:region];
    // Add custom annotation for mapkit
    AnnotationMap *annotation = [[AnnotationMap alloc]init];
    annotation.coordinate = location;
    annotation.title = @"Here";
    [_map addAnnotation:annotation];
    
    // add description for view map
    CGFloat sizeEachIcon = (_viewMap.frame.size.height-_map.frame.size.height)/10;
    UIImageView *imgLocation = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"locationRed"]];
    [imgLocation setFrame:CGRectMake(margin, _map.frame.size.height+_map.frame.origin.y+ margin, sizeEachIcon, sizeEachIcon)];
    imgLocation.contentMode = UIViewContentModeScaleAspectFit;
    [_viewMap addSubview:imgLocation];
    
    UILabel *lblLocation = [[UILabel alloc] initWithFrame:CGRectMake(margin+ imgLocation.frame.origin.x + imgLocation.frame.size.width, imgLocation.frame.origin.y, _viewMap.frame.size.width-imgLocation.frame.origin.x - imgLocation.frame.size.width- margin, sizeEachIcon)];
    lblLocation.textColor = [UIColor blackColor];
    [lblLocation setNumberOfLines:1];
    lblLocation.adjustsFontSizeToFitWidth = NO;
    lblLocation.lineBreakMode = NSLineBreakByTruncatingTail;
    lblLocation.font = [UIFont boldSystemFontOfSize:lblReason.font.pointSize];
    lblLocation.text = _foodLocationModel.fulladdress;
    [lblLocation setTextAlignment:NSTextAlignmentLeft];
    [lblLocation setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleCaption1]];
    
    [_viewMap addSubview:lblLocation];
    
    UIImageView *imgMoney = [[UIImageView alloc] initWithFrame:CGRectMake(imgLocation.frame.origin.x , imgLocation.frame.origin.y+ imgLocation.frame.size.height+margin, sizeEachIcon, sizeEachIcon)];
    imgMoney.contentMode = UIViewContentModeScaleAspectFit;
    [imgMoney setImage:[UIImage imageNamed:@"priceRed"]];
    [_viewMap addSubview:imgMoney];
    
    UILabel *lblMoney = [[UILabel alloc] initWithFrame:CGRectMake(lblLocation.frame.origin.x , imgMoney.frame.origin.y, lblLocation.frame.size.width, sizeEachIcon)];
    lblMoney.textColor = [UIColor blackColor];
    [lblMoney setNumberOfLines:1];
    lblMoney.adjustsFontSizeToFitWidth = NO;
    lblMoney.lineBreakMode = NSLineBreakByTruncatingTail;
    lblMoney.font = [UIFont boldSystemFontOfSize:lblReason.font.pointSize];
    lblMoney.text = [NSString stringWithFormat:@"%@ đ/2 người", _foodLocationModel.priceCouple];
    [lblMoney setTextAlignment:NSTextAlignmentLeft];
    [lblMoney setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleCaption1]];
    
    [_viewMap addSubview:lblMoney];

    UIImageView *imgTime = [[UIImageView alloc] initWithFrame:CGRectMake(imgMoney.frame.origin.x , imgMoney.frame.origin.y+ imgMoney.frame.size.height+margin, sizeEachIcon, sizeEachIcon)];
    imgTime.contentMode = UIViewContentModeScaleAspectFit;
    [imgTime setImage:[UIImage imageNamed:@"clockRed"]];
    [_viewMap addSubview:imgTime];
    
    UILabel *lblTime = [[UILabel alloc] initWithFrame:CGRectMake(lblLocation.frame.origin.x , imgTime.frame.origin.y, lblLocation.frame.size.width, sizeEachIcon)];
    lblTime.textColor = [UIColor blackColor];
    [lblTime setNumberOfLines:1];
    lblTime.adjustsFontSizeToFitWidth = NO;
    lblTime.lineBreakMode = NSLineBreakByTruncatingTail;
    lblTime.font = [UIFont boldSystemFontOfSize:lblReason.font.pointSize];
    if (_foodLocationModel.operatingTime.count >0) {
        
        NSDictionary *time = _foodLocationModel.operatingTime[0];
        NSString *timeStart = [[time valueForKey:@"start"] stringByAppendingString: @" - "];
        [lblTime setText:[timeStart stringByAppendingString:[time valueForKey:@"finish"]]];
        [lblTime setTextAlignment:NSTextAlignmentLeft];
    }
    else
    {
        
        [lblTime setText:@"0:00AM - 0:00AM"];
    }

   
    [lblTime setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleCaption1]];
    
    [_viewMap addSubview:lblTime];
    [_viewMap addSubview:_map];
    
    // add View Call if shop have phone number
    NSLog(@"phone number is %@",_foodLocationModel.phoneNumber);
    if (_foodLocationModel.phoneNumber.length >0) {
        UIView *viewCall = [[UIView alloc]initWithFrame:CGRectMake(imgTime.frame.origin.x+imgTime.frame.size.width, lblTime.frame.origin.y+ +lblTime.frame.size.height +sizeEachIcon, _viewMap.frame.size.width/3, 50)];
        viewCall.layer.cornerRadius = 5;
        viewCall.backgroundColor = [UIColor greenColor];
        [viewCall setFrame:CGRectMake(viewCall.frame.origin.x, viewCall.frame.origin.y, _viewMap.frame.size.width- 2* viewCall.frame.origin.x, _viewMap.frame.size.height - viewCall.frame.origin.y-sizeEachIcon)];
        UIImageView *imgCall = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"phoneWhite"]];
        [imgCall setFrame:CGRectMake(0, sizeEachIcon, sizeEachIcon, sizeEachIcon)];
        [viewCall addSubview:imgCall];
        
        UILabel *lblPhoneNumber = [[UILabel alloc]initWithFrame:CGRectMake(imgCall.frame.size.width+imgCall.frame.origin.x+ sizeEachIcon/2, imgCall.frame.origin.y, viewCall.frame.size.width/3, imgCall.frame.size.height)];
        lblPhoneNumber.textColor = [UIColor whiteColor];
        [lblPhoneNumber setNumberOfLines:1];
        [lblPhoneNumber setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        lblPhoneNumber.lineBreakMode = NSLineBreakByTruncatingTail;
        [lblPhoneNumber setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleCallout]];
        lblPhoneNumber.font = [UIFont boldSystemFontOfSize:lblPhoneNumber.font.pointSize];
        [lblPhoneNumber setText:_foodLocationModel.phoneNumber];
        [lblPhoneNumber sizeToFit];
        
        [viewCall addSubview:lblPhoneNumber];
        
        [imgCall setFrame:CGRectMake((viewCall.frame.size.width- lblPhoneNumber.frame.size.width-lblPhoneNumber.frame.origin.x)/2, (viewCall.frame.size.height - imgCall.frame.size.height)/2, imgCall.frame.size.width, imgCall.frame.size.height)];
        [lblPhoneNumber setFrame:CGRectMake(imgCall.frame.origin.x+imgCall.frame.size.width+ sizeEachIcon/2, imgCall.frame.origin.y, lblPhoneNumber.frame.size.width, lblPhoneNumber.frame.size.height)];
        UITapGestureRecognizer *singleFingerTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(handleCall:)];
        [viewCall
         addGestureRecognizer:singleFingerTap];
        
        [_viewMap addSubview:viewCall];

    }
    else
    {
        [_viewMap setFrame:CGRectMake(_viewMap.frame.origin.x, _viewMap.frame.origin.y, _viewMap.frame.size.width, lblTime.frame.origin.y + sizeEachIcon+ lblTime.frame.size.height)];
    }
    
    
    
    
    // add Button to call
    
    

    
    //Update Table View Height
    [_tableComment setFrame:CGRectMake(margin,_viewMap.frame.origin.y + margin + _viewMap.frame.size.height, w - 2*margin,_tableComment.myTable.contentSize.height)];
    [_tableComment.myTable setFrame:CGRectMake(0, 0, w - 2*margin,_tableComment.myTable.contentSize.height)];
    _tableComment.backgroundColor = [UIColor colorWithRed:228.0f/255.0f green:228.0f/255.0f blue:228.0f/255.0f alpha:1];

    
    [_tableRecommend setFrame:CGRectMake(margin,_tableComment.frame.origin.y  + _tableComment.frame.size.height, w - 2*margin,_tableRecommend.myTable.contentSize.height)];
    [_tableRecommend.myTable setFrame:CGRectMake(0, 0, w - 2*margin,_tableRecommend.myTable.contentSize.height)];
    
    _tableRecommend.backgroundColor = [UIColor colorWithRed:228.0f/255.0f green:228.0f/255.0f blue:228.0f/255.0f alpha:1];

    _scrollView.backgroundColor = [UIColor colorWithRed:228.0f/255.0f green:228.0f/255.0f blue:228.0f/255.0f alpha:1];

    //Update Scroll View Content Size
    _scrollView.contentSize = CGSizeMake(w, _tableRecommend.frame.origin.y + _tableRecommend.frame.size.height + 10.0f);
}
- (IBAction)showMenu:(id)sender
{
   MenuFoodLocationViewController *menuViewController = [[MenuFoodLocationViewController alloc] init];
    menuViewController._id = _foodLocationModel._id;
   [self presentViewController:menuViewController animated:NO completion:nil];
    
}
//The event handling method - calling to Shop
- (void)handleCall:(UITapGestureRecognizer *)recognizer {
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:_foodLocationModel.phoneNumber
                                  message:@""
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Call"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             NSString *number = [_foodLocationModel.phoneNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
                             number = [number stringByReplacingOccurrencesOfString:@")" withString:@""];
                              number = [number stringByReplacingOccurrencesOfString:@" " withString:@""];
                             number = [number stringByReplacingOccurrencesOfString:@"-" withString:@""];
                             number = [number stringByReplacingOccurrencesOfString:@"_" withString:@""];
                             number = [number stringByReplacingOccurrencesOfString:@"." withString:@""];
                             NSString *phoneNumber = [@"tel://" stringByAppendingString:number];
                             [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
                            // [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    [alert addAction:ok];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}

//Selector for back button
-(IBAction)backToPrevious:(id)sender
{
    NSLog(@"Back btn");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
                
    });
}

-(void) SendRequest:(NSString *) urlBase typeReQuest:(int)type
{
   
    NSURL* url = [NSURL URLWithString:urlBase];
    NSLog(@"%@",url);
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       // NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
       // NSLog(@"%@",str);
        if (data.length > 0 && error== nil) {
            
            NSDictionary *jsonResult = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            if (jsonResult != nil) {
                if(type == 1)
                {
                    NSDictionary *dataObject = [jsonResult valueForKey:@"data"];
                    if (dataObject != nil) {
              
                    _foodLocationModel = [[FoodLocationModel alloc] initWithDictionary:dataObject error:nil];
                    NSString *slugCmt = [_slug stringByAppendingString:@"/comments"];
                    NSString *slugRecommend = [_slug stringByAppendingString:@"/recommend"];
                    [self SendRequest:slugCmt typeReQuest:2];
                                            
                    }
                                    }
                else if (type == 2 )
                    
                {
                    
                        NSArray *dataObject = [jsonResult valueForKey:@"data"];
                        for (NSDictionary* commentObj in dataObject) {
                            CommentModel *newCommentModel = [[CommentModel alloc]initWithDictionary:commentObj error:nil];
                            [self.commentArray insertObject:newCommentModel atIndex:self.commentArray.count];
                            
                            
                            
                            
                        }
                        NSDictionary *pagnationObject = [jsonResult valueForKey:@"pagination"];
                        if (pagnationObject !=nil) {
                            
                            NSString* nextUrl = [pagnationObject valueForKey:@"nextUrl"];
                            // if ((nextUrl != nil) && (nextUrl.length > 0))
                            if(![nextUrl isKindOfClass:[NSNull class]])
                            {
                                self.nextURl = nextUrl;
                            }
                            else
                            {
                                self.nextURl = @"";
                            }
                            
                        }
                        
                        
                        if (_sectionCommentArray.count == 0) {
                            NSMutableDictionary* commentDictitionary = [[NSMutableDictionary alloc] init];
                            [commentDictitionary setObject: _commentArray forKey: @"content"];
                            [commentDictitionary setObject: [NSNumber numberWithInt:6] forKey: @"type"];
                            [commentDictitionary setObject: @"Comment" forKey: @"caption"];
                            [self.sectionCommentArray addObject:commentDictitionary];
                            
                            NSMutableDictionary* moreDictionary = [[NSMutableDictionary alloc] init];
                            [moreDictionary setObject:[NSArray arrayWithObjects: @"Xem thêm bình luận", nil] forKey: @"content"];
                            [moreDictionary setObject: [NSNumber numberWithInt:5] forKey: @"type"];
                            [moreDictionary setObject: @"More commnent" forKey: @"caption"];
                            [self.sectionCommentArray addObject:moreDictionary];
                            
                        }

                    
                    NSString *slugRecommend = [_slug stringByAppendingString:@"/recommend"];
                    [self SendRequest:slugRecommend typeReQuest:3];
                 
                    
                    
                    
                    
                }
                else if (type==3) {
                    NSArray *dataObject = [jsonResult valueForKey:@"data"];
                    for (NSDictionary* recommentObj in dataObject) {
                        
                        if (self.recommendArray.count < 3) {
                            RecommendModel *newRecommendModel = [[RecommendModel alloc]initWithDictionary:recommentObj error:nil];
                            [self.recommendArray insertObject:newRecommendModel atIndex:self.recommendArray.count];

                        }
                        
                        if (_sectionRecommentArray.count == 0) {
                            NSMutableDictionary* moreDictionary = [[NSMutableDictionary alloc] init];
                            [moreDictionary setObject:[NSArray arrayWithObjects: @"Địa điểm liên quan", nil] forKey: @"content"];
                            [moreDictionary setObject: [NSNumber numberWithInt:7] forKey: @"type"];
                            [moreDictionary setObject: @"More Recommnent" forKey: @"caption"];
                            [self.sectionRecommentArray addObject:moreDictionary];
                            
                            NSMutableDictionary* commentDictitionary = [[NSMutableDictionary alloc] init];
                            [commentDictitionary setObject: _recommendArray forKey: @"content"];
                            [commentDictitionary setObject: [NSNumber numberWithInt:8 ] forKey: @"type"];
                            [commentDictitionary setObject: @"Comment" forKey: @"caption"];
                            [self.sectionRecommentArray addObject:commentDictitionary];
                            
                            
                            
                        }
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [_tableComment.myTable reloadData];
                            
                            [_tableRecommend.myTable reloadData];
                            [self setupView];
                            
                        });
                        
                        
                    }
                    
                }
               
                
                
            }
            
        }
    }];
    [task resume];
    
    
    //NSURL *url= NSURL URLWithString:(nonnull NSString *)
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
            NSURL *imageURL = [NSURL URLWithString: _foodLocationModel.avatar];
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
-(UIImage *)roundedImage:(UIImage *)image size:(CGSize)imageSize corlorBorder:(UIColor*) borderColor
{
    // create circle image with white border
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, image.scale);
    CGRect bounds = (CGRect){.origin = CGPointZero,.size = imageSize};
    [borderColor setFill];
    [[UIBezierPath bezierPathWithOvalInRect:bounds] fill];
    CGRect interiorBox = CGRectInset(bounds, 2.0f, 2.0f);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:interiorBox];
    [path addClip];
    [image drawInRect:bounds];
    UIImage *circleImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return circleImage;
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

// Resize Image
-(UIImage*) resizeImage:(UIImage*)imageOrigin newSize:(CGSize) size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, imageOrigin.scale);
    [imageOrigin drawInRect:CGRectMake(0,0, size.width, size.height)];
    UIImage *imageResult = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageResult;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) GotoNextPage
{
    if (self.nextURl.length > 0)
    {
        self.currentURl = [[AppConfig GetBaseNextPageUrl] stringByAppendingString: self.nextURl];
        NSLog(@"nexturl %@",self.currentURl);
        [self SendRequest:self.currentURl typeReQuest:2];
    }
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
