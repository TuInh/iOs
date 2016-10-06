//
//  UISearchBar+Extend.m
//  AutoHeightTable
//
//  Created by AnhLTV on 7/21/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import "UISearchBar+Extend.h"

@implementation UISearchBar (Extend)

- (void)setClearButtonMode:(UITextFieldViewMode)viewMode {
    UITextField *textField = [self findTextFieldInView:self];
    [textField setClearButtonMode:viewMode];
}

- (UITextField *)findTextFieldInView:(UIView *)view {
    
    for (UIView *subview in view.subviews) {
        
        if ([subview isKindOfClass:[UITextField class]] ||
            [subview.class isSubclassOfClass:[UITextField class]]) {
            
            return (UITextField *)subview;
        }
        
        UITextField *textField = [self findTextFieldInView:subview];
        
        if (textField) {
            return textField;
        }
    }
    
    return nil;
}

@end