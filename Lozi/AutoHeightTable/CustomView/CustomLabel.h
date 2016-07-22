//
//  CustomLabel.h
//  AutoHeightTable
//
//  Created by AnhLTV on 5/12/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CustomLabelSize) {
    CustomLabelSize_VerySmall = 7,
    CustomLabelSize_Small = 9,
    CustomLabelSize_Normal = 11,
    CustomLabelSize_Large = 14,
    CustomLabelSize_VeryLarge = 18
};

@interface CustomLabel : UILabel
    @property (nonatomic, assign) float currentFontSize;

    -(void) setPlainTextCustomSize: (CustomLabelSize) customSize;
    -(void) setBoldTextCustomSize: (CustomLabelSize) customSize;

@end
