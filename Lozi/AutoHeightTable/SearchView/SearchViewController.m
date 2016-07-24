//
//  ViewController.m
//  LoadSearchView
//
//  Created by AnhLTV on 5/23/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.sectionContentArray = [[NSMutableArray alloc] init];
    NSMutableDictionary* recentDictionary = [[NSMutableDictionary alloc] init];
    [recentDictionary setObject:[NSArray arrayWithObjects: @"Trứng gà", @"Bánh mỳ chảo", nil] forKey: @"content"];
    [recentDictionary setObject: [NSNumber numberWithInt:1] forKey: @"type"];
    [recentDictionary setObject: @"Gần đây" forKey: @"caption"];
    [self.sectionContentArray addObject:recentDictionary];
    
    
    NSMutableDictionary* popularDictionary = [[NSMutableDictionary alloc] init];
    [popularDictionary setObject:[NSArray arrayWithObjects: @"Bánh mỳ xúc xích", @"Cơm rong biển", nil] forKey: @"content"];
    [popularDictionary setObject: [NSNumber numberWithInt:1] forKey: @"type"];
    [popularDictionary setObject: @"Phổ biến" forKey: @"caption"];
    [self.sectionContentArray addObject:popularDictionary];

    [self.view setFrame:[[UIScreen mainScreen] bounds]];
    [self.view setBackgroundColor:[AppConfig GetAppBackgroundColor]];
    
    float viewMargin = [AppConfig GetViewMargin];
    float menuPadding = 5.0f;
    float searchBarHeight = self.view.frame.size.height / 18.0f;
    float searchBarTop = 30;
    
    self.searchBarContainer = [[UIView alloc] initWithFrame:CGRectMake(0, searchBarTop, self.view.frame.size.width, searchBarHeight + 2.0f * menuPadding)];
    [self.searchBarContainer setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.searchBarContainer];
    
    self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(viewMargin, menuPadding, searchBarHeight, searchBarHeight)];
    [self.backButton setImage:[UIImage imageNamed:@"leftArrowBlue"] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(onBackButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.searchBarContainer addSubview:self.backButton];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(self.backButton.frame.origin.x + self.backButton.frame.size.width, menuPadding, self.view.frame.size.width - self.backButton.frame.origin.x - self.backButton.frame.size.width - viewMargin * 2.0f, searchBarHeight)];
    [self.searchBar setSearchBarStyle:UISearchBarStyleMinimal];
    [self.searchBar setDelegate:self];
    [self.searchBar setText:@""];
    [self.searchBarContainer addSubview:self.searchBar];
    
    float tableTop = self.searchBarContainer.frame.origin.y + self.searchBarContainer.frame.size.height;
    self.myTableView = [[MyTableView alloc] initWithFrame:CGRectMake(0,
                                                                     tableTop,
                                                                     self.view.frame.size.width,
                                                                     self.view.frame.size.height - tableTop)];
    self.myTableView.sectionContents = self.sectionContentArray;
    [self.view addSubview:self.myTableView];
    
    // Do any additional setup after loading the view, typically from a nib.
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showDetailEatery:) name:@"Jump Detail Eatery" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showDetailAlbum:) name:@"Jump Detail Album" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showDetailUser:) name:@"Jump Detail User" object:nil];
    
    
}
-(void)showDetailEatery:(NSNotification*) notification
{
    SearchDetailFoodViewController *foodViewController = [[SearchDetailFoodViewController alloc] init];
    foodViewController.slug = [[notification userInfo] valueForKey:@"eatery"];
    [self presentViewController:foodViewController animated:NO completion:nil];
    
}
-(void)showDetailAlbum:(NSNotification*) notification
{
    AlbumDetailViewController *albumViewController = [[AlbumDetailViewController alloc] init];
    albumViewController.album = (AlbumsModel*)([[notification userInfo] valueForKey:@"album"]);
    [self presentViewController:albumViewController animated:NO completion:nil];
    
}
-(void)showDetailUser:(NSNotification*) notification
{
    UserDetailViewController *userViewController = [[UserDetailViewController alloc] init];
    userViewController.user = (UserModel*)([[notification userInfo] valueForKey:@"user"]);
    [self presentViewController:userViewController animated:NO completion:nil];
    
}
-(void) SendRequestWithQueryString:(NSString*) queryString
{
    NSString *urlBase = [NSString stringWithFormat:@"http://latte.lozi.vn/v1/search/suggestion?q=%@&cityId=%ld", queryString, [AppConfig GetCityID]];
    /* NSString *urlBase = @"http://lozi.vn/search/b?q=";
    NSString *inputString = @"trứng-gà";
    NSString *encodeString = [inputString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    urlBase = [[urlBase stringByAppendingString:encodeString] stringByAppendingString:@"&a=ho-chi-minh"];
     */
     NSURL* url = [NSURL URLWithString:urlBase];
     
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",str);
        if (data.length > 0 && error== nil) {
            [self.sectionContentArray removeAllObjects];
            NSDictionary *jsonResult = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            if (jsonResult != nil) {
                
                NSDictionary *dataObject = [jsonResult valueForKey:@"data"];
                if (dataObject != nil) {
                    
                    FoodSearchModel *newFoodSearchModel = [[FoodSearchModel alloc] initWithDictionary:dataObject error:nil];
                    // add Albums data
                    NSMutableDictionary* albumDictionary = [[NSMutableDictionary alloc] init];
                    [albumDictionary setObject: newFoodSearchModel.albums forKey: @"content"];
                    [albumDictionary setObject: [NSNumber numberWithInt:2] forKey: @"type"];
                    [albumDictionary setObject: @"Bộ sưu tập" forKey: @"caption"];
                    [self.sectionContentArray addObject:albumDictionary];
                    
                    NSMutableDictionary* eateryDictitionary = [[NSMutableDictionary alloc] init];
                    [eateryDictitionary setObject: newFoodSearchModel.eateries forKey: @"content"];
                    [eateryDictitionary setObject: [NSNumber numberWithInt:3] forKey: @"type"];
                    [eateryDictitionary setObject: @"Địa điểm" forKey: @"caption"];
                    [self.sectionContentArray addObject:eateryDictitionary];

                    
                    
                    NSMutableDictionary* albumsDictitionary = [[NSMutableDictionary alloc] init];
                    [albumsDictitionary setObject: newFoodSearchModel.users forKey: @"content"];
                    [albumsDictitionary setObject: [NSNumber numberWithInt:4] forKey: @"type"];
                    [albumsDictitionary setObject: @"Thành viên" forKey: @"caption"];
                    [self.sectionContentArray addObject:albumsDictitionary];
                    dispatch_async(dispatch_get_main_queue(), ^
                                   {
                                       [self.myTableView.myTable reloadData];
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


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText != nil)
    {
        if (searchText.length > 0)
        {
            
            NSString *queryString = [searchText stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
            [self SendRequestWithQueryString:queryString];
        }
    }
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}

-(void)onBackButtonTouch:(UIButton*)sender
{
    [self dismissViewControllerAnimated:false completion:nil];
}
@end

