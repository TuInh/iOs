//
//  AlbumUserCollectionViewCell.m
//  LoadSearchView
//
//  Created by AnhLTV on 7/12/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

#import "AlbumUserTableViewCell.h"

@implementation AlbumUserTableViewCell
int stateCare = 1;
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
-(void) loadDataModel :(AlbumsModel*) albumsModel
{
    CGFloat w = self.frame.size.width;
    CGFloat h = [[UIScreen mainScreen] bounds].size.height/5;
    stateCare = 1;
    
    self.backgroundColor = [UIColor colorWithRed:228.0f/255.0f green:228.0f/255.0f blue:228.0f/255.0f alpha:1];
    
    CGFloat distance = 5;
    CGFloat margin = 10;
    
    [_viewBackground setFrame:CGRectMake(0, 0, w, h)];
    _viewBackground.backgroundColor = [UIColor whiteColor];
    _viewBackground.clipsToBounds = YES;
    _viewBackground.layer.cornerRadius = 10;
    
    CGFloat heightOfImage = (w - 3 *distance - 2*margin)/4;
    NSUInteger countThumbnails = albumsModel.thumbnails.count;
    NSUInteger  block = albumsModel.block.integerValue;
    if (countThumbnails > 4) {
        countThumbnails = 4;
    }
    if (countThumbnails < 4)
    {
        for(NSUInteger i = countThumbnails;i<4;i++)
        {
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(margin + heightOfImage*i+ i*distance, margin, heightOfImage, heightOfImage)];
            img.layer.cornerRadius = 5.0f;
            img.backgroundColor = [UIColor colorWithRed:228.0f/255.0f green:228.0f/255.0f blue:228.0f/255.0f alpha:1];
            img.contentMode = UIViewContentModeScaleToFill;
            img.clipsToBounds = YES;
            [_viewBackground addSubview:img];
            
        }
        
    
    }
    
    
    for(int i=0;i<countThumbnails;i++)
    {
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(margin + heightOfImage*i+ i*distance, margin, heightOfImage, heightOfImage)];
        img.layer.cornerRadius = 5.0f;
        img.contentMode = UIViewContentModeScaleToFill;
        img.clipsToBounds = YES;
        [img sd_setImageWithURL: [NSURL URLWithString:[albumsModel.thumbnails objectAtIndex:i]]];
        [_viewBackground addSubview:img];
        if (i==(countThumbnails-1)) {
            if (block>4) {
                block = block - 4;
                img.alpha = 0.6;
                [_lblremain setFrame:CGRectMake(heightOfImage/3, heightOfImage/3, heightOfImage, 1)];
                _lblremain.text = [NSString stringWithFormat:@"+%lu",(unsigned long)block];
                [_lblremain setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]];
                [_lblremain setTextColor:[UIColor whiteColor]];
                [_lblremain setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
                [_lblremain setLineBreakMode:NSLineBreakByCharWrapping];
                [_lblremain setNumberOfLines:0];
                [_lblremain sizeToFit];
                [_lblremain setFrame:CGRectMake((heightOfImage-_lblremain.frame.size.width)/2, _lblremain.frame.origin.y, _lblremain.frame.size.width, _lblremain.frame.size.height)];
                [img addSubview:_lblremain];
            }
            
            
        }
        
    }
    [_lblName setFrame:CGRectMake(margin , distance + margin+ heightOfImage, w*3/4-2.5*margin,(h - distance-margin-heightOfImage)*3/5
                                                                 )];
    _lblName.text = albumsModel.name;
    [_lblName setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleCaption1]];
    [_lblName setTextColor:[UIColor blackColor]];
    [_lblName setLineBreakMode:NSLineBreakByTruncatingTail];
    [_lblName setNumberOfLines:1];
    _lblName.adjustsFontSizeToFitWidth = NO;
    _lblName.textAlignment = NSTextAlignmentLeft;
     [_lblName setFont:[UIFont boldSystemFontOfSize:_lblName.font.pointSize]];
    
    
   [ _lblUser setFrame: CGRectMake(_lblName.frame.origin.x, _lblName.frame.origin.y+_lblName.frame.size.height, w
                                                                 , 1)];
    [_lblUser setText:[NSString stringWithFormat:@"%@ .",albumsModel.username] ];
    [_lblUser setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleCaption2]];
    [_lblUser setTextColor:[UIColor colorWithRed:41.0f/255.0f green:91.0f/255.0f blue:132.0f/255.0f alpha:1]];
    [_lblUser setLineBreakMode:NSLineBreakByTruncatingTail];
    [_lblUser setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [_lblUser setNumberOfLines:0];
    _lblUser.adjustsFontSizeToFitWidth = NO;
    _lblUser.textAlignment = NSTextAlignmentLeft;
     [_lblUser setFont:[UIFont boldSystemFontOfSize:_lblUser.font.pointSize]];
    [_lblUser sizeToFit];
    
    
    
    [_lblNumberPhoto setFrame:CGRectMake(_lblUser.frame.origin.x+_lblUser.frame.size.width, _lblUser.frame.origin.y, w
                                                                        , 1)];
    [_lblNumberPhoto setText:[NSString stringWithFormat:@"%@ ảnh",albumsModel.block]];
    [_lblNumberPhoto setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleCaption2]];
    [_lblNumberPhoto setTextColor:[UIColor colorWithRed:175.0f/255.0f green:180.0f/255.0f blue:182.0f/255.0f alpha:1]];
    [_lblNumberPhoto setLineBreakMode:NSLineBreakByTruncatingTail];
    [_lblNumberPhoto setNumberOfLines:0];
    _lblNumberPhoto.adjustsFontSizeToFitWidth = NO;
    [_lblNumberPhoto setFont:[UIFont boldSystemFontOfSize:_lblNumberPhoto.font.pointSize]];
    _lblNumberPhoto.textAlignment = NSTextAlignmentLeft;
    [_lblNumberPhoto setAutoresizingMask:UIViewAutoresizingFlexibleHeight];

    [_lblNumberPhoto sizeToFit];
   
    
    [_btnCare setFrame:CGRectMake(w*3/4- 1.5*margin, _lblName.frame.origin.y, _lblName.frame.size.width, _lblName.frame.size.height)];
    [_btnCare setTitle:@"Quan tâm" forState:UIControlStateNormal];
    [_btnCare setTitleColor:[UIColor colorWithRed:41.0f/255.0f green:91.0f/255.0f blue:132.0f/255.0f alpha:1] forState:UIControlStateNormal];
    [_btnCare.titleLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleCaption1]];
    [_btnCare sizeToFit];
    _btnCare.layer.borderColor =[UIColor colorWithRed:41.0f/255.0f green:91.0f/255.0f blue:132.0f/255.0f alpha:1].CGColor;
    _btnCare.layer.borderWidth = 2;
    [_btnCare setNeedsDisplay];
    [_btnCare layoutIfNeeded];
    _btnCare.layer.cornerRadius = 5;
    [_btnCare setFrame:CGRectMake(_btnCare.frame.origin.x, _btnCare.frame.origin.y, _btnCare.frame.size.width+10, _btnCare.frame.size.height)];
    [_btnCare addTarget:self action:@selector(careUser:) forControlEvents:UIControlEventTouchUpInside];
    
    //Resize all view
    [self setFrame: CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _lblUser.frame.origin.y + _lblUser.frame.size.height +5)];
    _viewBackground.frame = self.bounds;

    _subView = [[UIView alloc]initWithFrame:CGRectMake(_viewBackground.frame.origin.x, _viewBackground.frame.size.height, _viewBackground.frame.size.width, 5)];
    _subView.backgroundColor = [UIColor colorWithRed:228.0f/255.0f green:228.0f/255.0f blue:228.0f/255.0f alpha:1];
    
    
    
       [self addSubview:_subView];
   
}
- (IBAction)careUser:(UIButton *)careBtn
{
    if (stateCare == 1) {
        stateCare = 2;
        [careBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal ] ;
        _btnCare.layer.borderColor =[UIColor greenColor].CGColor;
        [careBtn setTitle:@"Đã quan tâm" forState:UIControlStateNormal];
        [careBtn sizeToFit];
        [careBtn setFrame:CGRectMake(careBtn.frame.origin.x, careBtn.frame.origin.y, careBtn.frame.size.width*1.2, careBtn.frame.size.height)];
        return;
        
        
    }
    
    if (stateCare == 2) {
        stateCare = 1;
        _btnCare.layer.borderColor =[UIColor colorWithRed:41.0f/255.0f green:91.0f/255.0f blue:132.0f/255.0f alpha:1].CGColor;
        [careBtn setTitleColor:[UIColor colorWithRed:41.0f/255.0f green:91.0f/255.0f blue:132.0f/255.0f alpha:1] forState:UIControlStateNormal ] ;
        [careBtn setTitle:@"Quan tâm" forState:UIControlStateNormal];
        [careBtn sizeToFit];
        [careBtn setFrame:CGRectMake(careBtn.frame.origin.x, careBtn.frame.origin.y, careBtn.frame.size.width*1.2, careBtn.frame.size.height)];
        return;
        
    }
    
}

-(void) setupView {
    _viewBackground = [[UIView alloc]init];
    [self addSubview:_viewBackground];
    
    _lblremain = [[UILabel alloc]init];
   
    
    _lblName = [[UILabel alloc]init];
    [_viewBackground addSubview:_lblName];
    
    _lblUser = [[UILabel alloc]init];
    [_viewBackground addSubview:_lblUser];
    
    _lblNumberPhoto = [[UILabel alloc]init];
    [_viewBackground addSubview:_lblNumberPhoto];
    
    _btnCare = [[UIButton alloc]init];
    [_viewBackground addSubview:_btnCare];
    
}

@end
