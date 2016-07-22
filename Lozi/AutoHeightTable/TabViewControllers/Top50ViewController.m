//
//  AroundViewController.m
//  AutoHeightTable
//
//  Created by AnhLTV on 7/11/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import "Top50ViewController.h"

@implementation Top50ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    float viewMargin = [AppConfig GetViewMargin];
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.mainScrollView setBackgroundColor: [UIColor whiteColor]];
    [self.mainScrollView setShowsHorizontalScrollIndicator:false];
    [self.mainScrollView setShowsVerticalScrollIndicator:false];
    [self.mainScrollView setDelegate:self];
    [self.view addSubview:self.mainScrollView];
    
    self.arroundLabel = [[UILabel alloc] initWithFrame:CGRectMake(viewMargin, viewMargin, 10, 10)];
    [self.arroundLabel setFont:[UIFont preferredFontForTextStyle: UIFontTextStyleCaption1]];
    [self.arroundLabel setText: @"Mục đích"];
    [self.arroundLabel sizeToFit];
    [self.mainScrollView addSubview:self.arroundLabel];
    
    
    float collectionViewTop = self.arroundLabel.frame.origin.y + self.arroundLabel.frame.size.height + viewMargin;
    self.aroundCollectionView = [[AroundCollectionView alloc] initWithFrame:CGRectMake(0, collectionViewTop, self.mainScrollView.frame.size.width, self.mainScrollView.frame.size.width / 3.0f) withType:true];
    [self.aroundCollectionView setParentView:self.mainScrollView];
    self.aroundCollectionView.showsVerticalScrollIndicator = false;
    [self.mainScrollView addSubview:self.aroundCollectionView];
    
    self.categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(viewMargin, self.aroundCollectionView.frame.origin.y + self.aroundCollectionView.frame.size.height + viewMargin, 10, 10)];
    [self.categoryLabel setFont:[UIFont preferredFontForTextStyle: UIFontTextStyleCaption1]];
    [self.categoryLabel setText: @"Thể loại"];
    [self.categoryLabel sizeToFit];
    [self.mainScrollView addSubview:self.categoryLabel];
    
    
    
    self.categoryCollectionView = [[CategoryCollectionView alloc] initWithFrame:CGRectMake(viewMargin, self.categoryLabel.frame.origin.y + self.categoryLabel.frame.size.height + viewMargin, self.mainScrollView.frame.size.width - 2.0f * viewMargin, 0)];
    [self.categoryCollectionView setParentView:self.mainScrollView];
    [self.mainScrollView addSubview:self.categoryCollectionView];
    
    
    [self.mainScrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
