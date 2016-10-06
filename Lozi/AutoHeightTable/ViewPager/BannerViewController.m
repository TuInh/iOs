//
//  BannerViewController.m
//  AutoHeightTable
//
//  Created by AnhLTV on 6/6/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import "BannerViewController.h"

@implementation BannerViewController
- (instancetype)initWithFrame:(CGRect) frame andUrl:(NSString*) url
{
    self = [super init];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:frame];
        [self.imageView setBackgroundColor:[UIColor brownColor]];
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:url]];
        self.view = self.imageView;
    }
    return self;
}

- (void) updateImageHeight:(float) newHeight
{
    [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, newHeight)];
    [self.imageView setFrame:CGRectMake(self.imageView.frame.origin.x, self.imageView.frame.origin.y, self.imageView.frame.size.width, newHeight)];
}
@end
