//
//  CustomLabel.m
//  AutoHeightTable
//
//  Created by AnhLTV on 5/12/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import "CustomLabel.h"

@implementation CustomLabel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setText:@"Ggh"];
        [self setTextColor:[UIColor blackColor]];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {
        [self setText:@"Ggh"];
        [self setTextColor:[UIColor blackColor]];
    }
    return self;
}


- (void)setPlainTextCustomSize:(CustomLabelSize)customSize
{
    //Calculate font size by screen size and size style
    float fontSize = customSize;
    float fontScale = 1.0f;
    
    float scale = [UIScreen mainScreen].scale;
    float screenWidth =  [[UIScreen mainScreen] bounds].size.width * scale;
    if (screenWidth < 640)
    {
        fontScale = 0.75f;
    }
    else if ( (screenWidth >= 640) && (screenWidth < 750))
    {
        fontScale = 1.0f;
    }
    
    else if ( (screenWidth >= 750) && (screenWidth < 1024))
    {
        fontScale = 1.0f;
    }
    
    else
    {
        fontScale = 1.2f;
    }
    float finalFontSize= fontSize * fontScale;
    self.currentFontSize = finalFontSize;
    
    //Set new font size
    [self setFont:[UIFont systemFontOfSize:finalFontSize]];
    
    //Save current label width
    float currentLabelWidth = self.frame.size.width;
    //Reize frame to fit new font size
    [self sizeToFit];
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y,
                              currentLabelWidth, self.frame.size.height)];
    [self setText:@""];
}


-(void) setBoldTextCustomSize: (CustomLabelSize) customSize
{
    //Calculate font size by screen size and size style
    float fontSize = customSize;
    float fontScale = 1.0f;
    
    float scale = [UIScreen mainScreen].scale;
    float screenWidth =  [[UIScreen mainScreen] bounds].size.width * scale;

    if (screenWidth < 640)
    {
        fontScale = 0.75f;
    }
    else if ( (screenWidth >= 640) && (screenWidth < 750))
    {
        fontScale = 1.0f;
    }
    
    else if ( (screenWidth >= 750) && (screenWidth < 1024))
    {
        fontScale = 1.4f;
    }
    
    else
    {
        fontScale = 2.0f;
    }
    float finalFontSize= fontSize * fontScale;
    self.currentFontSize = finalFontSize;
    
    //Set new font size
    [self setFont:[UIFont boldSystemFontOfSize:finalFontSize]];

    //Save current label width
    float currentLabelWidth = self.frame.size.width;
    //Reize frame to fit new font size
    [self sizeToFit];
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y,
                              currentLabelWidth, self.frame.size.height)];
    
    [self setText:@""];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
