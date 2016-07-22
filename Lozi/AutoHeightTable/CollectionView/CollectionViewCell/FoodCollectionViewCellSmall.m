//
//  FoodCollectionViewCell.m
//  AutoHeightTable
//
//  Created by AnhLTV on 5/8/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import "FoodCollectionViewCellSmall.h"

@implementation FoodCollectionViewCellSmall

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
        
        //init for title
        self.foodImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 12)];
        
        self.foodNameLabel = [[CustomLabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 12)];
        [self.foodNameLabel setBoldTextCustomSize:CustomLabelSize_Small];
        
        self.foodAddressLabel = [[CustomLabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 12)];
        [self.foodAddressLabel setBoldTextCustomSize:CustomLabelSize_Small];
        
        [self addSubview:self.foodImageView];
        [self addSubview:self.foodNameLabel];
        [self addSubview:self.foodAddressLabel];
        
        
        //init for item count
        self.pinLabel = [[CustomLabel alloc] init];
        [self.pinLabel setPlainTextCustomSize:CustomLabelSize_Small];
        [self.pinLabel setTextColor:[UIColor grayColor]];
        
        self.likeLabel = [[CustomLabel alloc] init];
        [self.likeLabel setPlainTextCustomSize:CustomLabelSize_Small];
        [self.likeLabel setTextColor:[UIColor grayColor]];
        
        self.commentLabel = [[CustomLabel alloc] init];
        [self.commentLabel setPlainTextCustomSize:CustomLabelSize_Small];
        [self.commentLabel setTextColor:[UIColor grayColor]];
        
        self.pinImageView = [[UIImageView alloc] init];
        [self.pinImageView setImage:[UIImage imageNamed:@"miniPinGray"]];
        
        self.likeImageView = [[UIImageView alloc] init];
        [self.likeImageView setImage:[UIImage imageNamed:@"miniHeartGray"]];
        
        self.commentImageView = [[UIImageView alloc] init];
        [self.commentImageView setImage:[UIImage imageNamed:@"miniBubbleGray"]];
        
        [self addSubview:self.pinLabel];
        [self addSubview:self.pinImageView];
        [self addSubview:self.likeLabel];
        [self addSubview:self.likeImageView];
        [self addSubview:self.commentLabel];
        [self addSubview:self.commentImageView];
        
        
        //init for uploader
        self.nickNameLabel = [[CustomLabel alloc] init];
        [self.nickNameLabel setBoldTextCustomSize:CustomLabelSize_VerySmall];
        [self.nickNameLabel setText:@"Nick name"];
        
        self.descriptionLabel = [[CustomLabel alloc] init];
        [self.descriptionLabel setTextColor:[UIColor grayColor]];
        [self.descriptionLabel setPlainTextCustomSize:CustomLabelSize_VerySmall];
        
        float spacing = self.descriptionLabel.frame.size.height/2.0f;
        float imageWidth = self.nickNameLabel.frame.size.height + self.descriptionLabel.frame.size.height + spacing;
        self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(spacing, spacing, imageWidth, imageWidth)];
        [self.avatarImageView setBackgroundColor:[UIColor brownColor]];
        
        self.borderView = [[UIView alloc]initWithFrame:CGRectMake(spacing, 0, self.frame.size.width - spacing * 2.0f, 1)];
        [self.borderView setBackgroundColor:[UIColor grayColor]];
        [self.borderView setAlpha:0.5f];
        
        [self addSubview:self.borderView];
        [self addSubview:self.avatarImageView];
        [self addSubview:self.nickNameLabel];
        [self addSubview:self.descriptionLabel];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTouched:)];
        singleTap.numberOfTapsRequired = 1;
        singleTap.numberOfTouchesRequired = 1;
        [self.foodImageView addGestureRecognizer:singleTap];
        [self.foodImageView setUserInteractionEnabled:YES];
        
        [self setBackgroundColor:[UIColor whiteColor]];
    }
}


-(void) loadDataModel:(FoodModel*) foodModel
{
    self.dataModel = foodModel;
    [self refreshLayout];

}

