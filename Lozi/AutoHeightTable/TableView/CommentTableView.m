//
//  CommentTableView.m
//  AutoHeightTable
//
//  Created by AnhLTV on 7/16/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import "CommentTableView.h"


@implementation CommentTableView
-(instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.cellIdentifer = @"CommentTableViewCell";
        self.backgroundColor = [AppConfig GetAppBackgroundColor];
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[CommentTableViewCell class] forCellReuseIdentifier:self.cellIdentifer];
        self.commentLoader = [[CommentLoader alloc] init];
        self.commentLoader.tableView = self;
    }
    return self;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.commentLoader.dataArray.count;
    
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentTableViewCell *cell1 = [[CommentTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:self.cellIdentifer] ;
    CommentModel *commentModel = self.commentLoader.dataArray[indexPath.row];
    [cell1 loadDataModel:commentModel];
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell1.expectedViewHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    CommentTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifer forIndexPath: indexPath];
    if(cell1 == nil)
    {
        cell1 = [[CommentTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:self.cellIdentifer] ;
            
    }
    CommentModel *commentModel = self.commentLoader.dataArray[indexPath.row];
    [cell1 loadDataModel:commentModel];
    
    
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell1;
    
    
}

-(void) setCommentID:(NSString*) commentID;
{
    _commentID = commentID;
    [self.commentLoader ReloadDataWithURL: [NSString stringWithFormat:@"%@/blocks/%@/comments?cityId=%ld", [AppConfig GetBaseNextPageUrl], commentID, [AppConfig GetCityID]]];
}

@end
