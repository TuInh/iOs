//
//  EventCollectionViewCell.h
//  AutoHeightTable
//
//  Created by AnhLTV on 7/11/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventModel.h"
#import "AppConfig.h"
@interface EventCollectionViewCell : UICollectionViewCell

@property(strong, nonatomic) EventModel* dataModel;
@property(strong, nonatomic) UIImageView* coverImage;
@property(strong, nonatomic) UILabel* titleLabel;
@property(strong, nonatomic) UILabel* descriptionLabel;
@property(strong, nonatomic) UILabel* inprogressLabel;
@property(strong, nonatomic) UILabel* attendedLabel;
@property(strong, nonatomic) UIView* attendedView;

-(void) setModelData:(EventModel*) dataModel;
+(NSString*) getClassIndentifier;
@end
