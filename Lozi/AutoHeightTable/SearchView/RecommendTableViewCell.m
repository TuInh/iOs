//
//  RecommendTableViewCell.m
//  LoadSearchView
//
//  Created by AnhLTV on 6/24/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

#import "RecommendTableViewCell.h"

@implementation RecommendTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}
-(void) loadDataModel :(RecommendModel*) recommendModel
{
    CGFloat w = [[UIScreen mainScreen] bounds].size.width;
    CGFloat h = [[UIScreen mainScreen] bounds].size.height/5;
    self.layer.cornerRadius = 10.0f;
    self.backgroundColor = [UIColor colorWithRed:228.0f/255.0f green:228.0f/255.0f blue:228.0f/255.0f alpha:1];
    
    // add image Background
    [_imgBackground setFrame:CGRectMake(0, 0, w, h)];
     [_imgBackground sd_setImageWithURL: [NSURL URLWithString:recommendModel.avatar]];
    _imgBackground.contentMode = UIViewContentModeScaleAspectFill;
    _imgBackground.clipsToBounds = YES;
    _imgBackground.layer.cornerRadius = 10;
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    
    UIVibrancyEffect *vibrantEffect= [UIVibrancyEffect effectForBlurEffect:blurEffect];
    UIVisualEffectView *vibrantEffectView = [[UIVisualEffectView alloc] initWithEffect:vibrantEffect];
    [_imgBackground addSubview:blurEffectView];
    //[_imgBackground addSubview:vibrantEffectView];
    //_imgBackground.alpha = 0.7;
    // add image avatar of shop
    CGFloat a = h/3;
    [_imgAvatar setFrame:CGRectMake(a/7, a/7, 5*a/7, 5*a/7)];
    _imgAvatar.layer.cornerRadius = _imgAvatar.frame.size.width/2;
    _imgAvatar.layer.borderColor = [UIColor whiteColor].CGColor;
  //  _imgAvatar.layer.borderWidth = 2;
    [self addSubview:_imgAvatar];
    
    SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
    NSURL *imageURL = [NSURL URLWithString: recommendModel.avatar];
    [downloader downloadImageWithURL:imageURL
                             options:0
                            progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                // progression tracking code
                            }
                           completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                               if (image && finished) {
                                   // do something with imag
                                
                                   UIImage *imgDownload =[self roundedImage:image size:CGSizeMake(_imgAvatar.frame.size.width, _imgAvatar.frame.size.width) corlorBorder:[UIColor whiteColor]];
                                   _imgAvatar.image = imgDownload;
                                   
                               }
                           }];
    

    

    // add name of shop
    [_lblName setFrame:CGRectMake(_imgAvatar.frame.size.width+_imgAvatar.frame.origin.x+5, _imgAvatar.frame.origin.y, w-_imgAvatar.frame.size.width-_imgAvatar.frame.origin.x -10.0 * 2.0f, _imgAvatar.frame.size.height/2)];
    [_lblName setTextColor:[UIColor whiteColor]];
    [_lblName setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleCaption1]];
    _lblName.font = [UIFont boldSystemFontOfSize:_lblName.font.pointSize];
    _lblName.text = recommendModel.name;
    
    
    // add label address
    [_lblAddress setFrame:CGRectMake(_lblName.frame.origin.x, _lblName.frame.origin.y + _lblName.frame.size.height + 5, _lblName.frame.size.width, _lblName.frame.size.height)];
    [_lblAddress setTextColor:[UIColor whiteColor]];
    [_lblAddress setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleCaption2]];
    _lblAddress.text = recommendModel.fullAddress;
    [_lblName sizeToFit];
    [_lblAddress sizeToFit];
    
    //lblRating
    [_lblRating setFrame:CGRectMake(_lblName.frame.origin.x,a, a/2, a/2.2)];
    [_lblRating setBackgroundColor:[UIColor greenColor]];
    _lblRating.layer.cornerRadius = 3.0f;
    _lblRating.layer.masksToBounds = YES;
    [_lblRating setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleCaption1]];
    [_lblRating setTextColor:[UIColor whiteColor]];
    [_lblRating setTextAlignment:NSTextAlignmentCenter];
    _lblRating.font = [UIFont boldSystemFontOfSize:_lblRating.font.pointSize];
    _lblRating.text = [NSString stringWithFormat:@"%.1f", recommendModel.rating];;
    [_lblRating sizeToFit];
    [_lblRating setFrame:CGRectMake(_lblRating.frame.origin.x, _lblRating.frame.origin.y, _lblRating.frame.size.width*1.2, _lblRating.frame.size.height*1.2)];
    
    
    // Add Label Cost
    [_lblCost setFrame:CGRectMake(_lblRating.frame.origin.x+_lblRating.frame.size.width+15, _lblRating.frame.origin.y, w-_imgAvatar.frame.size.width-_imgAvatar.frame.origin.x -5, _imgAvatar.frame.size.height/2)];
    [_lblCost setTextAlignment:NSTextAlignmentCenter];
    [_lblCost setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleCaption2]];
    _lblCost.text = [recommendModel.priceCouple stringByAppendingString:@"đ /hai người"];
    [_lblCost sizeToFit];
    _lblCost.textColor = [UIColor whiteColor];
    
    
    
    //Add Label Time
    [_lblTime setFrame:CGRectMake(_lblCost.frame.origin.x, _lblCost.frame.origin.y+_lblCost.frame.size.height+5, w-_lblCost.frame.origin.x-5, _imgAvatar.frame.size.height/2)];
    [_lblTime setTextAlignment:NSTextAlignmentCenter];
    [_lblTime setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleCaption2]];
    if (recommendModel.operatingTime.count >0) {
        NSDictionary *time = recommendModel.operatingTime[0];
        NSString *timeStart = [[time valueForKey:@"start"] stringByAppendingString: @" - "];
        [_lblTime setText:[timeStart stringByAppendingString:[time valueForKey:@"finish"]]];
    }
    else
    {
      
        [_lblTime setText:@"0:00AM - 0:00AM"];
    }
    
    [_lblTime sizeToFit];
    _lblTime.textColor = [UIColor whiteColor];
    
    
    
    // lblDistane
    //[_lblDistance setFrame: CGRectMake(0, _lblCost.frame.origin.x, 12, 12)];
    //[_lblDistance setText: recommendModel.]
    
    //Resize all view
    [self setFrame: CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _lblTime.frame.origin.y + _lblTime.frame.size.height +15)];
    
    //Resize blur view and backgroup image view
    blurEffectView.frame = _imgBackground.bounds;
    vibrantEffectView.frame = _imgBackground.bounds;
    _imgBackground.frame = self.bounds;

    _subView = [[UIView alloc]initWithFrame:CGRectMake(_imgBackground.frame.origin.x, _imgBackground.frame.size.height, _imgBackground.frame.size.width, 5)];
    _subView.backgroundColor = [UIColor colorWithRed:228.0f/255.0f green:228.0f/255.0f blue:228.0f/255.0f alpha:1];

    [self addSubview:_subView];
    
}
-(void) setupView
{
    _imgBackground = [[UIImageView alloc] init];
    [self addSubview:_imgBackground];
     _imgAvatar = [[UIImageView alloc] init];
    
    
    // add name of shop
    _lblName = [[UILabel alloc]init];
    [self addSubview:_lblName];
    
    // add label address
    _lblAddress = [[UILabel alloc]init];
    [self addSubview:_lblAddress];
    
    //lblRating
    _lblRating = [[UILabel alloc]init];
    [self addSubview:_lblRating];
    
    
    // Add Label Cost
    _lblCost = [[UILabel alloc]init];
    [self addSubview:_lblCost];
    
    //Add Label Time
    _lblTime = [[UILabel alloc]init];
    [self addSubview:_lblTime];
    
    self.backgroundColor = [UIColor colorWithRed:228.0f/255.0f green:228.0f/255.0f blue:228.0f/255.0f alpha:1];
    // lblDistane
    
    
    
    
}
-(UIImage *)roundedImage:(UIImage *)image size:(CGSize)imageSize corlorBorder:(UIColor*) borderColor
{
    // create circle image with white border
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, image.scale);
    CGRect bounds = (CGRect){.origin = CGPointZero,.size = imageSize};
    [borderColor setFill];
    [[UIBezierPath bezierPathWithOvalInRect:bounds] fill];
    CGRect interiorBox = CGRectInset(bounds, 2.0f, 2.0f);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:interiorBox];
    [path addClip];
    [image drawInRect:bounds];
    UIImage *circleImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return circleImage;
}

@end
