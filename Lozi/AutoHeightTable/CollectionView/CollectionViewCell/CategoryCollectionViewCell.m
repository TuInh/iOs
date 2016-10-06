//
//  CollectionViewCell.m
//  Around
//
//  Created by AnhLTV on 6/29/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

#import "CategoryCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation CategoryCollectionViewCell
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
    [self addSubview:_avatar];
    
    
    _type = [[UILabel alloc]init];
    [_type setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleCaption1]];
    [_type setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_type];
    
}

-(void) setModelData:(CategoryModel*) dataModel
{
    CGFloat margin = 5.0f;
    [self.type setText:dataModel.value];
    [self.type sizeToFit];
    [self.type setFrame:CGRectMake(margin, self.frame.size.height - margin - self.type.frame.size.height, self.frame.size.width - margin*2.0f, self.type.frame.size.height)];
    
    float imageHeight = self.frame.size.height - self.type.frame.size.height - 3.0f * margin;
    float imageWidth = imageHeight;
    float imageLeft = (self.frame.size.width - imageWidth) /2.0f;
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:dataModel.imageMobile]];
    [self.avatar setFrame:CGRectMake(imageLeft, margin, imageWidth, imageHeight)];
    
}
@end
