//
//  CustomViewSearch.h
//  CustomViewSearch
//
//  Created by AnhLTV on 5/21/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomViewSearch : UIView<UITextFieldDelegate>
@property UIImageView *iconLozi;

@property UIImageView *iconSearch;
@property UIImageView *iconArr;
@property UITextField *txtSearch;
@property UILabel *txtLocation;
-(instancetype) initWithFrame:(CGRect)frame type:(int) typeSearch;
@end
