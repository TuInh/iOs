//
//  MyTableView.h
//  CustomViewSearch
//
//  Created by AnhLTV on 5/17/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "EateryModel.h"
#import "CommentTableViewCell.h"
#import "CommentModel.h"
#import "RecommendModel.h"
#import "RecommendTableViewCell.h"
#import "MenuModel.h"
#import "AlbumUserTableViewCell.h"
@interface MyTableView : UIView <UITableViewDelegate,UITableViewDataSource>

@property NSMutableArray *sectionContents;
@property UITableView *myTable;
@property (strong,nonatomic)NSString *identifier;
@property (strong,nonatomic)NSString *identifierView;
@property (strong,nonatomic)NSString *identifierSearch;
@property (strong,nonatomic)NSString *identifierComment;
@property (strong,nonatomic)NSString *identifierRecommend;
@property (strong,nonatomic)NSString *identifierAlbumsUser;
@property(assign,nonatomic) float numberOfRowEachSection;
@property UIView *view1;


@end
