//
//  CategoryModel.h
//  AutoHeightTable
//
//  Created by AnhLTV on 7/11/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
@interface CategoryModel : JSONModel
@property (strong,nonatomic) NSString *mota;
@property (strong,nonatomic) NSString *imageMobile;
@property (strong,nonatomic) NSString *slug;
@property (strong,nonatomic) NSString *value;
@end
