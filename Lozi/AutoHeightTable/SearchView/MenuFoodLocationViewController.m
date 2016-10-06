//
//  MenuFoodLocationViewController.m
//  LoadSearchView
//
//  Created by AnhLTV on 7/18/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

#import "MenuFoodLocationViewController.h"

@interface MenuFoodLocationViewController ()

@end

@implementation MenuFoodLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:228.0f/255.0f green:228.0f/255.0f blue:228.0f/255.0f alpha:1];

    CGSize size = [UIScreen mainScreen].bounds.size;
    CGFloat w = size.width;
    CGFloat h = size.height;
    // Add view for navigation
    _viewBack = [[UIView alloc]init];
    _viewBack.backgroundColor = [UIColor whiteColor];
    _viewBack.frame = CGRectMake(0, 25, w, h*0.07);
    
    //add btn back to previous scene
    UIButton *btnBack = [[UIButton alloc]init];
    btnBack.frame = CGRectMake(0, 0, h*0.03+20, _viewBack.frame.size.height);
    [btnBack setImage:[UIImage imageNamed:@"leftArrowBlue"] forState:UIControlStateNormal];
    [btnBack.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [btnBack addTarget:self action:@selector(backToPrevious:) forControlEvents:UIControlEventTouchUpInside];
    [_viewBack addSubview:btnBack];
    
    UILabel *lblMenu = [[UILabel alloc]initWithFrame:CGRectMake(btnBack.frame.origin.x+btnBack.frame.size.width, btnBack.frame.origin.y, _viewBack.frame.size.width-btnBack.frame.origin.x-btnBack.frame.size.width, btnBack.frame.size.height)];
    lblMenu.text = @"Menu";
    lblMenu.textColor = [UIColor colorWithRed:41.0f/255.0f green:91.0f/255.0f blue:132.0f/255.0f alpha:1];
    [lblMenu setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleCaption1]];
    lblMenu.font = [UIFont boldSystemFontOfSize:lblMenu.font.pointSize];
    [lblMenu setLineBreakMode:NSLineBreakByCharWrapping];
    [lblMenu setNumberOfLines:1];
    [self.view addSubview:_viewBack];
    [_viewBack addSubview:lblMenu];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _viewBack.frame.origin.y+_viewBack.frame.size.height, w, h-_viewBack.frame.size.height-_viewBack.frame.origin.y )];
    _scrollView.backgroundColor = [UIColor colorWithRed:228.0f/255.0f green:228.0f/255.0f blue:228.0f/255.0f alpha:1];
   
    [self.view addSubview:_scrollView];
    
// Add table of Menu
    CGFloat margin = 10;
    _menuArray = [[NSMutableArray alloc]init];
    _sectionMenuArray = [[NSMutableArray alloc] init];
    _tableMenu = [[MyTableView alloc] initWithFrame:CGRectMake(margin, margin, _scrollView.frame.size.width- 2*margin, 10)];
    _tableMenu.myTable.scrollEnabled = NO;
    _tableMenu.sectionContents = _sectionMenuArray;
    [_scrollView addSubview:_tableMenu];
   // http://latte.lozi.vn/v1/eateries/62458/dishes?cityId=1

    NSString *cityId = @"50";
    // Do any additional setup after loading the view.
    NSString *url = [NSString stringWithFormat:@"%@/eateries/%@/dishes?cityId=%@",[AppConfig GetBaseNextPageUrl],self._id,cityId];
    [self SendRequest:url];
}
-(IBAction)backToPrevious:(id)sender
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
        
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setupView
{
    [_tableMenu setFrame:CGRectMake(_tableMenu.frame.origin.x,_tableMenu.frame.origin.y , _tableMenu.frame.size.width,_tableMenu.myTable.contentSize.height)];
    [_tableMenu.myTable setFrame:CGRectMake(0, 0, _tableMenu.frame.size.width,_tableMenu.myTable.contentSize.height)];
    
    //Update Scroll View Content Size
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, _tableMenu.frame.origin.y + _tableMenu.frame.size.height + 10.0f);
    

    
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
                        MenuModel* newUserModel = [[MenuModel alloc] initWithDictionary:followerObj error:nil];
                        [self.menuArray insertObject:newUserModel atIndex:self.menuArray.count];
                    }
                    
                        
                        if (_sectionMenuArray.count == 0) {
                            NSMutableDictionary* menuDictitionary = [[NSMutableDictionary alloc] init];
                            [menuDictitionary setObject: _menuArray forKey: @"content"];
                            [menuDictitionary setObject: [NSNumber numberWithInt:11] forKey: @"type"];
                            [menuDictitionary setObject:[NSString stringWithFormat:@"Menu"] forKey: @"caption"];
                            
                            
                            NSMutableDictionary* moreDictionary = [[NSMutableDictionary alloc] init];
                            [moreDictionary setObject:[NSArray arrayWithObjects: @"Xem thêm bộ sưu tập", nil] forKey: @"content"];
                            [moreDictionary setObject: [NSNumber numberWithInt:12] forKey: @"type"];
                            [moreDictionary setObject: @"More commnent" forKey: @"caption"];
                            [self.sectionMenuArray addObject:moreDictionary];
                            [self.sectionMenuArray addObject:menuDictitionary];
                        }
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [_tableMenu.myTable reloadData];
                            [self setupView];
                            
                        });
                        
                    
                    
                    
                }
            }
            
        }
    }];
    [task resume];
    
    
    //NSURL *url= NSURL URLWithString:(nonnull NSString *)
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
