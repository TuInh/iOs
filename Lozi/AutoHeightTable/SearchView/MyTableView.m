//
//  MyTableView.m
//  CustomViewSearch
//
//  Created by AnhLTV on 5/17/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

#import "MyTableView.h"
#import "SearchViewCellTableViewCell.h"
@implementation MyTableView

CGFloat w,h;

-(instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
         w = [[UIScreen mainScreen] bounds].size.width;
        h = [[UIScreen mainScreen] bounds].size.height;
        _identifier = @"NormalCell";
        _identifierView = @"CellWithView";
        _identifierSearch = @"SearchViewCellTableViewCell";
        _identifierComment = @"CommentViewCellTableViewCell;";
        _identifierRecommend = @"RecommendTableViewCell";
        _identifierAlbumsUser = @"AlbumUserTableViewCell";
        _myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, self.frame.size.height)];
        _myTable.backgroundColor = [UIColor colorWithRed:228.0f/255.0f green:228.0f/255.0f blue:228.0f/255.0f alpha:1];

        self.myTable.delegate = self;
        self.myTable.dataSource = self;
        self.myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.myTable registerClass:[SearchViewCellTableViewCell class] forCellReuseIdentifier:_identifierSearch];
        [self.myTable registerClass:[CommentTableViewCell class] forCellReuseIdentifier:_identifierComment];
        [self.myTable registerClass:[RecommendTableViewCell class] forCellReuseIdentifier:_identifierRecommend];
        [self.myTable registerClass:[AlbumUserTableViewCell class] forCellReuseIdentifier:_identifierAlbumsUser];
        UILabel *label = [[UILabel alloc] init];
        label.text = @"Xac Dinh Vi tri";
        label.frame = CGRectMake(1, 1, 260, 30);
        _view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
        [_view1 addSubview:label];
        [self addSubview:_myTable];
        
        
        
        
        
    }
    return self;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.sectionContents != nil)
    {
        
        
        NSDictionary* sectionObject = self.sectionContents[section];
        NSArray* contentArr = [sectionObject objectForKey:@"content"];
         NSNumber* sectionType = [sectionObject objectForKey:@"type"];
        if (sectionType.intValue == 9) {
            //return 1;
            return  MIN(_numberOfRowEachSection,contentArr.count );
        }
        else
        {
             return contentArr.count;
        }
       
    }
    
    
    

    return 0;
    
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.sectionContents != nil)
    {
        return self.sectionContents.count;
    }
    return 0;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* cellSectionModel = self.sectionContents[indexPath.section];
    NSNumber* sectionType = [cellSectionModel objectForKey:@"type"];
    NSArray* contentArr = [cellSectionModel objectForKey:@"content"];
    // return height of comment tableview cell
    if(sectionType.intValue == 6)
    {
        //return  UITableViewAutomaticDimension;
        //return h/2;
        
        
        
        CommentTableViewCell *cell1 = [[CommentTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:_identifierComment] ;
        CommentModel *commentModel = contentArr[indexPath.row];
        [cell1 loadDataModel:commentModel];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell1.expectedViewHeight;
    }
    // return height of recomment tableview cell
    else if ( sectionType.intValue == 8) {
        RecommendTableViewCell* cell1 = [[RecommendTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:_identifierRecommend] ;
            
        
        RecommendModel *recommentModel = contentArr[indexPath.row];
        [cell1 loadDataModel:recommentModel];
        
        return cell1.frame.size.height + 10;
        
        
    }
    //return height of albumUser cell
    else if (sectionType.integerValue == 9)
    {
        AlbumUserTableViewCell*  cell1 = [[AlbumUserTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:_identifierRecommend] ;
        
        
        AlbumsModel *albumsModel = contentArr[indexPath.row];
        [cell1 loadDataModel:albumsModel];
        
        return cell1.frame.size.height + 10;
        

    }
    else if(sectionType.integerValue == 11 || sectionType.integerValue == 12)
    {
        return  h/13;
    }
    else
    {
        return h/10;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* cellSectionModel = self.sectionContents[indexPath.section];
    NSArray* contentArr = [cellSectionModel objectForKey:@"content"];
    NSNumber* sectionType = [cellSectionModel objectForKey:@"type"];
    
    if ( sectionType.intValue == 1) {
        UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:_identifier];
        if(cell1 == nil)
        {
            cell1 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:_identifier] ;
            
        }
        
        [cell1.textLabel setText:contentArr[indexPath.row]];
        
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell1;
    }
    else if ( sectionType.intValue == 2) {
        SearchViewCellTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:_identifierSearch];
        if(cell1 == nil)
        {
            cell1 = [[SearchViewCellTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:_identifierSearch] ;
            
        }
        AlbumsModel* albumModel = contentArr[indexPath.row];
        [cell1.imgView sd_setImageWithURL:[NSURL URLWithString: [albumModel.thumbnails objectAtIndex:0]]];
        [cell1.foodName setText:albumModel.name];
        [cell1.foodDescription setTextColor:[UIColor grayColor]];
        [cell1.foodDescription setText:[albumModel.block stringByAppendingString:@" ảnh"]];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell1;


    }
    else if ( sectionType.intValue == 3) {
        SearchViewCellTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:_identifierView];
        if(cell1 == nil)
        {
            cell1 = [[SearchViewCellTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:_identifierView] ;
            
        }
        EateryModel* eateryModel = contentArr[indexPath.row];
         NSLog(@"%@",eateryModel.avatar);
        
        [cell1.imgView sd_setImageWithURL:[NSURL URLWithString: eateryModel.avatar]];
        [cell1.foodName setText:eateryModel.name];
        [cell1.foodDescription setText:eateryModel.address.short_address];
        [cell1.foodDescription setTextColor:[UIColor grayColor]];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell1;
        
        
    }
    else if ( sectionType.intValue == 4) {
        SearchViewCellTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:_identifierView];
        if(cell1 == nil)
        {
            cell1 = [[SearchViewCellTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:_identifierView] ;
            
        }
        UserModel* userModel = contentArr[indexPath.row];
        
        [cell1.imgView sd_setImageWithURL:[NSURL URLWithString: userModel.avatar]];
        [cell1.foodName setText:userModel.fullname];
        [cell1.foodDescription setText:userModel.city];
        [cell1.foodDescription setTextColor:[UIColor grayColor]];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell1;
        
        
    }
    else if ( sectionType.intValue == 11) {
        SearchViewCellTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:_identifierView];
        if(cell1 == nil)
        {
            cell1 = [[SearchViewCellTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:_identifierView] ;
            
        }
        MenuModel* menuModel = contentArr[indexPath.row];
       
        
        [cell1.imgView sd_setImageWithURL:[NSURL URLWithString: menuModel.image]];
        [cell1.foodName setText:menuModel.foodName];
        [cell1.foodDescription setText:[NSString stringWithFormat:@"%@ đ",menuModel.price]];
        cell1.foodName.textColor = [UIColor colorWithRed:41.0f/255.0f green:91.0f/255.0f blue:132.0f/255.0f alpha:1];
        cell1.foodDescription.textColor = [UIColor greenColor];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        cell1.backgroundColor = [UIColor whiteColor];
        return cell1;
        
        
    }
    else if ( sectionType.intValue == 5) {
        UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:_identifier];
        if(cell1 == nil)
        {
            cell1 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:_identifier] ;
            
        }
       // CommentModel *commentModel = contentArr[indexPath.row];
        
        cell1.textLabel.text = @"Xem thêm bình luận";
        cell1.textLabel.textColor = [UIColor blueColor];
        cell1.textLabel.textAlignment = NSTextAlignmentCenter;
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell1;
        
        
    }
    else if ( sectionType.intValue == 6) {
        CommentTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:_identifierComment forIndexPath: indexPath];
        if(cell1 == nil)
        {
            cell1 = [[CommentTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:_identifierComment] ;
            
        }
        CommentModel *commentModel = contentArr[indexPath.row];
        [cell1 loadDataModel:commentModel];
        
       // [cell1.foodName setText:eateryModel.name];
       // [cell1.foodDescription setText:eateryModel.address.short_address];
        //[cell1.foodDescription setTextColor:[UIColor redColor]];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell1;
        
        
    }

    else if ( sectionType.intValue == 8) {
        RecommendTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:_identifierRecommend forIndexPath: indexPath];
        if(cell1 == nil)
        {
            cell1 = [[RecommendTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:_identifierRecommend] ;
            
        }
        RecommendModel *recommentModel = contentArr[indexPath.row];
        [cell1 loadDataModel:recommentModel];
        
        // [cell1.foodName setText:eateryModel.name];
        // [cell1.foodDescription setText:eateryModel.address.short_address];
        //[cell1.foodDescription setTextColor:[UIColor redColor]];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell1;
        
        
    }
    else if ( sectionType.intValue == 7) {
        UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:_identifier];
        if(cell1 == nil)
        {
            cell1 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:_identifier] ;
            
        }
        // CommentModel *commentModel = contentArr[indexPath.row];
        
        cell1.textLabel.text = @"Địa điểm liên quan";
        cell1.textLabel.textColor = [UIColor blackColor];
        cell1.textLabel.textAlignment = NSTextAlignmentCenter;
        [cell1.textLabel setCenter:CGPointMake(w/2, cell1.textLabel.frame.origin.y)];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        cell1.backgroundColor = [UIColor colorWithRed:228.0f/255.0f green:228.0f/255.0f blue:228.0f/255.0f alpha:1];

        return cell1;
        
    }
    
    else if ( sectionType.intValue == 9) {
        AlbumUserTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:_identifierAlbumsUser forIndexPath: indexPath];
        if(cell1 == nil)
        {
            cell1 = [[AlbumUserTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:_identifierAlbumsUser] ;
            
        }
        AlbumsModel *albumstModel = contentArr[indexPath.row];
        [cell1 loadDataModel:albumstModel];
        
        // [cell1.foodName setText:eateryModel.name];
        // [cell1.foodDescription setText:eateryModel.address.short_address];
        //[cell1.foodDescription setTextColor:[UIColor redColor]];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell1;
        
        
    }


    else if ( sectionType.intValue == 10) {
        UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:_identifier];
        if(cell1 == nil)
        {
            cell1 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:_identifier] ;
    
        }
        
        cell1.textLabel.text = @"Xem thêm bộ sưu tập";
        
        return cell1;
        
    }
    else if ( sectionType.intValue == 12) {
        UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:_identifier];
        if(cell1 == nil)
        {
            cell1 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:_identifier] ;
            
        }
        cell1.backgroundColor = [UIColor whiteColor];
        cell1.imageView.image = [UIImage imageNamed:@"spoonAndForkOrange"];
        
        return cell1;
        
    }

   /*
   else
    {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_identifierView];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:_identifierView] ;
            
        }
        else{
            [[cell.contentView viewWithTag:500] removeFromSuperview];
            
        }
        _view1.tag = 500;
        [cell.contentView addSubview:_view1];
        return cell;
    }
    */
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  
    NSDictionary* cellSectionModel = self.sectionContents[section];
    NSNumber* sectionType = [cellSectionModel objectForKey:@"type"];
    NSString* caption = [cellSectionModel objectForKey:@"caption"];
    if (sectionType.intValue == 5 || sectionType.intValue == 6 || sectionType.intValue == 7 || sectionType.intValue == 8 || sectionType.intValue == 9|| sectionType.intValue == 10 ||sectionType.intValue == 11|| sectionType.intValue == 12) {
        return nil;
    }
    else
    {
    return caption;
    }
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* cellSectionModel = self.sectionContents[indexPath.section];
    NSNumber* sectionType = [cellSectionModel objectForKey:@"type"];
    if (sectionType.integerValue == 10) {
        cell.backgroundColor = [UIColor colorWithRed:228.0f/255.0f green:228.0f/255.0f blue:228.0f/255.0f alpha:1];
        [cell.textLabel setBackgroundColor:[UIColor colorWithRed:228.0f/255.0f green:228.0f/255.0f blue:228.0f/255.0f alpha:1]];
        [cell.textLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleCaption1]];
        [cell.textLabel setTextColor:[UIColor blueColor]];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.textLabel sizeToFit];
        [cell.textLabel setFrame:CGRectMake(cell.frame.size.width/2-cell.textLabel.frame.size.width/2, cell.textLabel.frame.origin.y, cell.textLabel.frame.size.width, cell.textLabel.frame.size.height)];
           }
    
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *mylabel = [[UILabel alloc] init];
    mylabel.frame = CGRectMake(10, 0, 320, 30);
    mylabel.font = [UIFont boldSystemFontOfSize:12];
    mylabel.text = [self tableView:_myTable titleForHeaderInSection:section];
    UIView *view = [[UIView alloc]init];
    [view addSubview:mylabel];
    return view;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.row);
    NSDictionary* cellSectionModel = self.sectionContents[indexPath.section];
    NSArray* contentArr = [cellSectionModel objectForKey:@"content"];
    NSNumber* sectionType = [cellSectionModel objectForKey:@"type"];
    
    if (sectionType.intValue == 2) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        AlbumsModel* albumModel = contentArr[indexPath.row];
        NSDictionary *dictionaryLink = [NSDictionary dictionaryWithObject:albumModel forKey:@"album"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Jump Detail Album" object:nil userInfo:dictionaryLink];
    }
    if (sectionType.intValue == 3) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        EateryModel* eateryModel = contentArr[indexPath.row];
        NSString *slug = eateryModel.slug;
       
        NSDictionary *dictionaryLink = [NSDictionary dictionaryWithObject:slug forKey:@"eatery"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Jump Detail Eatery" object:nil userInfo:dictionaryLink];
    }
    if (sectionType.intValue == 4) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        UserModel* userModel = contentArr[indexPath.row];
        NSDictionary *dictionaryLink = [NSDictionary dictionaryWithObject:userModel forKey:@"user"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Jump Detail User" object:nil userInfo:dictionaryLink];
    }

    if (sectionType.intValue == 5) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Jump More comment" object:nil userInfo:nil];
    }
    
    if (sectionType.intValue == 10) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Jump More Album User" object:nil userInfo:nil];
    }

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
