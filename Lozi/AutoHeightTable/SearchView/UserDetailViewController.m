//
//  UserDetailViewController.m
//  LoadSearchView
//
//  Created by AnhLTV on 7/9/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

#import "UserDetailViewController.h"

@interface UserDetailViewController ()

@end

@implementation UserDetailViewController
bool IsHaveAblum;
int stateOfBtn;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:228.0f/255.0f green:228.0f/255.0f blue:228.0f/255.0f alpha:1];
    CGSize size = [UIScreen mainScreen].bounds.size;
    CGFloat w = size.width;
    CGFloat h = size.height;
    CGFloat borderWidth = 3.0f;
    stateOfBtn = 1;
  
   

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
    
    CustomViewSearch *searchView = [[CustomViewSearch alloc]initWithFrame:CGRectMake(btnBack.frame.origin.x + btnBack.frame.size.width, marginTop, w*0.75, h*0.05) type:2
                                    ];
    searchView.frame = CGRectInset(searchView.frame, -borderWidth, -borderWidth);
    searchView.layer.borderWidth = borderWidth;
    searchView.layer.borderColor = [UIColor blackColor].CGColor;
    
    [_viewBack addSubview:searchView];
    
    [self.view addSubview:_viewBack];
    
    // add scroll View
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _viewBack.frame.origin.y+_viewBack.frame.size.height, w, h-_viewBack.frame.size.height-_viewBack.frame.origin.y)];
    
    [self.view addSubview:_scrollView];

    //add view Avatar to scrollView
    _viewAvatar = [[UIView alloc]initWithFrame:CGRectMake(0,0, w, h*0.4)];
    [_scrollView addSubview:_viewAvatar];
    _scrollView.backgroundColor = [UIColor colorWithRed:228.0f/255.0f green:228.0f/255.0f blue:228.0f/255.0f alpha:1];
    UIImageView *background = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _viewAvatar.frame.size.width, _viewAvatar.frame.size.height)];
    [_viewAvatar insertSubview:background atIndex:0];
     [background sd_setImageWithURL:[NSURL URLWithString: _user.avatar] ];
    background.contentMode = UIViewContentModeScaleToFill;
    background.clipsToBounds = YES;
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    
    blurEffectView.frame =  _viewAvatar.bounds;
    [background addSubview:blurEffectView];
    CGFloat heightImage = _viewAvatar.frame.size.height/3;
    UIImageView *imgAvatar = [[UIImageView alloc]initWithFrame:CGRectMake(_viewAvatar.frame.size.width/2- heightImage/2, heightImage/2, heightImage, heightImage)];
    [imgAvatar sd_setImageWithURL:[NSURL URLWithString: _user.avatar] ];
    imgAvatar.contentMode = UIViewContentModeScaleAspectFill;
    imgAvatar.clipsToBounds = YES;
    imgAvatar.layer.cornerRadius = heightImage/2;
    [_viewAvatar addSubview:imgAvatar];
    
    UILabel *lblName = [[UILabel alloc]initWithFrame:CGRectMake(heightImage/2, imgAvatar.frame.size.height+imgAvatar.frame.origin.y+ heightImage/3, w, heightImage)];
    [lblName setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]];
    [lblName setTextColor:[UIColor whiteColor]];
    [lblName setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [lblName setLineBreakMode:NSLineBreakByCharWrapping];
    [lblName setNumberOfLines:0];
    [lblName setFont:[UIFont boldSystemFontOfSize:lblName.font.pointSize]];
    [lblName setText:_user.fullname];
    [lblName sizeToFit];
    CGFloat marginLeftName = (_viewAvatar.frame.size.width - lblName.frame.size.width)/2;
    [lblName setFrame:CGRectMake(marginLeftName, lblName.frame.origin.y, lblName.frame.size.width, lblName.frame.size.height)];
    [_viewAvatar addSubview:lblName];
    
 
    
    UILabel *lblAddress = [[UILabel alloc]initWithFrame:CGRectMake(heightImage/2, lblName.frame.size.height+lblName.frame.origin.y+ heightImage/8, w, heightImage)];
    [lblAddress setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleCaption1]];
    [lblAddress setTextColor:[UIColor whiteColor]];
    [lblAddress setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [lblAddress setLineBreakMode:NSLineBreakByCharWrapping];
    [lblAddress setNumberOfLines:0];
    NSString *gender = @"Nữ";
    if ([_user.gender isEqualToString:@"male"]) {
        gender = @"Nam";
    }
    [lblAddress setText:[NSString stringWithFormat:@"%@,%@",gender,_user.city]];
    [lblAddress sizeToFit];
     marginLeftName = (_viewAvatar.frame.size.width - lblAddress.frame.size.width)/2;
    [lblAddress setFrame:CGRectMake(marginLeftName, lblAddress.frame.origin.y, lblAddress.frame.size.width, lblAddress.frame.size.height)];
    [_viewAvatar addSubview:lblAddress];
    
    UIButton *btnCare = [[UIButton alloc]initWithFrame:CGRectMake(0, lblAddress.frame.size.height+lblAddress.frame.origin.y+heightImage/8, w, heightImage)];
    [btnCare setTitle:@"Quan tâm" forState:UIControlStateNormal];
    [btnCare setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnCare.titleLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleCaption1]];
    [btnCare setBackgroundColor:[UIColor colorWithRed:237.0f/255.0f green:53.0f/255.0f blue:84.0f/255.0f alpha:1]];
    [btnCare.titleLabel setFont:[UIFont boldSystemFontOfSize:btnCare.titleLabel.font.pointSize]];
    btnCare.layer.cornerRadius = 5;
    [btnCare sizeToFit];
    marginLeftName = (_viewAvatar.frame.size.width - btnCare.frame.size.width*1.2)/2;
    [btnCare setFrame:CGRectMake(marginLeftName, btnCare.frame.origin.y, btnCare.frame.size.width*1.2, btnCare.frame.size.height)];
    [btnCare addTarget:self action:@selector(careUser:) forControlEvents:UIControlEventTouchUpInside];
    [_viewAvatar addSubview:btnCare];
    
    
    // Add view follower
    _viewFollower = [[UIView alloc]initWithFrame:CGRectMake(_viewAvatar.frame.origin.x, _viewAvatar.frame.origin.y + _viewAvatar.frame.size.height, _viewAvatar.frame.size.width, heightImage/2)];
    _viewFollower.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_viewFollower];
    CGFloat eachFollower = _viewFollower.frame.size.width/3;
    UILabel *follower = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, eachFollower, 1)];
    [follower setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleCaption2]];
    [follower setTextColor:[UIColor blackColor]];
    [follower setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [follower setLineBreakMode:NSLineBreakByCharWrapping];
    [follower setNumberOfLines:0];
    [follower setFont:[UIFont boldSystemFontOfSize:follower.font.pointSize]];
    [follower setText:_user.follower];
    [follower sizeToFit];
    
    UILabel *followerDes = [[UILabel alloc]initWithFrame:CGRectMake(0, follower.frame.origin.y+follower.frame.size.height, eachFollower, 1)];
    [followerDes setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleCaption2]];
    [followerDes setTextColor:[UIColor blackColor]];
    [followerDes setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [followerDes setLineBreakMode:NSLineBreakByCharWrapping];
    [followerDes setNumberOfLines:0];
    [followerDes setText:@"người quan tâm"];
    [followerDes sizeToFit];
    
    marginTop = (_viewFollower.frame.size.height- (followerDes.frame.size.height+followerDes.frame.origin.y -follower.frame.origin.y ))/2;
    [follower setFrame:CGRectMake((eachFollower - follower.frame.size.width)/2, marginTop, follower.frame.size.width, follower.frame.size.height)];
    [followerDes setFrame:CGRectMake((eachFollower - followerDes.frame.size.width)/2, follower.frame.origin.y+ follower.frame.size.height, followerDes.frame.size.width, followerDes.frame.size.height)];
    
    [_viewFollower addSubview:follower];
    [_viewFollower addSubview:followerDes];

   
    UILabel *following = [[UILabel alloc]initWithFrame:CGRectMake(eachFollower,follower.frame.origin.y, eachFollower, 1)];
    [following setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleCaption2]];
    [following setTextColor:[UIColor blackColor]];
    [following setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [following setLineBreakMode:NSLineBreakByCharWrapping];
    [following setNumberOfLines:0];
    [following setFont:[UIFont boldSystemFontOfSize:follower.font.pointSize]];
    [following setText:_user.followingUser];
    [following sizeToFit];
    [following setFrame:CGRectMake(eachFollower +(eachFollower-following.frame.size.width)/2, following.frame.origin.y, following.frame.size.width, following.frame.size.height)];

    [_viewFollower addSubview:following];
    UILabel *followingDes = [[UILabel alloc]initWithFrame:CGRectMake(eachFollower, following.frame.origin.y+following.frame.size.height, eachFollower, 1)];
    [followingDes setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleCaption2]];
    [followingDes setTextColor:[UIColor blackColor]];
    [followingDes setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [followingDes setLineBreakMode:NSLineBreakByCharWrapping];
    [followingDes setNumberOfLines:0];
    [followingDes setText:@"đang quan tâm"];
    [followingDes sizeToFit];
    [followingDes setFrame:CGRectMake(eachFollower+(eachFollower-followingDes.frame.size.width)/2, followingDes.frame.origin.y, followingDes.frame.size.width, followingDes.frame.size.height)];
    [_viewFollower addSubview:followingDes];
    
    
    UILabel *pin = [[UILabel alloc]initWithFrame:CGRectMake(2*eachFollower,follower.frame.origin.y, eachFollower, 1)];
    [pin setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleCaption2]];
    [pin setTextColor:[UIColor blackColor]];
    [pin setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [pin setLineBreakMode:NSLineBreakByCharWrapping];
    [pin setNumberOfLines:0];
    [pin setFont:[UIFont boldSystemFontOfSize:follower.font.pointSize]];
    [pin setText:_user.pin];
    [pin sizeToFit];
    [pin setFrame:CGRectMake(2*eachFollower +(eachFollower-pin.frame.size.width)/2, pin.frame.origin.y, pin.frame.size.width, pin.frame.size.height)];
    
    [_viewFollower addSubview:pin];
    UILabel *pinDes = [[UILabel alloc]initWithFrame:CGRectMake(2*eachFollower, pin.frame.origin.y+pin.frame.size.height, eachFollower, 1)];
    [pinDes setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleCaption2]];
    [pinDes setTextColor:[UIColor blackColor]];
    [pinDes setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [pinDes setLineBreakMode:NSLineBreakByCharWrapping];
    [pinDes setNumberOfLines:0];
    [pinDes setText:@"lượt ghim"];
    [pinDes sizeToFit];
    [pinDes setFrame:CGRectMake(2*eachFollower+(eachFollower-pinDes.frame.size.width)/2, pinDes.frame.origin.y, pinDes.frame.size.width, pinDes.frame.size.height)];
    [_viewFollower addSubview:pinDes];

    
    _lblTitleAlbum = [[UILabel alloc]initWithFrame:CGRectMake(0,_viewFollower.frame.origin.y+ 10+ _viewFollower.frame.size.height, w, 1)];
    [_lblTitleAlbum setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleCaption2]];
    [_lblTitleAlbum setTextColor:[UIColor blackColor]];
    [_lblTitleAlbum setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [_lblTitleAlbum setLineBreakMode:NSLineBreakByCharWrapping];
    [_lblTitleAlbum setNumberOfLines:0];
    [_lblTitleAlbum setFont:[UIFont boldSystemFontOfSize:follower.font.pointSize]];
    [_lblTitleAlbum setText:[NSString stringWithFormat:@"Bộ sưu tập của %@",_user.fullname]];
    [_lblTitleAlbum sizeToFit];
   
    // Request album for user
   // http://latte.lozi.vn/v1/users/104970/albums?cityId=50
    _cityId= @"50";
    NSString *urlAlbumforUser = [NSString stringWithFormat:@"%@/users/%@/albums?cityId=%@",[AppConfig GetBaseNextPageUrl],_user._id,_cityId];
    [self SendRequest:urlAlbumforUser];
    // create table view for album of user
   //_tableViewAlbumUser = [[MyTableView alloc] initWithFrame:CGRectMake(10, _viewFollower.frame.origin.y+_viewFollower.frame.size.height, w-20, 100)];
    _albumUserArray = [[NSMutableArray alloc]init];
    _sectionAlbumUserArray = [[NSMutableArray alloc]init];
    _tableViewAlbumUser = [[MyTableView alloc] initWithFrame:CGRectMake(10, 20, w-20, 100)];
    _tableViewAlbumUser.myTable.scrollEnabled = NO;
    _tableViewAlbumUser.sectionContents = _sectionAlbumUserArray;
    _tableViewAlbumUser.numberOfRowEachSection = 2;
    _tableViewAlbumUser.backgroundColor = [UIColor colorWithRed:228.0f/255.0f green:228.0f/255.0f blue:228.0f/255.0f alpha:1];
   
   
    

    
    // Do any additional setup after loading the view.
}
// when load success data for collectionview

