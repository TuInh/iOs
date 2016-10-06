//
//  CollectionViewCell.m
//  Around
//
//  Created by AnhLTV on 6/29/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

#import "AroundCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation AroundCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self setupView];
    }
    return self;
}
-(void) setupView
{
    _avatar = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _avatar.layer.cornerRadius = 5.0f;
    [self insertSubview:_avatar atIndex:0];
    
    _type = [[UILabel alloc]init];
    CGFloat margin = self.frame.size.width/8;
    [_type setFrame:CGRectMake(margin, self.frame.size.height*2/3, self.frame.size.width - 2*margin, 1)];
    [_type setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [_type setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleCaption1]];
    [_type setNumberOfLines:0];
    [_type setLineBreakMode:NSLineBreakByWordWrapping];
    
    
}
@end
