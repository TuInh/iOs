//
//  CommentTableView.h
//  AutoHeightTable
//
//  Created by AnhLTV on 7/16/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConfig.h"
#import "CommentTableViewCell.h"
#import "CommentLoader.h"

@interface CommentTableView : UITableView<UITableViewDelegate, UITableViewDataSource>
@property(strong, nonatomic) NSString* cellIdentifer;
@property(strong, nonatomic) NSString* commentID;
@property(strong, nonatomic) CommentLoader* commentLoader;

-(void) setCommentID:(NSString*) commentID;
@end

