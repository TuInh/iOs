//
//  EventCollectionViewCell.m
//  AutoHeightTable
//
//  Created by AnhLTV on 7/11/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import "EventCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation EventCollectionViewCell
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    
    self = [super initWithCoder:coder];
    if (self) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        
    }
    return self;
}
-(void) setupView
{
    if (self)
    {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        self.coverImage = [[UIImageView alloc] init];
        [self addSubview: self.coverImage];
        
        self.titleLabel = [[UILabel alloc] init];
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:12.0f]];
        [self addSubview: self.titleLabel];
        
        self.descriptionLabel = [[UILabel alloc] init];
        [self.descriptionLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [self.descriptionLabel setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        [self.descriptionLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [self.descriptionLabel setNumberOfLines:0];
        [self addSubview: self.descriptionLabel];
        
        self.inprogressLabel = [[UILabel alloc] init];
        [self.inprogressLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [self addSubview: self.inprogressLabel];
        
        self.attendedLabel = [[UILabel alloc] init];
        [self.attendedLabel setFont:[UIFont boldSystemFontOfSize:12.0f]];
        [self addSubview: self.attendedLabel];
        
        
        
        self.attendedView = [[UIView alloc] init];
        [self addSubview: self.attendedView];

    }
}


-(void) setModelData:(EventModel*) dataModel
{
    self.dataModel = dataModel;
    float viewMargin = [AppConfig GetViewMargin];
    
    [self.coverImage setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width/2.0f)];
    [self.coverImage sd_setImageWithURL: [NSURL URLWithString:dataModel.coverMobile]];
    
    [self.titleLabel setFrame:CGRectMake(viewMargin,
                                               self.coverImage.frame.origin.y + self.coverImage.frame.size.height + viewMargin,
                                               self.frame.size.width - 2.0f*viewMargin, 10.0f)];
    [self.titleLabel setText:dataModel.title];
    [self.titleLabel sizeToFit];
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    NSString* currentDateString = [dateFormatter stringFromDate:[NSDate date]];
    if ([currentDateString compare:dataModel.startTime] == NSOrderedAscending)
    {
        [self.inprogressLabel setTextColor:[UIColor greenColor]];
        [self.inprogressLabel setText:@"Chưa diễn ra"];
    }
    else
    {
        if ([currentDateString compare:dataModel.endTime] == NSOrderedAscending)
        {
            [self.inprogressLabel setTextColor:[UIColor greenColor]];
            [self.inprogressLabel setText:@"Đang diễn ra"];
        }
        else
        {
            [self.inprogressLabel setTextColor:[UIColor grayColor]];
            [self.inprogressLabel setText:@"Đã kết thúc"];
        }
    }
    [self.inprogressLabel sizeToFit];
    [self.inprogressLabel setFrame:CGRectMake(self.frame.size.width - viewMargin*2.0f - self.inprogressLabel.frame.size.width,
                                              self.titleLabel.frame.origin.y,
                                              self.inprogressLabel.frame.size.width,
                                              self.inprogressLabel.frame.size.height)];
    
    [self.descriptionLabel setFrame:CGRectMake(viewMargin,
                        self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + viewMargin,
                        self.frame.size.width - 2.0f*viewMargin, 10.0f)];
    [self.descriptionLabel setText:dataModel.mota];
    [self.descriptionLabel sizeToFit];
    
    
    [self.attendedLabel setFrame:CGRectMake(viewMargin,
                                               self.descriptionLabel.frame.origin.y + self.descriptionLabel.frame.size.height + viewMargin,
                                               self.frame.size.width - 2.0f*viewMargin
                                            , 10.0f)];
    [self.attendedLabel setText:[NSString stringWithFormat:@"%ld Người tham gia", dataModel.numberOfAttendee]];
    [self.attendedLabel sizeToFit];
    
    float imageMargin = 5.0f;
    float itemImageWidth = ((self.frame.size.width - 2.0f*viewMargin)/ 10.0f) - imageMargin;
    [self.attendedView setFrame:CGRectMake(viewMargin,
                                          self.attendedLabel.frame.origin.y + self.attendedLabel.frame.size.height + viewMargin,
                                          self.frame.size.width - 2.0f*viewMargin,
                                          itemImageWidth + 10.0f)];
    
    NSArray *viewsToRemove = [self.attendedView subviews];
    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
    }
    

    for (int i = 0; (i < dataModel.attendee.count); i++)
    {
        if (i > 9)
        {
            break;
        }
        UIImageView* itemImage = [[UIImageView alloc] initWithFrame:CGRectMake((float)(i)*(itemImageWidth + imageMargin) + imageMargin , 5.0f, itemImageWidth, itemImageWidth)];
        itemImage.layer.cornerRadius = itemImageWidth / 2.0f;
        itemImage.layer.masksToBounds = true;
        itemImage.layer.borderWidth = 1.0f;
        itemImage.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        AttendeeModel* attendeeModel =dataModel.attendee[i];
        [itemImage sd_setImageWithURL: [NSURL URLWithString:attendeeModel.avatar]];
        [self.attendedView addSubview:itemImage];
    }
    
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.attendedView.frame.origin.y + self.attendedView.frame.size.height + viewMargin)];
}

+(NSString*) getClassIndentifier
{
    return @"EventCollectionViewCell";
}

@end
