//
//  FoodDetailViewController.m
//  AutoHeightTable
//
//  Created by AnhLTV on 7/15/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import "FoodDetailViewController.h"
#import "FoodCollectionViewLayout.h"

@implementation FoodDetailViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self initViewControl];
        
    }
    
    return self;
}

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        [self initViewControl];
        
    }
    
    return self;
}

-(instancetype) initWithFrame:(CGRect) frame
{
    self = [super init];
    if (self)
    {
        [self.view setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self initViewControl];
        
    }
    
    return self;
}

-(void )initViewControl
{
    [self.view setBackgroundColor:[AppConfig GetAppBackgroundColor]];
    float borderConner = 4.0f;
    
    self.scrollViewContainer = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.scrollViewContainer.showsVerticalScrollIndicator = NO;
    self.scrollViewContainer.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:self.scrollViewContainer];
    
    //Food Infomation
    self.foodContainer = [[UIView alloc] init];
    [self.foodContainer setBackgroundColor:[UIColor whiteColor]];
    self.foodContainer.layer.cornerRadius = borderConner;
    self.foodContainer.clipsToBounds = true;
    [self.scrollViewContainer addSubview:self.foodContainer];
    
    self.foodImageView = [[UIImageView alloc] init];
    [self.foodContainer addSubview:self.foodImageView];
    
    self.foodNameLabel = [[UILabel alloc] init];
    [self.foodNameLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
    [self.foodNameLabel setTextColor:[UIColor blackColor]];
    [self.foodNameLabel setNumberOfLines: 0];
    [self.foodNameLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.foodContainer  addSubview:self.foodNameLabel];
    
    self.foodPriceLabel = [[UILabel alloc] init];
    [self.foodPriceLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [self.foodPriceLabel setTextColor:[UIColor purpleColor]];
    [self.foodContainer  addSubview:self.foodPriceLabel];
    
    
    //Count View Container
    self.countViewContainer = [[UIView alloc] init];
    [self.foodContainer addSubview:self.countViewContainer];

    
    //Pin view
    UIFont* likeTextFont = [UIFont systemFontOfSize:11.0f];
    self.pinViewContainer = [[UIView alloc] init];
    [self.pinViewContainer setBackgroundColor:[AppConfig GetAppBackgroundColor]];
    self.pinViewContainer.layer.cornerRadius = borderConner;
    self.pinViewContainer.clipsToBounds = true;
    [self.countViewContainer addSubview:self.pinViewContainer];
    
    self.pinIcon = [[UIImageView alloc]init];
    [self.pinViewContainer addSubview:self.pinIcon];
    
    self.pinLabel = [[UILabel alloc]init];
    [self.pinLabel setTextColor:[UIColor grayColor]];
    [self.pinLabel setFont:likeTextFont];
    [self.pinViewContainer addSubview:self.pinLabel];
    
    
    
    //Like View
    self.likeViewContainer = [[UIView alloc] init];
    [self.likeViewContainer setBackgroundColor:[AppConfig GetAppBackgroundColor]];
    self.likeViewContainer.layer.cornerRadius = borderConner;
    self.likeViewContainer.clipsToBounds = true;
    [self.countViewContainer addSubview:self.likeViewContainer];
    
    
    self.likeLabel = [[UILabel alloc] init];
    [self.likeLabel setTextColor:[UIColor grayColor]];
    [self.likeLabel setFont:likeTextFont];
    [self.likeViewContainer addSubview:self.likeLabel];
    
    self.likeIcon = [[UIImageView alloc] init];
    [self.likeViewContainer addSubview:self.likeIcon];
    
    //Comment View
    self.commentContainer = [[UIView alloc] init];
    [self.commentContainer setBackgroundColor:[AppConfig GetAppBackgroundColor]];
    self.commentContainer.layer.cornerRadius = borderConner;
    self.commentContainer.clipsToBounds = true;
    [self.countViewContainer addSubview:self.commentContainer];
    
    
    self.commentLabel = [[UILabel alloc] init];
    [self.commentLabel setTextColor:[UIColor grayColor]];
    [self.commentLabel setFont:likeTextFont];
    [self.commentContainer addSubview:self.commentLabel];
    
    self.commentIcon = [[UIImageView alloc] init];
    [self.commentContainer addSubview:self.commentIcon];
    
    //Shop View
    UIColor* shopTextColor = [UIColor blueColor];
    float shopFontSize = 12.0f;
    self.shopViewContainer = [[UIView alloc] init];
    self.shopViewContainer.layer.borderColor = [shopTextColor CGColor];
    self.shopViewContainer.layer.borderWidth = 1.0f;
    self.shopViewContainer.layer.cornerRadius = borderConner;
    self.shopViewContainer.clipsToBounds = true;
    [self.foodContainer addSubview:self.shopViewContainer];
    
    
    self.shopNameLabel = [[UILabel alloc] init];
    [self.shopNameLabel setFont:[UIFont boldSystemFontOfSize:shopFontSize]];
    [self.shopNameLabel setTextColor:shopTextColor];
    [self.shopNameLabel setNumberOfLines: 0];
    [self.shopNameLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.shopViewContainer addSubview:self.shopNameLabel];
    
    
    self.shopAddressLabel = [[UILabel alloc] init];
    [self.shopAddressLabel setFont:[UIFont systemFontOfSize:shopFontSize]];
    [self.shopAddressLabel setTextColor:[UIColor grayColor]];
    [self.shopAddressLabel setNumberOfLines:0];
    [self.shopAddressLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.shopViewContainer addSubview:self.shopAddressLabel];
    
    
    
    self.shopTimeLabel = [[UILabel alloc] init];
    [self.shopTimeLabel setFont:[UIFont systemFontOfSize:shopFontSize]];
    [self.shopTimeLabel setTextColor:[UIColor blackColor]];
    [self.shopTimeLabel setNumberOfLines: 0];
    [self.shopTimeLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.shopViewContainer addSubview:self.shopTimeLabel];
    
    self.shopButton = [[UIButton alloc] init];
    [self.shopButton setImage:[UIImage imageNamed:@"nextBlue"] forState:UIControlStateNormal];
    [self.shopViewContainer addSubview:self.shopButton];
    
    
    //Caption View
    self.captionViewContainer = [[UIView alloc] init];
    [self.captionViewContainer setBackgroundColor:[UIColor whiteColor]];
    self.captionViewContainer.layer.cornerRadius = borderConner;
    self.captionViewContainer.clipsToBounds = true;
    [self.scrollViewContainer addSubview:self.captionViewContainer];
    
    self.captionAvartImage = [[UIImageView alloc] init];
    [self.captionViewContainer addSubview:self.captionAvartImage];
    
    float captionTextSize = 12.0f;
    self.captionUserLabel = [[UILabel alloc] init];
    [self.captionUserLabel setTextColor:[UIColor blackColor]];
    [self.captionUserLabel setFont:[UIFont boldSystemFontOfSize:captionTextSize]];
    [self.captionViewContainer addSubview:self.captionUserLabel];
    
    self.captionPlaceLabel = [[UILabel alloc] init];
    [self.captionPlaceLabel setTextColor:[UIColor grayColor]];
    [self.captionPlaceLabel setFont:[UIFont systemFontOfSize:captionTextSize]];
    [self.captionViewContainer addSubview:self.captionPlaceLabel];
    
    
    self.captionMessageLabel = [[UILabel alloc] init];
    [self.captionMessageLabel setTextColor:[UIColor blackColor]];
    [self.captionMessageLabel setFont:[UIFont systemFontOfSize:captionTextSize]];
    [self.captionMessageLabel setNumberOfLines:0] ;
    [self.captionMessageLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.captionViewContainer addSubview:self.captionMessageLabel];
    
    
    self.captionTimeLabel = [[UILabel alloc] init];
    [self.captionTimeLabel setTextColor:[UIColor grayColor]];
    [self.captionTimeLabel setFont:[UIFont systemFontOfSize:captionTextSize]];
    [self.captionViewContainer addSubview:self.captionTimeLabel];
    
    
    
    float viewMargin = [AppConfig GetViewMargin];
    float tableWidth = self.scrollViewContainer.frame.size.width - viewMargin * 2.0f;
    self.commentTableView = [[CommentTableView alloc] initWithFrame:CGRectMake(viewMargin, 1, tableWidth, 1)];
    self.commentTableView.commentLoader.dataLoaderDelegate = self;
    [self.scrollViewContainer addSubview: self.commentTableView];
    
    self.abumViewContainer = [[UIView alloc] init];
    [self.scrollViewContainer addSubview: self.abumViewContainer];
    
    
    self.relatedLabel = [[UILabel alloc] init];
    [self.relatedLabel setTextColor:[UIColor blackColor]];
    [self.relatedLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [self.relatedLabel setText: @"Hình ảnh liên quan"];
    [self.relatedLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.scrollViewContainer addSubview: self.relatedLabel];
    
    FoodCollectionViewLayout* collectionLayout = [[FoodCollectionViewLayout alloc] init];
    self.relateCollectionView = [[FoodCollectionView alloc] initWithFrame:CGRectMake(0, 0, self.scrollViewContainer.frame.size.width, 0) collectionViewLayout:collectionLayout];
    [self.relateCollectionView setParentScrollView:self.scrollViewContainer];
    self.relateCollectionView.showsVerticalScrollIndicator = false;
    
    self.foodLoader = [[FoodLoader alloc] init];
    self.foodLoader.dataLoaderDelegate = self;
    self.relateCollectionView.dataLoader = self.foodLoader;
    
    
    [self.scrollViewContainer addSubview: self.relateCollectionView];
}


- (void) reloadViewLayout
{
    if (self.foodModel != nil)
    {
        float viewMargin = [AppConfig GetViewMargin];
        float foodContainerWidth = self.scrollViewContainer.frame.size.width - 2.0f * viewMargin;
        
        //Food Image
        [self.foodImageView setFrame:CGRectMake(0, 0, foodContainerWidth, foodContainerWidth / self.foodModel.scale)];
        [self.foodImageView setBackgroundColor:[UIColor brownColor]];
        [self.foodImageView sd_setImageWithURL:[NSURL URLWithString:self.foodModel.image]];
        
    
        
        //Food Name
        float foodNameMargin = 2.0f * viewMargin;
        float foodNameWidth = self.foodImageView.frame.size.width - 2.0f * foodNameMargin;
        [self.foodNameLabel setFrame:CGRectMake(foodNameMargin,
                                                self.foodImageView.frame.origin.y + self.foodImageView.frame.size.height + viewMargin,
                                                foodNameWidth,
                                                1.0f)];
        [self.foodNameLabel setText:self.foodModel.dish.foodName];
        [self.foodNameLabel sizeToFit];
        [self.foodNameLabel setFrame:CGRectMake((foodContainerWidth - self.foodNameLabel.frame.size
                                                 .width) / 2.0f,
                                                self.foodImageView.frame.origin.y + self.foodImageView.frame.size.height + viewMargin,
                                                self.foodNameLabel.frame.size.width,
                                                self.foodNameLabel.frame.size.height)];
        


        
        //Food Price
        if (self.foodModel.dish.priceFloat <= 0.1f)
        {
            [self.foodPriceLabel setText:@"Đang cập nhật"];
        }
        else
        {
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
            [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
            int intVal = (int) self.foodModel.dish.priceFloat;
            NSString* strPrice = [numberFormatter stringFromNumber:[NSNumber numberWithInt:intVal]];
            [self.foodPriceLabel setText:[NSString stringWithFormat:@"%@ đ", strPrice]];
        }
        
        [self.foodPriceLabel setFrame:CGRectMake(foodNameMargin,
                                                 self.foodNameLabel.frame.origin.y + self.foodNameLabel.frame.size.height + viewMargin,
                                                 foodNameWidth,
                                                 1.0f)];
        [self.foodPriceLabel sizeToFit];
        [self.foodPriceLabel setTextAlignment:NSTextAlignmentCenter];
        [self.foodPriceLabel setFrame:CGRectMake((foodContainerWidth - self.foodPriceLabel.frame.size
                                                  .width) / 2.0f,
                                                 self.foodNameLabel.frame.origin.y + self.foodNameLabel.frame.size.height + viewMargin,
                                                 self.foodPriceLabel.frame.size.width,
                                                 self.foodPriceLabel.frame.size.height)];

        
        
      
        
        //Pin View
        [self.pinLabel setText:[NSString stringWithFormat:@"%d", self.foodModel.foodCount.pin]];
        [self.pinLabel sizeToFit];

        [self.pinIcon setFrame:CGRectMake(viewMargin, viewMargin, self.pinLabel.frame.size.height, self.pinLabel.frame.size.height)];
        [self.pinIcon setImage:[UIImage imageNamed:@"miniPinGray"]];
        [self.pinLabel setFrame:CGRectMake(self.pinIcon.frame.origin.x + self.pinIcon.frame.size.width + viewMargin,
                                           viewMargin,
                                           self.pinLabel.frame.size.width,
                                           self.pinLabel.frame.size.height)];
        [self.pinViewContainer setFrame:CGRectMake(0.0f,
                                                   0.0f,
                                                   self.pinLabel.frame.origin.x + self.pinLabel.frame.size.width + viewMargin,
                                                   self.pinLabel.frame.origin.y + self.pinLabel.frame.size.height + viewMargin)];
        
        //Like View
        [self.likeLabel setText:[NSString stringWithFormat:@"%d", self.foodModel.foodCount.like]];
        [self.likeLabel sizeToFit];
        
        [self.likeIcon setFrame:CGRectMake(viewMargin, viewMargin, self.likeLabel.frame.size.height, self.likeLabel.frame.size.height)];
        [self.likeIcon setImage:[UIImage imageNamed:@"miniHeartGray"]];
        [self.likeLabel setFrame:CGRectMake(self.likeIcon.frame.origin.x  + self.likeIcon.frame.size.width + viewMargin,
                                           viewMargin,
                                           self.likeLabel.frame.size.width,
                                           self.likeLabel.frame.size.height)];
        [self.likeViewContainer setFrame:CGRectMake(self.pinViewContainer.frame.origin.x + self.pinViewContainer.frame.size.width + viewMargin,
                                                   0.0f,
                                                   self.likeLabel.frame.origin.x + self.likeLabel.frame.size.width + viewMargin,
                                                   self.likeLabel.frame.origin.y + self.likeLabel.frame.size.height + viewMargin)];
        
        //Comment View
        [self.commentLabel setText:[NSString stringWithFormat:@"%d", self.foodModel.foodCount.comment]];
        [self.commentLabel sizeToFit];
        
        [self.commentIcon setFrame:CGRectMake(viewMargin, viewMargin, self.commentLabel.frame.size.height, self.commentLabel.frame.size.height)];
        [self.commentIcon setImage:[UIImage imageNamed:@"miniBubbleGray"]];
        [self.commentLabel setFrame:CGRectMake(self.commentIcon.frame.origin.x  + self.commentIcon.frame.size.width + viewMargin,
                                            viewMargin,
                                            self.commentLabel.frame.size.width,
                                            self.commentLabel.frame.size.height)];
        [self.commentContainer setFrame:CGRectMake(self.likeViewContainer.frame.origin.x + self.likeViewContainer.frame.size.width + viewMargin,
                                                    0.0f,
                                                    self.commentLabel.frame.origin.x + self.commentLabel.frame.size.width + viewMargin,
                                                    self.commentLabel.frame.origin.y + self.commentLabel.frame.size.height + viewMargin)];
        
        float countViewWidht = self.commentContainer.frame.origin.x + self.commentContainer.frame.size.width;
        float countViewHeight = self.commentContainer.frame.size.height;
        float countViewLeft = (foodContainerWidth - countViewWidht) / 2.0f;
        float countViewTop = self.foodPriceLabel.frame.origin.y + self.foodPriceLabel.frame.size.height + viewMargin;
        [self.countViewContainer setFrame:CGRectMake(countViewLeft, countViewTop, countViewWidht, countViewHeight)];
        
        
        //Shop View
        float shopContainerWidth = foodContainerWidth - 2.0f * viewMargin;
        float shopButtonWidht = shopContainerWidth / 16.0f;
        float shopTextWidht = shopContainerWidth - 3.0f * viewMargin - shopButtonWidht;
        
        //Shop Name
        [self.shopNameLabel setText:self.foodModel.dish.eatery.name];
        [self.shopNameLabel setFrame:CGRectMake(viewMargin, viewMargin, shopTextWidht, 12.0f)];
        [self.shopNameLabel sizeToFit];
        
        //Shop Address
        [self.shopAddressLabel setText:self.foodModel.dish.eatery.address.full];
        [self.shopAddressLabel setFrame:CGRectMake(viewMargin,
                                                   viewMargin + self.shopNameLabel.frame.origin.y + self.shopNameLabel.frame.size.height,
                                                   
                                                   shopTextWidht,
                                                   12.0f)];
        [self.shopAddressLabel sizeToFit];
        
        //Shop Time
        if (self.foodModel.dish.eatery.operatingTime.count == 0)
        {
            [self.shopTimeLabel setText:@"🕐24h"];
        }
        else
        {
            OperatingTimeModel* timeModel = [self.foodModel.dish.eatery.operatingTime objectAtIndex:0];
            [self.shopTimeLabel setText:[NSString stringWithFormat:@"🕐%@-%@" , timeModel.start, timeModel.finish]];
        }
        [self.shopTimeLabel setFrame:CGRectMake(viewMargin,
                                                viewMargin + self.shopAddressLabel.frame.origin.y + self.shopAddressLabel.frame.size.height,
                                                
                                                   shopTextWidht,
                                                   12.0f)];
        [self.shopTimeLabel sizeToFit];
        
        //Shop Button
        [self.shopButton setFrame:CGRectMake(shopTextWidht + 2.0f * viewMargin,
                                            self.shopAddressLabel.frame.origin.y,
                                            shopButtonWidht,
                                            shopButtonWidht)];
        
        //Shop Container
        float shopContainerHeight = self.shopTimeLabel.frame.origin.y + self.shopTimeLabel.frame.size.height + viewMargin;
        [self.shopViewContainer setFrame:CGRectMake(viewMargin,
                                                  self.countViewContainer.frame.origin.y + self.countViewContainer.frame.size.height + viewMargin,
                                                  shopContainerWidth,
                                                   shopContainerHeight)];
        
        
        [self.foodContainer setFrame:CGRectMake(viewMargin,
                                               viewMargin,
                                               foodContainerWidth,
                                               self.shopViewContainer.frame.origin.y + self.shopViewContainer.frame.size.height + viewMargin)];
        
        
        //Caption View
        float avatartWidth = foodContainerWidth / 10.0f;
        [self.captionAvartImage setFrame: CGRectMake(viewMargin, viewMargin, avatartWidth, avatartWidth)];
        self.captionAvartImage.layer.cornerRadius = avatartWidth/2.0f;
        self.captionAvartImage.clipsToBounds = true;
        [self.captionAvartImage sd_setImageWithURL:[NSURL URLWithString:self.foodModel.createdBy.avatar]];
        
        float captionTextLeft = avatartWidth + 2.0f * viewMargin;
        float captionTextWidht = foodContainerWidth - captionTextLeft - viewMargin;
        
        //Caption User Name
        [self.captionUserLabel setText:self.foodModel.createdBy.name.short_name];
        [self.captionUserLabel setFrame:CGRectMake(captionTextLeft,
                                                   viewMargin,
                                                   captionTextWidht,
                                                   1)];
        [self.captionUserLabel sizeToFit];
        
        //Caption Place
        [self.captionPlaceLabel setText:[NSString stringWithFormat:@"  @%@",self.foodModel.createdBy.username ]];
        [self.captionPlaceLabel setFrame:CGRectMake(self.captionUserLabel.frame.origin.x + self.captionUserLabel.frame.size.width,
                                                   viewMargin,
                                                   captionTextWidht,
                                                   1)];
        [self.captionPlaceLabel sizeToFit];
        [self.captionPlaceLabel setFrame:CGRectMake(self.captionUserLabel.frame.origin.x + self.captionUserLabel.frame.size.width,
                                                    viewMargin,
                                                    captionTextWidht - self.captionUserLabel.frame.size.width,
                                                    self.captionPlaceLabel.frame.size.height)];
        
        //Caption Message
        [self.captionMessageLabel setText:self.foodModel.caption];
        [self.captionMessageLabel setFrame:CGRectMake(captionTextLeft,
                                                      self.captionUserLabel.frame.origin.y + self.captionUserLabel.frame.size.height + viewMargin, captionTextWidht, 1)];
        [self.captionMessageLabel sizeToFit];
        
        //Cpation Time
        [self.captionTimeLabel setText:self.foodModel.createdAt];
        [self.captionTimeLabel setFrame:CGRectMake(captionTextLeft,
                                                      self.captionMessageLabel.frame.origin.y + self.captionMessageLabel.frame.size.height + viewMargin, captionTextWidht, 1)];
        
        [self.captionTimeLabel sizeToFit];
        
        //Caption Container
        [self.captionViewContainer setFrame:CGRectMake(self.foodContainer.frame.origin.x,
                                                      self.foodContainer.frame.origin.y + self.foodContainer.frame.size.height + viewMargin,
                                                      foodContainerWidth,
                                                      self.captionTimeLabel.frame.origin.y + self.captionTimeLabel.frame.size.height + viewMargin)];
        
        //Comment Table
        [self.commentTableView setFrame:CGRectMake( viewMargin,
                                                  self.captionViewContainer.frame.origin.y + self.captionViewContainer.frame.size.height + viewMargin,
                                                   foodContainerWidth,
                                                  self.commentTableView.contentSize.height)];
        
        
        //Related Collection View
        [self.relatedLabel setFrame:CGRectMake(viewMargin,
                                               self.commentTableView.frame.origin.y + self.commentTableView.frame.size.height + viewMargin,
                                               foodContainerWidth,
                                               1.0f)];
        [self.relatedLabel sizeToFit];
        [self.relatedLabel setTextAlignment:NSTextAlignmentCenter];
        [self.relatedLabel setFrame:CGRectMake((self.view.frame.size.width - self.relatedLabel.frame.size.width)/2.0f,
                                               self.commentTableView.frame.origin.y + self.commentTableView.frame.size.height + viewMargin,
                                               self.relatedLabel.frame.size.width,
                                               self.relatedLabel.frame.size.height)];
        
        [self.relateCollectionView setFrame:CGRectMake(0,
                                                       self.relatedLabel.frame.origin.y + self.relatedLabel.frame.size.height + viewMargin,
                                                       self.scrollViewContainer.frame.size.width,
                                                       self.relateCollectionView.contentSize.height)];
        
        //Update main scroolView content size
        [self.scrollViewContainer setContentSize: CGSizeMake(self.scrollViewContainer.frame.size.width, self.relateCollectionView.frame.origin.y + self.relateCollectionView.frame.size.height + 30.f)];
        
        
        
    }
}


-(void) setFoodModel:(FoodModel*) foodModel
{
    _foodModel = foodModel;
    [self.commentTableView.commentLoader ReloadDataWithURL: [AppConfig GetCommentURlWithID:self.foodModel.foodID]];
    [self.relateCollectionView.dataLoader ReloadDataWithURL:[AppConfig GetRelatedURlWithID:self.foodModel.foodID]];
    
    dispatch_async(dispatch_get_main_queue(),
    ^
    {
        [self reloadViewLayout];
    });
}

-(void) onDataLoadedSucessWithData
{
    dispatch_async(dispatch_get_main_queue(),
                   ^
                   {
                        [self reloadViewLayout];
                   });

}
@end
