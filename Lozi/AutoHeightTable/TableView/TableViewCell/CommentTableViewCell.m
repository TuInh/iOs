


//
//  CommentTableViewCell.m
//  LoadSearchView
//
//  Created by AnhLTV on 6/4/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

#import "CommentTableViewCell.h"

@implementation CommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}
-(void) setupView
{
    _avatar = [[UIImageView alloc]init];
    [self addSubview:_avatar];
    
    // set label name
    _name = [[UILabel alloc]init];
    [self addSubview:_name];
    
    // add Label short name
    _nick=  [[UILabel alloc] init];
    [self addSubview:_nick];
    
    //add content comment
    _content = [[UILabel alloc]init];
    [self addSubview:_content];
    
    // add rate comment
    _rate = [[UILabel alloc]init];
    [self addSubview:_rate];
}
-(void) loadDataModel:(CommentModel *)commentModel
{
    self.commentModel = commentModel;
    CGSize size = [UIScreen mainScreen].bounds.size;
    CGFloat w = size.width;
    CGFloat h = size.height;
    //set avatar for user comment
    float a  = h/18;
    
    [_avatar setFrame:CGRectMake(a/3, a/3, a, a)];
    _avatar.layer.cornerRadius = a/2.0f;
    _avatar.layer.masksToBounds = YES;
    [_avatar sd_setImageWithURL: [NSURL URLWithString:_commentModel.avatar]];
    
    
    
    // set label name
    [_name setFrame: CGRectMake(_avatar.frame.origin.x+5+_avatar.frame.size.width, a/3, w, 1)];
    [_name setText: _commentModel.username ];
    [_name setTextColor : [UIColor blackColor]];
    [_name setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleCaption1]];
    [_name setFont: [UIFont boldSystemFontOfSize:_name.font.pointSize]];
     [_name sizeToFit];
    //[_name setFrame:CGRectMake(_name.frame.origin.x, _name.frame.origin.y, _name.frame.size.width, _name.frame.size.height)];
    //_name.textAlignment = NSTextAlignmentCenter;

    
    
    // add Label short name
    [_nick setFrame: CGRectMake(_name.frame.origin.x+_name.frame.size.width +3, _name.frame.origin.y, w, 1)];
    [_nick setText: _commentModel.shortname];
    [_nick setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleCaption2]];
    [_nick sizeToFit];
    
    // add content comment
    [_content setFrame: CGRectMake(_name.frame.origin.x, _name.frame.origin.y+ _name.frame.size.height + 5, w*2/3, 1)];
    [_content setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [_content setNumberOfLines:0];
    [_content setLineBreakMode:NSLineBreakByWordWrapping];
    [_content setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleCaption1]];
    [_content setText: _commentModel.content];
    [_content setTextColor:[UIColor blackColor]];
    //[_content setTextAlignment:NSTextAlignmentLeft];
    [_content sizeToFit];
    
    
    //CGSize sizeOfContent = [_content sizeThatFits:CGSizeMake(_content.frame.size.width, CGFLOAT_MAX)];
    //[_content setFrame:CGRectMake(_content.frame.origin.x, _content.frame.origin.y, _content.frame.size.width, sizeOfContent.height)];
    
    // add rate comment
    [_rate setFrame:CGRectMake(self.frame.size.width - a, _name.frame.origin.y, a, a/1.2)];
    [_rate setBackgroundColor:[UIColor greenColor]];
    _rate.layer.cornerRadius = 2.0f;
    _rate.layer.masksToBounds = YES;
    
    
   _rate.text = [NSString stringWithFormat:@"%.1f", _commentModel.rating];
    _rate.textColor = [UIColor whiteColor];
    _rate.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption2];
    _rate.textAlignment = NSTextAlignmentCenter;
    _rate.font = [UIFont boldSystemFontOfSize:_rate.font.pointSize];
    [_rate sizeToFit];
    [_rate setFrame:CGRectMake(_rate.frame.origin.x, _rate.frame.origin.y, _rate.frame.size.width*1.3, _rate.frame.size.height*1.2)];
    self.expectedViewHeight = _content.frame.origin.y + _content.frame.size.height + 5.0f;
    
    //self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.expectedViewHeight);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
