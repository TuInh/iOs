//
//  CommentTableViewCell.h
//  LoadSearchView
//
//  Created by AnhLTV on 6/4/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "CommentModel.h"
@interface CommentTableViewCell : UITableViewCell
@property (strong,nonatomic) UIImageView *avatar;
@property (strong,nonatomic) UILabel *name;
@property (strong,nonatomic) UILabel *nick;
@property (strong,nonatomic) UILabel *content;
@property (strong,nonatomic) UILabel *time;
@property(strong,nonatomic) UILabel *rate;
@property(strong,nonatomic) CommentModel *commentModel;

@property(assign,nonatomic) float expectedViewHeight;

-(void) setupView;
-(void) loadDataModel:(CommentModel*) commentModel;
@end
