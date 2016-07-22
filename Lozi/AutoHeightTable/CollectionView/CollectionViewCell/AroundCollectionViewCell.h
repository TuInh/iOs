//
//  CollectionViewCell.h
//  Around
//
//  Created by AnhLTV on 6/29/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AroundCollectionViewCell : UICollectionViewCell
@property (strong,nonatomic) UIImageView *avatar;
@property(strong,nonatomic) UILabel *type;
-(void)setupView;
@end
