//
//  CommentModel.h
//  LoadSearchView
//
//  Created by Tu Inh Le on 6/8/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
@interface CommentModel : JSONModel
@property (strong,nonatomic) NSString *avatar;
@property (strong,nonatomic) NSString *username;
@property (strong,nonatomic) NSString *shortname;
@property(strong,nonatomic) NSString *content;
@property (assign,nonatomic) float rating;



@end
