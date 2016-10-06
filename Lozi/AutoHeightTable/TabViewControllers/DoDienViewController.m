//
//  FoodViewController.m
//  AutoHeightTable
//
//  Created by AnhLTV on 6/11/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import "DoDienViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface DoDienViewController ()
    
@end

@implementation DoDienViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.urlDictionary = [[NSMutableDictionary alloc] init];
    [self.urlDictionary setObject: [NSString stringWithFormat: @"%@/topics/6/photos?cityId=%ld&t=popular",[AppConfig GetBaseNextPageUrl], [AppConfig GetCityID]] forKey: @" Phổ biến "];
    [self.urlDictionary setObject: [NSString stringWithFormat: @"%@/topics/6/photos?cityId=%ld&t=latest",[AppConfig GetBaseNextPageUrl], [AppConfig GetCityID]] forKey: @" Mới nhất "];
    [self.urlDictionary setObject: [NSString stringWithFormat: @"%@/topics/6/photos?cityId=%ld&t=opening",[AppConfig GetBaseNextPageUrl], [AppConfig GetCityID]] forKey: @" Đang mở cửa "];
    
    float viewMargin = [AppConfig GetViewMargin];
    float menuViewHeight = self.view.frame.size.height / 15.0f;
    float menuViewWidth = self.view.frame.size.width - viewMargin - viewMargin;
    float paddingMenu = 5.0f;
    float buttonPaddding = 5.0f;
    float pickerPadding = 8.0f;
    
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.mainScrollView setBackgroundColor: [AppConfig GetAppBackgroundColor]];
    [self.mainScrollView setShowsHorizontalScrollIndicator:false];
    [self.mainScrollView setShowsVerticalScrollIndicator:false];
    [self.mainScrollView setDelegate:self];
    [self.view addSubview:self.mainScrollView];
    
    //Begin shop header view
    self.headerView = [[UIView alloc] init];
    [self.headerView setBackgroundColor:[UIColor whiteColor]];
    float shopHeaderViewWidth = self.view.frame.size.width - viewMargin*2.0f;
    
    float shopHeaderImageWidth = shopHeaderViewWidth/5.0f;
    float shopHeaderImageHeight = shopHeaderImageWidth * 1.5f;
    self.headerImage = [[UIImageView alloc] initWithFrame:CGRectMake(viewMargin, viewMargin * 2.0f, shopHeaderImageWidth, shopHeaderImageHeight)];
    [self.headerImage setImage:[UIImage imageNamed:@"ic_delivery_header"]];
    self.headerImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.headerView addSubview:self.headerImage];
    
    float shopHeaderTitleWidth = shopHeaderViewWidth - self.headerImage.frame.origin.x - self.headerImage.frame.size.width - viewMargin * 2.0f;
    float labelHeaderLeft = self.headerImage.frame.origin.x + self.headerImage.frame.size.width + viewMargin;
    float labelHeaderTop = self.headerImage.frame.origin.y + viewMargin;
    self.headerTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelHeaderLeft, labelHeaderTop, shopHeaderTitleWidth, 1)];
    [self.headerTitleLabel setFont:[UIFont boldSystemFontOfSize:15.0f]];
    [self.headerTitleLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.headerTitleLabel setNumberOfLines:0];
    [self.headerTitleLabel setText:@"Lên đồ, lên đời"];
    [self.headerTitleLabel sizeToFit];
    [self.headerTitleLabel setFrame:CGRectMake(labelHeaderLeft, labelHeaderTop, self.headerTitleLabel.frame.size.width, self.headerTitleLabel.frame.size.height)];
    [self.headerView addSubview:self.headerTitleLabel];
    
    
    labelHeaderTop = labelHeaderTop + self.headerTitleLabel.frame.size.height + viewMargin;
    self.headerDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelHeaderLeft, labelHeaderTop, shopHeaderTitleWidth, 1)];
    [self.headerDescriptionLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [self.headerDescriptionLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.headerDescriptionLabel setNumberOfLines:0];
    [self.headerDescriptionLabel setText:@"Vọc ngay đồ điện tử với chuột máy tính, đồng hồ điện thoại👉 Bán 👉 Đồ điện tử 👉 Ta daa!"];
    [self.headerDescriptionLabel sizeToFit];
    [self.headerDescriptionLabel setFrame:CGRectMake(labelHeaderLeft, labelHeaderTop, self.headerDescriptionLabel.frame.size.width, self.headerDescriptionLabel.frame.size.height)];
    [self.headerView addSubview:self.headerDescriptionLabel];
    
    self.headerView.layer.cornerRadius = 3.0f;
    [self.headerView setFrame: CGRectMake(viewMargin, viewMargin, shopHeaderViewWidth, self.headerDescriptionLabel.frame.origin.y + self.headerDescriptionLabel.frame.size.height + viewMargin)];
    
    [self.mainScrollView addSubview:self.headerView];
    
    //Init Menu
    self.menuView = [[UIView alloc] init];
    [self.menuView setFrame:CGRectMake(viewMargin, self.headerView.frame.origin.y + self.headerView.frame.size.height + viewMargin, menuViewWidth, menuViewHeight)];
    self.menuView.layer.cornerRadius = 3.0f;
    [self.menuView setBackgroundColor:[UIColor whiteColor]];
    [self.mainScrollView addSubview:self.menuView];
    
    
    
    
    
    
    self.viewTypeLabel = [[UILabel alloc]init];
    [self.menuView addSubview:self.viewTypeLabel];
    
    float buttonWidth = menuViewHeight - paddingMenu* 2.0f;
    self.viewButton1 = [[UIButton alloc] init];
    [self.viewButton1 setImage: [UIImage imageNamed:@"monoColumnGrey"]   forState:UIControlStateNormal];
    [self.viewButton1 setImage: [UIImage imageNamed:@"monoColumnGrey"]   forState:UIControlStateSelected];
    [self.viewButton1 setAlpha:0.5f];
    [self.viewButton1 setFrame: CGRectMake(menuViewWidth - paddingMenu - buttonWidth, paddingMenu, buttonWidth, buttonWidth)];
    self.viewButton1.backgroundColor = [UIColor whiteColor];
    [self.viewButton1 setImageEdgeInsets:UIEdgeInsetsMake(buttonPaddding, buttonPaddding, buttonPaddding, buttonPaddding)];
    [self.viewButton1.layer setBorderWidth:1.0f];
    [self.viewButton1.layer setCornerRadius:2.0f];
    [self.viewButton1.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.viewButton1 addTarget:self action:@selector(onViewButton1Touch:) forControlEvents:UIControlEventTouchUpInside];
    [self.menuView addSubview:self.viewButton1];
    
    
    
    self.viewButton2 = [[UIButton alloc] init];
    [self.viewButton2 setImage: [UIImage imageNamed:@"multiColumnGrey"]   forState:UIControlStateNormal];
    [self.viewButton2 setImage: [UIImage imageNamed:@"multiColumnGrey"]   forState:UIControlStateSelected];
    [self.viewButton2 setSelected:true];
    [self.viewButton2 setFrame: CGRectMake(menuViewWidth - paddingMenu*2.0f - buttonWidth*2.0f - buttonPaddding, paddingMenu, buttonWidth, buttonWidth)];
    self.viewButton2.backgroundColor = [UIColor whiteColor];
    [self.viewButton2 setImageEdgeInsets:UIEdgeInsetsMake(buttonPaddding, buttonPaddding, buttonPaddding, buttonPaddding)];
    [self.viewButton2.layer setBorderWidth:1.0f];
    [self.viewButton2.layer setCornerRadius:2.0f];
    [self.viewButton2.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.viewButton2 addTarget:self action:@selector(onViewButton2Touch:) forControlEvents:UIControlEventTouchUpInside];
    [self.menuView addSubview:self.viewButton2];
    
    
    
    self.comboTextField = [[UIButton alloc] initWithFrame:CGRectMake(paddingMenu, paddingMenu, 200, self.viewButton1.frame.size.height)];
    self.comboTextField.layer.masksToBounds = false;
    [self.comboTextField setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.comboTextField setFont:[UIFont preferredFontForTextStyle: UIFontTextStyleCaption2]];
    [self.comboTextField setTitle: @" Phổ biến " forState:UIControlStateNormal];
    [self.comboTextField.layer setBorderColor: [[UIColor grayColor] CGColor]];
    [self.comboTextField setImageEdgeInsets:UIEdgeInsetsMake(0.0f, -5.0f, 0.0f, 5.0f)];
    [self.comboTextField.layer setBorderWidth:1.0f];
    self.comboTextField.layer.cornerRadius = 3.0f;
    [self.comboTextField setImage: [UIImage imageNamed:@"ic_drop_down_nf"]   forState:UIControlStateNormal];
    
    [self.comboTextField sizeToFit];
    [self.comboTextField setFrame:CGRectMake(paddingMenu, paddingMenu, self.comboTextField.frame.size.width + 15.0f, self.viewButton1.frame.size.height)];
    self.comboTextField.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    self.comboTextField.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    self.comboTextField.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    [self.comboTextField addTarget:self action:@selector(onComboboxTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.menuView addSubview:self.comboTextField];
    
    
    
    //Description View
    /*
     self.descriptionView = [[UIView alloc] init];
     [self.mainScrollView addSubview:self.descriptionView];
     
     self.descriptionLable1 = [[CustomLabel alloc] init];
     [self.descriptionLable1 setPlainTextCustomSize:CustomLabelSize_Normal];
     
     
     self.descriptionLable2 = [[CustomLabel alloc] init];
     [self.descriptionLable2 setPlainTextCustomSize:CustomLabelSize_Normal];
     
     self.descriptionLable3 = [[CustomLabel alloc] init];
     [self.descriptionLable3 setPlainTextCustomSize:CustomLabelSize_Normal];
     */
    
    
    float collectionViewTop = self.menuView.frame.origin.y + self.menuView.frame.size.height;
    FoodCollectionViewLayout* collectionLayout = [[FoodCollectionViewLayout alloc] init];
    self.foodCollectionView = [[FoodCollectionView alloc] initWithFrame:CGRectMake(0, collectionViewTop, self.mainScrollView.frame.size.width, 0) collectionViewLayout:collectionLayout];
    self.foodCollectionView.showsVerticalScrollIndicator = false;
    self.foodCollectionView.parentViewContoller = self;
    [self.foodCollectionView setParentScrollView:self.mainScrollView];
    [self.foodCollectionView setDataLoader: [[FoodLoader alloc]init] withStartPage:[NSString stringWithFormat: @"%@/topics/6/photos?t=popular", [AppConfig GetBaseNextPageUrl]]];
    
    [self.mainScrollView setContentSize:CGSizeMake(self.view.frame.size.width, collectionViewTop)];
    [self.mainScrollView addSubview:self.foodCollectionView];
    
    
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
        [self.foodCollectionView goToNextPage];
    }
    
    
    if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
        [self.foodCollectionView goToNextPage];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)onComboboxTouch:(UIButton*)sender
{
    
    
    CustomDropDownList* vc = [[CustomDropDownList alloc] initWithDictionary:self.urlDictionary];
    [vc setDropDownDelegate:self];
    [self presentViewController:vc animated:NO completion:nil];
    
    
}

