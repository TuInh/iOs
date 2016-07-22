//
//  CustomViewSearch.m
//  CustomViewSearch
//
//  Created by AnhLTV on 5/21/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

#import "CustomViewSearch.h"

@implementation CustomViewSearch 

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame type:(int)typeSearch
{
    self = [super initWithFrame:frame];
    CGFloat h = frame.size.height;
    CGFloat w = frame.size.width;
    if (self) {
        if (typeSearch == 1) {
            self.backgroundColor = [UIColor colorWithRed:247.0f/255.0f green:247.0f/255.0f blue:247.0f/255.0f alpha:0.5f];
            self.layer.masksToBounds = YES;
            self.layer.cornerRadius = 6.0f;
            UIImage *imgIcon = [UIImage imageNamed:@"icon"];
            _iconLozi = [[UIImageView alloc]initWithImage:imgIcon];
            _iconLozi.frame = CGRectMake(h*0.3, h*0.3 + 3, h *0.7, h * 0.7);
            [self addSubview:_iconLozi];
            UIImage *imgSearch = [UIImage imageNamed:@"search"];
            _iconSearch = [[UIImageView alloc]initWithImage:imgSearch];
            _iconSearch.frame = CGRectMake(h*1.1, h*0.25+3, h*0.5, h*0.5);
            _iconSearch.contentMode = UIViewContentModeScaleAspectFit;
            [self addSubview:_iconSearch];
            _txtSearch = [[UITextField alloc]init];
            _txtSearch.frame = CGRectMake(h*1.6, h*0.25+3, w - h*1.6 - w*0.15, h*0.5);
            _txtSearch.adjustsFontSizeToFitWidth = YES;
            _txtSearch.minimumFontSize = 0.5;
            _txtSearch.textAlignment = NSTextAlignmentLeft;
            _txtSearch.font = [UIFont fontWithName:@"Helvetica" size:20];
            [_txtSearch addTarget:self action:(@selector(SearchFoodName)) forControlEvents:UIControlEventEditingDidBegin];
            _txtSearch.delegate = self;
            [self addSubview:_txtSearch];
            
            UIImage *imgArr = [UIImage imageNamed:@"arr"];
            _iconArr = [[UIImageView alloc]initWithImage:imgArr];
            _iconArr.frame = CGRectMake(w*0.86, h*0.35+3, h*0.3, h*0.3);
            [self addSubview:_iconArr];
            
            _txtLocation = [[UILabel alloc]init];
            _txtLocation.text = @"Hồ Chí Minh";
            _txtLocation.frame = CGRectMake(_iconArr.frame.origin.x + h*0.3, h*0.3+3, w*0.14, h*0.4);
            _txtLocation.textAlignment = NSTextAlignmentLeft;
            _txtLocation.font = [UIFont fontWithName:@"Helvetica" size:12];
            [self addSubview:_txtLocation];
            
        }
        else if(typeSearch == 2)
        {
            self.backgroundColor = [UIColor colorWithRed:247.0f/255.0f green:247.0f/255.0f blue:247.0f/255.0f alpha:1.0f];
            self.layer.cornerRadius = 6;
            self.layer.masksToBounds = YES;
            UIImage *imgSearch = [UIImage imageNamed:@"search"];
            _iconSearch = [[UIImageView alloc]initWithImage:imgSearch];
            [_iconSearch sizeToFit];
            _iconSearch.contentMode = UIViewContentModeScaleAspectFit;
            _iconSearch.frame = CGRectMake(h*0.1 +10, h*0.3, h*0.4, h*0.4);
            [self addSubview:_iconSearch];
            
            
            
            
        }
    }
    return self;
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)SearchFoodName
{
    
}

@end