-(void)onDataLoadedSucessWithData
{
    dispatch_async(dispatch_get_main_queue(),
                   ^
                   {
                       
                       [self.foodCollectionView reloadData];
                       if(_foodLoader.dataArray.count >0)
                       {
                           _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, _foodCollectionView.frame.origin.y + _foodCollectionView.frame.size.height);
                           [_scrollView addSubview:self.foodCollectionView];
                       }
                       

                   });
}
// function when click on care button
- (IBAction)careUser:(UIButton *)careBtn
{
    if (stateOfBtn == 1) {
        stateOfBtn = 2;
        careBtn.backgroundColor = [UIColor greenColor];
        [careBtn setTitle:@"Đã quan tâm" forState:UIControlStateNormal];
        [careBtn sizeToFit];
        CGFloat marginLeft = (_viewAvatar.frame.size.width - careBtn.frame.size.width*1.2)/2;
        [careBtn setFrame:CGRectMake(marginLeft, careBtn.frame.origin.y, careBtn.frame.size.width*1.2, careBtn.frame.size.height)];
        return;

        
    }
    
    if (stateOfBtn == 2) {
        stateOfBtn = 1;
        careBtn.backgroundColor = [UIColor colorWithRed:237.0f/255.0f green:53.0f/255.0f blue:84.0f/255.0f alpha:1];        [careBtn setTitle:@"Quan tâm" forState:UIControlStateNormal];
        [careBtn sizeToFit];
        CGFloat marginLeft = (_viewAvatar.frame.size.width - careBtn.frame.size.width*1.2)/2;
        [careBtn setFrame:CGRectMake(marginLeft, careBtn.frame.origin.y, careBtn.frame.size.width*1.2, careBtn.frame.size.height)];
        return;
        
    }
    
}
-(void) setupView
{
    CGFloat margin = 10;

    NSString *remainUrlBlock =[NSString stringWithFormat:@"/users/%@/blocks/uploaded?cityId=%@",_user._id,_cityId];
    FoodCollectionViewLayout* collectionLayout = [[FoodCollectionViewLayout alloc] init];
    self.foodCollectionView.showsVerticalScrollIndicator = false;
    _foodLoader = [[FoodLoader alloc] init];
    [_foodLoader setDataLoaderDelegate:self];
   
    

    if (IsHaveAblum == YES) {
        [_lblTitleAlbum setFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-_lblTitleAlbum.self.frame.size.width)/2, _lblTitleAlbum.frame.origin.y, _lblTitleAlbum.frame.size.width, _lblTitleAlbum.frame.size.height)];
        
        [_scrollView addSubview:_lblTitleAlbum];

        [_tableViewAlbumUser setFrame:CGRectMake(margin,_lblTitleAlbum.frame.origin.y + margin + _lblTitleAlbum.frame.size.height, [UIScreen mainScreen].bounds.size.width - 2*margin,_tableViewAlbumUser.myTable.contentSize.height)];
        [_tableViewAlbumUser.myTable setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 2*margin,_tableViewAlbumUser.myTable.contentSize.height)];
        _tableViewAlbumUser.backgroundColor = [UIColor colorWithRed:228.0f/255.0f green:228.0f/255.0f blue:228.0f/255.0f alpha:1];
        [_scrollView addSubview:_tableViewAlbumUser];
        NSLog(@"%f %f",_viewFollower.frame.origin.y,_tableViewAlbumUser.frame.size.height);
        _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, _tableViewAlbumUser.frame.origin.y + _tableViewAlbumUser.frame.size.height + 10.0f);
        
        // config collectionview when having album table
        
            self.foodCollectionView = [[FoodCollectionView alloc] initWithFrame:CGRectMake(0, _tableViewAlbumUser.frame.origin.y+_tableViewAlbumUser.frame.size.height, [UIScreen mainScreen].bounds.size.width, 3000) collectionViewLayout:collectionLayout];
         [self.foodCollectionView setDataLoader:_foodLoader withStartPage:remainUrlBlock];
        
    }
   else
   {
       
      
           self.foodCollectionView = [[FoodCollectionView alloc] initWithFrame:CGRectMake(0, _viewFollower.frame.origin.y+_viewFollower.frame.size.height, [UIScreen mainScreen].bounds.size.width, 3000) collectionViewLayout:collectionLayout];
        [self.foodCollectionView setDataLoader:_foodLoader withStartPage:remainUrlBlock];
           _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, _foodCollectionView.frame.origin.y + _foodCollectionView.frame.size.height);
       

   }
    
    // http://latte.lozi.vn/v1/users/104970/blocks/uploaded?cityId=50
   
    
   
    
}
-(void) SendRequest : (NSString*) urlBase
{
    
    NSURL* url = [NSURL URLWithString:urlBase];
    NSLog(@"url can tim %@",urlBase);
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
                        AlbumsModel* newUserModel = [[AlbumsModel alloc] initWithDictionary:followerObj error:nil];
                        [self.albumUserArray insertObject:newUserModel atIndex:self.albumUserArray.count];
                    }
                    if (self.albumUserArray.count <= 0 ) {
                        IsHaveAblum = NO;
                    }
                    else
                        
                    {
                        IsHaveAblum = YES;
                        
                        if (_sectionAlbumUserArray.count == 0) {
                            NSMutableDictionary* albumDictitionary = [[NSMutableDictionary alloc] init];
                            [albumDictitionary setObject: _albumUserArray forKey: @"content"];
                            [albumDictitionary setObject: [NSNumber numberWithInt:9] forKey: @"type"];
                            [albumDictitionary setObject:[NSString stringWithFormat:@"Bộ sưu tập của %@",_user.fullname] forKey: @"caption"];
                            [self.sectionAlbumUserArray addObject:albumDictitionary];
                            
                            NSMutableDictionary* moreDictionary = [[NSMutableDictionary alloc] init];
                            [moreDictionary setObject:[NSArray arrayWithObjects: @"Xem thêm bộ sưu tập", nil] forKey: @"content"];
                            [moreDictionary setObject: [NSNumber numberWithInt:10] forKey: @"type"];
                            [moreDictionary setObject: @"More commnent" forKey: @"caption"];
                            [self.sectionAlbumUserArray addObject:moreDictionary];
                            
                        }
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [_tableViewAlbumUser.myTable reloadData];
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

//Selector for back button
-(IBAction)backToPrevious:(id)sender
{
    NSLog(@"Back btn");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
       
    });
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
