//
//  EventViewController.m
//  AutoHeightTable
//
//  Created by AnhLTV on 7/12/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import "EventViewController.h"


@implementation EventViewController

-(void)viewDidLoad
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat inset = 10.0f;
    layout.minimumInteritemSpacing = inset;
    layout.minimumLineSpacing = inset;
    self.eventCollectionView = [[EventCollectionView alloc] initWithFrame:CGRectMake(0, inset, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
    [self.view addSubview:self.eventCollectionView];
    [self.view setBackgroundColor: [AppConfig GetAppBackgroundColor]];
}
@end
