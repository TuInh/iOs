//
//  NameModel.h
//  AutoHeightTable
//
//  Created by AnhLTV on 5/24/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <JSONModel/JSONModel.h>

@interface NameModel : JSONModel
@property (strong, nonatomic) NSString<Optional>* first;
@property (strong, nonatomic) NSString<Optional>* full;
@property (strong, nonatomic) NSString<Optional>* last;
@property (strong, nonatomic) NSString<Optional>* middle;
@property (strong, nonatomic) NSString<Optional>* short_name;

@end