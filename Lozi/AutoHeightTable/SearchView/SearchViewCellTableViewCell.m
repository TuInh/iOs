//
//  SearchViewCellTableViewCell.m
//  LoadSearchView
//
//  Created by AnhLTV on 5/26/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

#import "SearchViewCellTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
@implementation SearchViewCellTableViewCell

//CGFloat w,h;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}
-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
       self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}
-(instancetype) init
{
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}
-(instancetype) initWithCoder:(NSCoder *)aDecoder
{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupView];
    }
    return self;
}
-(instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}
-(void) setupView
{
    
    CGFloat a = self.frame.size.height;
    CGFloat w = [[UIScreen mainScreen] bounds].size.width;
    CGFloat h = [[UIScreen mainScreen] bounds].size.height;
    CGFloat heightCell = h/14;

    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 2, h/14 -4 , h/14-4 )];
    _imgView.backgroundColor = [UIColor redColor];
    _imgView.layer.cornerRadius = 4;
    _imgView.clipsToBounds = YES;
    _imgView.contentMode = UIViewContentModeScaleAspectFit;

    
    _foodName = [[UILabel alloc]init];
    [_foodName setFont:[UIFont systemFontOfSize:14]];
    _foodName.text = @"Pizza";
    _foodName.frame = CGRectMake(_imgView.frame.origin.x + _imgView.frame.size.width +10 ,heightCell/8, self.frame.size.width - 10 - _imgView.frame.size.width, heightCell/2);
    
    _foodDescription = [[UILabel alloc]init];
    //_foodName.center = CGPointMake(0, 1);
    //[_foodName.layer setAnchorPoint:CGPointMake(0.0f, 1.0f)];
    [_foodDescription setFont:[UIFont systemFontOfSize:10]];
    [_foodDescription setTextColor:[UIColor grayColor] ];
    _foodDescription.text = @"Pizza";
    _foodDescription.frame = CGRectMake(_imgView.frame.origin.x + _imgView.frame.size.width +10 ,heightCell*5/8, self.frame.size.width - 10 - _imgView.frame.size.width, heightCell*3/8);

    
   // _foodName.frame = CGRectMake(80, 20, 20, 30);
    NSLog(@"%f",self.frame.size.height);
    [self addSubview:_imgView];
    [self addSubview:_foodName];
    [self addSubview:_foodDescription];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
