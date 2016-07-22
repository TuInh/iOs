//
//  AlbumUserCollectionViewCell.h
//  LoadSearchView
//
//  Created by AnhLTV on 7/12/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumsModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface AlbumUserTableViewCell : UITableViewCell
@property (strong,nonatomic) UILabel *lblremain;
@property (strong,nonatomic) UILabel *lblName;
@property (strong,nonatomic) UILabel *lblUser;
@property (strong,nonatomic) UILabel *lblNumberPhoto;
@property (strong,nonatomic) UIButton *btnCare;
@property (strong,nonatomic) UIView *subView;
@property (strong,nonatomic) UIView *viewBackground;
-(void) loadDataModel :(AlbumsModel*) albumsModel;
-(void) setupView;
@end