-(void) onSelectedItem: (NSString*) item
{
    [self.comboTextField setTitle:item forState:UIControlStateNormal];
    [self.comboTextField sizeToFit];
    [self.comboTextField setFrame:CGRectMake(5.0f, 5.0f, self.comboTextField.frame.size.width + 15.0f, self.viewButton1.frame.size.height)];
    self.comboTextField.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    self.comboTextField.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    self.comboTextField.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    [self.foodCollectionView.dataLoader ReloadDataWithURL: [self.urlDictionary objectForKey:item]];
    [self dismissViewControllerAnimated:false completion:nil];
}


-(void)onViewButton1Touch:(UIButton*)sender
{
    if (self.foodCollectionView.numberOfItemPerRow != 1)
    {
        self.foodCollectionView.numberOfItemPerRow = 1;
        [UIView performWithoutAnimation:^{
            [self.foodCollectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
            
        }];
        
        [self.viewButton1 setAlpha:1.0f];
        [self.viewButton2 setAlpha:0.5f];
    }
}

-(void)onViewButton2Touch:(UIButton*)sender
{
    if (self.foodCollectionView.numberOfItemPerRow != 2)
    {
        self.foodCollectionView.numberOfItemPerRow = 2;
        [UIView performWithoutAnimation:^{
            [self.foodCollectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
            
        }];
        
        [self.viewButton1 setAlpha:0.5f];
        [self.viewButton2 setAlpha:1.0f];
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
