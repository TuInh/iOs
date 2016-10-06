//
//  MenuModel.h
//  LoadSearchView
//
//  Created by AnhLTV on 7/19/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
@interface MenuModel : JSONModel
@property(strong,nonatomic)NSString *image;
@property(strong,nonatomic)NSString *foodName;
@property(strong,nonatomic)NSString *price;
@end
