//
//  AlbumsModel.h
//  LoadSearchView
//
//  Created by AnhLTV on 5/23/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
@protocol AlbumsModel
@end
@interface AlbumsModel : JSONModel
@property (strong, nonatomic) NSString *slug;
@property (strong, nonatomic) NSString *_id;
@property (strong, nonatomic)NSString *name;
@property (strong, nonatomic)NSString *_description;
@property(strong, nonatomic) NSString *username;
@property(strong, nonatomic) NSString *block;
@property(strong,nonatomic) NSArray< NSString*> *thumbnails;

@end