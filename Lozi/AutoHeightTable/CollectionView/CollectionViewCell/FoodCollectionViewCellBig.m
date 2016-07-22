//
//  FoodCollectionViewCellBig.m
//  AutoHeightTable
//
//  Created by AnhLTV on 5/25/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import "FoodCollectionViewCellBig.h"

@implementation FoodCollectionViewCellBig
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
        //init for uploader
        self.shortNameLabel = [[CustomLabel alloc] init];
        [self.shortNameLabel setPlainTextCustomSize:CustomLabelSize_Normal];
        
        self.nickNameLabel = [[CustomLabel alloc] init];
        [self.nickNameLabel setBoldTextCustomSize:CustomLabelSize_Normal];
        [self.nickNameLabel setTextColor:[UIColor grayColor]];
        [self.nickNameLabel setText:@"Nick name"];
        
        
        
        float spacing = self.shortNameLabel.frame.size.height/2.0f;
        float imageWidth = self.nickNameLabel.frame.size.height + self.shortNameLabel.frame.size.height + spacing;
        self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(spacing, spacing, imageWidth, imageWidth)];
        [self.avatarImageView setBackgroundColor:[UIColor brownColor]];
        
        [self addSubview:self.avatarImageView];
        [self addSubview:self.nickNameLabel];
        [self addSubview:self.shortNameLabel];
        
        //init for title
        self.foodImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 12)];
        
        self.foodNameLabel = [[CustomLabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 12)];
        [self.foodNameLabel setBoldTextCustomSize:CustomLabelSize_Normal];
        
        self.foodAddressLabel = [[CustomLabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 12)];
        [self.foodAddressLabel setBoldTextCustomSize:CustomLabelSize_Normal];
        
        [self addSubview:self.foodImageView];
        [self addSubview:self.foodNameLabel];
        [self addSubview:self.foodAddressLabel];
        
        
        //init for item count
        self.countLabel = [[CustomLabel alloc] init];
        [self.countLabel setPlainTextCustomSize:CustomLabelSize_Normal];
        [self.countLabel setTextColor:[UIColor grayColor]];
        
        
        [self addSubview:self.countLabel];
        
        
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
    _dataModel = foodModel;
    [self refreshLayout];
}

-(void) refreshLayout
{
    float marginX = 0.0f;
    float pading = 3.0f;
    float lineSpace = self.foodNameLabel.frame.size.height / 2.0f;
    float viewWidth = self.frame.size.width;
    
    
    //set position for uploader
    [self.avatarImageView sd_setImageWithURL: [NSURL URLWithString: self.dataModel.createdBy.avatar]];
    [self.shortNameLabel setText:self.dataModel.createdBy.name.short_name];
    [self.nickNameLabel setText:[NSString stringWithFormat:@"@%@", self.dataModel.createdBy.username]];
    
    float avatarImageWidth = self.nickNameLabel.frame.size.height + self.shortNameLabel.frame.size.height + lineSpace;
    [self.avatarImageView setFrame:CGRectMake(pading,
                                              pading,
                                              avatarImageWidth,
                                              avatarImageWidth)];
    
    [self.shortNameLabel setFrame:CGRectMake(self.avatarImageView.frame.origin.x + self.avatarImageView.frame.size.width + lineSpace,
                                             self.avatarImageView.frame.origin.y,
                                             self.frame.size.width - lineSpace*3.0f - self.avatarImageView.frame.size.width,
                                             self.shortNameLabel.frame.size.height)];
    
    [self.nickNameLabel setFrame:CGRectMake(self.shortNameLabel.frame.origin.x,
                                            self.shortNameLabel.frame.origin.y + self.shortNameLabel.frame.size.height + pading,
                                            self.frame.size.width - lineSpace*3.0f - self.avatarImageView.frame.size.width,
                                            self.nickNameLabel.frame.size.height)];
    
    //set position for food iamge
    [self.foodImageView setFrame:CGRectMake(marginX,
                                            self.avatarImageView.frame.origin.y + self.avatarImageView.frame.size.height + lineSpace,
                                            viewWidth,
                                            viewWidth / self.dataModel.scale)];
    [self.foodImageView setBackgroundColor:[UIColor brownColor]];
    [self.foodImageView sd_setImageWithURL: [NSURL URLWithString: self.dataModel.image]];
    
    
    //Set position for count block
    [self.countLabel setText:[NSString stringWithFormat:@"%d lượt thích    %d lượt ghim    %d lượt comments", self.dataModel.foodCount.like, self.dataModel.foodCount.pin, self.dataModel.foodCount.comment]];
    [self.countLabel sizeToFit];
    [self.countLabel setFrame:CGRectMake(pading,
                                         self.foodImageView.frame.origin.y + self.foodImageView.frame.size.height + lineSpace,
                                         self.countLabel.frame.size.width,
                                         self.countLabel.frame.size.height)];
    
    
    [self.foodNameLabel setFrame:CGRectMake(pading,
                                            self.countLabel.frame.origin.y + self.countLabel.frame.size.height + lineSpace,
                                            viewWidth - pading * 2.0f,
                                            self.foodNameLabel.frame.size.height)];
    [self.foodNameLabel setText:self.dataModel.dish.foodName];
    
    [self.foodAddressLabel setFrame:CGRectMake(self.foodNameLabel.frame.origin.x,
                                               self.foodNameLabel.frame.origin.y + self.foodNameLabel.frame.size.height + lineSpace,
                                               viewWidth - pading * 2.0f,
                                               self.foodAddressLabel.frame.size.height)];
    [self.foodAddressLabel setText:self.dataModel.dish.eatery.address.full];
    
    
    //Calculate new view height
    float viewHeight = self.foodAddressLabel.frame.origin.y + self.foodAddressLabel.frame.size.height + pading;
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
