//
//  BannerViewController.h
//  AutoHeightTable
//
//  Created by AnhLTV on 6/6/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface BannerViewController : UIViewController
@property(strong, nonatomic) UIImageView* imageView;
@property(assign) int index;

- (instancetype)initWithFrame:(CGRect) frame andUrl:(NSString*) url;
- (void) updateImageHeight:(float) newHeight;
@end
