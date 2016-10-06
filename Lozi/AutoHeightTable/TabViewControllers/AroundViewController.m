//
//  AroundViewController.m
//  AutoHeightTable
//
//  Created by AnhLTV on 7/11/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import "AroundViewController.h"

@implementation AroundViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    float viewMargin = [AppConfig GetViewMargin];
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.mainScrollView setBackgroundColor: [UIColor whiteColor]];
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
    [self.headerImage setImage:[UIImage imageNamed:@"ic_around_topic"]];
    self.headerImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.headerView addSubview:self.headerImage];
    
    float shopHeaderTitleWidth = shopHeaderViewWidth - self.headerImage.frame.origin.x - self.headerImage.frame.size.width - viewMargin * 2.0f;
    float labelHeaderLeft = self.headerImage.frame.origin.x + self.headerImage.frame.size.width + viewMargin;
    float labelHeaderTop = self.headerImage.frame.origin.y + viewMargin;
    self.headerTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelHeaderLeft, labelHeaderTop, shopHeaderTitleWidth, 1)];
    [self.headerTitleLabel setFont:[UIFont boldSystemFontOfSize:15.0f]];
    [self.headerTitleLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.headerTitleLabel setNumberOfLines:0];
    [self.headerTitleLabel setText:@"Quanh đây có quá trời đồ ăn luôn, bạn đang tìm kiếm gì nào"];
    [self.headerTitleLabel sizeToFit];
    [self.headerTitleLabel setFrame:CGRectMake(labelHeaderLeft, labelHeaderTop, self.headerTitleLabel.frame.size.width, self.headerTitleLabel.frame.size.height)];
    [self.headerView addSubview:self.headerTitleLabel];
    
    
    labelHeaderTop = labelHeaderTop + self.headerTitleLabel.frame.size.height + viewMargin;
    self.headerDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelHeaderLeft, labelHeaderTop, shopHeaderTitleWidth, 1)];
    [self.headerDescriptionLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [self.headerDescriptionLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.headerDescriptionLabel setNumberOfLines:0];
    [self.headerDescriptionLabel setText:@""];
    [self.headerDescriptionLabel sizeToFit];
    [self.headerDescriptionLabel setFrame:CGRectMake(labelHeaderLeft, labelHeaderTop, self.headerDescriptionLabel.frame.size.width, self.headerDescriptionLabel.frame.size.height)];
    [self.headerView addSubview:self.headerDescriptionLabel];
    
    self.headerView.layer.cornerRadius = 3.0f;
    [self.headerView setFrame: CGRectMake(viewMargin, viewMargin, shopHeaderViewWidth, self.headerImage.frame.origin.y + self.headerImage.frame.size.height + viewMargin)];
    [self.mainScrollView addSubview:self.headerView];
    
    
    float collectionViewTop = self.headerView.frame.origin.y + self.headerView.frame.size.height + viewMargin;
    self.aroundCollectionView = [[AroundCollectionView alloc] initWithFrame:CGRectMake(viewMargin, collectionViewTop, self.mainScrollView.frame.size.width - 2.0f * viewMargin, 0)];
    [self.aroundCollectionView setParentView:self.mainScrollView];
    self.aroundCollectionView.showsVerticalScrollIndicator = false;
    self.aroundCollectionView.parentViewController = self;
    
    
    [self.mainScrollView setContentSize:CGSizeMake(self.view.frame.size.width, collectionViewTop)];
    [self.mainScrollView addSubview:self.aroundCollectionView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
