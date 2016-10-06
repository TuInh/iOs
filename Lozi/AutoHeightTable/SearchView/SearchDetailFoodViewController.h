//
//  SearchDetailFoodViewController.h
//  LoadSearchView
//
//  Created by AnhLTV on 6/2/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//
#import <Foundation/Foundation.h>


#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "AnnotationMap.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CustomViewSearch.h"
#import "FoodLocationModel.h"
#import "CommentModel.h"
#import "MyTableView.h"
#import "AppConfig.h"
#import "RecommendModel.h"
#import "MenuFoodLocationViewController.h"
@interface SearchDetailFoodViewController : UIViewController<MKMapViewDelegate>
@property (strong,nonatomic) MKMapView *map;
@property (strong,nonatomic) UIImage *imgBackground;
@property (strong,nonatomic) UIView *viewBack;
@property(strong,nonatomic) UIView *viewAvatar;
@property (strong,nonatomic) UIScrollView *scrollView;
@property (strong,nonatomic) FoodLocationModel *foodLocationModel;
@property (strong,nonatomic) NSString *slug;
@property(strong,nonatomic) NSMutableArray *commentArray;
@property (strong,nonatomic) UIView *viewImage;
@property(strong,nonatomic) UIView *viewMenu;
@property(strong,nonatomic) UIView *viewMap;
@property(nonatomic, strong) NSMutableArray* sectionCommentArray;
@property(nonatomic, strong) NSMutableArray* sectionRecommentArray;
@property(nonatomic,strong) NSMutableArray *recommendArray;
@property(nonatomic,strong) MyTableView *tableComment;
@property(nonatomic,strong) MyTableView *tableRecommend;
@property (strong, nonatomic) NSString* nextURl;
@property (strong, nonatomic) NSString* currentURl;

-(void) GotoNextPage;
-(UIImage*) resizeImage:(UIImage*)imageOrigin newSize:(CGSize) size;
-(UIImage *)roundedImageFromImage:(UIImage*)image size:(CGSize)imageSize withCornerRadius:(float) cornerRadius;
-(UIImage *)createAnotationImage:(UIImage*)image size:(CGSize)imageSize withCornerRadius:(float) cornerRadius;
@end