-(void) refreshLayout
{
    float marginX = 0.0f;
    float pading = 3.0f;
    float lineSpace = self.foodNameLabel.frame.size.height / 2.0f;
    float viewWidth = self.frame.size.width;
    
    
    //set position for tittle block
    [self.foodImageView setFrame:CGRectMake(marginX,
                                            0,
                                            viewWidth,
                                            viewWidth / self.dataModel.scale)];
    [self.foodImageView setBackgroundColor:[UIColor brownColor]];
    [self.foodImageView sd_setImageWithURL: [NSURL URLWithString: self.dataModel.image]];
    
    [self.foodNameLabel setFrame:CGRectMake(pading,
                                            self.foodImageView.frame.origin.y + self.foodImageView.frame.size.height + lineSpace,
                                            viewWidth - pading * 2.0f,
                                            self.foodNameLabel.frame.size.height)];
    [self.foodNameLabel setText:self.dataModel.dish.foodName];
    
    [self.foodAddressLabel setFrame:CGRectMake(self.foodNameLabel.frame.origin.x,
                                               self.foodNameLabel.frame.origin.y + self.foodNameLabel.frame.size.height + lineSpace,
                                               viewWidth - pading * 2.0f,
                                               self.foodAddressLabel.frame.size.height)];
    [self.foodAddressLabel setText:self.dataModel.dish.eatery.address.full];
    
    
    
    //set position for item count block
    [self.pinLabel setText:[NSString stringWithFormat:@"%d", self.dataModel.foodCount.pin]];
    [self.pinLabel sizeToFit];
    
    [self.likeLabel setText:[NSString stringWithFormat:@"%d", self.dataModel.foodCount.like]];
    [self.likeLabel sizeToFit];
    
    [self.commentLabel setText:[NSString stringWithFormat:@"%d", self.dataModel.foodCount.comment]];
    [self.commentLabel sizeToFit];
    
    float spacing = 3;
    float iconPinWidth = self.pinLabel.frame.size.height;
    
    [self.pinImageView setFrame:CGRectMake(self.foodNameLabel.frame.origin.x,
                                           self.foodAddressLabel.frame.origin.y + self.foodAddressLabel.frame.size.height + lineSpace,
                                           iconPinWidth,
                                           iconPinWidth)];
    [self.pinLabel setFrame:CGRectMake(self.pinImageView.frame.origin.x + iconPinWidth + spacing,
                                       self.pinImageView.frame.origin.y,
                                       self.pinLabel.frame.size.width,
                                       self.pinLabel.frame.size.height)];
    
    
    [self.likeImageView setFrame:CGRectMake(self.pinLabel.frame.origin.x + self.pinLabel.frame.size.width + iconPinWidth,
                                            self.pinImageView.frame.origin.y,
                                            iconPinWidth,
                                            iconPinWidth)];
    [self.likeLabel setFrame:CGRectMake(self.likeImageView.frame.origin.x + spacing + iconPinWidth,
                                        self.pinImageView.frame.origin.y,
                                        self.likeLabel.frame.size.width,
                                        self.likeLabel.frame.size.height)];
    
    [self.commentImageView setFrame:CGRectMake(self.likeLabel.frame.origin.x + self.likeLabel.frame.size.width + iconPinWidth,
                                               self.pinImageView.frame.origin.y,
                                               iconPinWidth,
                                               iconPinWidth)];
    [self.commentLabel setFrame:CGRectMake(self.commentImageView.frame.origin.x + spacing + iconPinWidth,
                                           self.pinImageView.frame.origin.y,
                                           self.commentLabel.frame.size.width,
                                           self.commentLabel.frame.size.height)];
    
    
    //set position for uploader
    [self.avatarImageView sd_setImageWithURL: [NSURL URLWithString: self.dataModel.createdBy.avatar]];
    [self.nickNameLabel setText:self.dataModel.createdBy.username];
    [self.descriptionLabel setText:@"Đã chia sẻ"];
    float avatarImageWidth = self.nickNameLabel.frame.size.height + self.descriptionLabel.frame.size.height + spacing;
    
    [self.borderView setFrame: CGRectMake(self.foodNameLabel.frame.origin.x,
                                          self.likeImageView.frame.origin.y + self.likeImageView.frame.size.height + lineSpace,
                                          viewWidth - pading * 2.0f,
                                          1.0f)];
    
    [self.avatarImageView setFrame:CGRectMake(self.foodNameLabel.frame.origin.x,
                                              self.borderView.frame.origin.y + self.borderView.frame.size.height + lineSpace,
                                              avatarImageWidth,
                                              avatarImageWidth)];
    
    //Nick Name Label Constraint
    [self.nickNameLabel setFrame:CGRectMake(self.avatarImageView.frame.origin.x + self.avatarImageView.frame.size.width + spacing * 2.0f,
                                            self.avatarImageView.frame.origin.y,
                                            self.frame.size.width - spacing*3.0f - self.avatarImageView.frame.size.width,
                                            self.nickNameLabel.frame.size.height)];
    
    //Description Label Constraint
    [self.descriptionLabel setFrame:CGRectMake(self.nickNameLabel.frame.origin.x,
                                               self.nickNameLabel.frame.origin.y + self.nickNameLabel.frame.size.height + spacing,
                                               self.frame.size.width - spacing*3.0f - self.avatarImageView.frame.size.width,
                                               self.descriptionLabel.frame.size.height)];
    
    
    //Calculate new view height
    float viewHeight = self.avatarImageView.frame.origin.y + self.avatarImageView.frame.size.height + pading;
    //Set new frame size for this view
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, viewHeight)];
}

- (void)imageTouched:(UIGestureRecognizer *)gestureRecognizer {
    if (self.dataModel != NULL)
    {
        /*
         FoodDetailViewController* viewController = [[FoodDetailViewController alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
         [viewController setFoodModel:self.dataModel];
         [[AppConfig GetMainController] presentViewController:viewController animated:false completion:nil];
         */
        
        FoodDetailViewPager* viewController = [[FoodDetailViewPager alloc] init];
        [viewController setFoodModelArray: self.foodModelArray];
        //[viewController.view setFrame:CGRectMake(0, 0, 300, 600)];
        [[AppConfig GetMainController] presentViewController:viewController animated:false completion:nil];
    }
}

@end
