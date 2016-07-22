//
//  AroundCollectionView.m
//  Around
//
//  Created by AnhLTV on 6/30/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

#import "AroundCollectionView.h"
#import "DataLoader.h"

@implementation AroundCollectionView


- (instancetype)initWithFrame:(CGRect)frame
{
    self.isScrollable = false;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat inset = 5.0f;
    layout.minimumInteritemSpacing = inset;
    layout.minimumLineSpacing = inset;
    layout.itemSize = CGSizeMake((self.frame.size.width-2*inset)/3, (self.frame.size.width-2*inset)/3);
    if (self.isScrollable)
    {
        [layout setScrollDirection: UICollectionViewScrollDirectionHorizontal];
    }
    else
    {
        [layout setScrollDirection: UICollectionViewScrollDirectionVertical];
    }
    
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        
        [self registerClass:[AroundCollectionViewCell class] forCellWithReuseIdentifier:@"AroundCollectionViewCell"];
        self.aroundDataArray = [[NSMutableArray alloc] init];
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setShowsVerticalScrollIndicator: false];
        [self setShowsHorizontalScrollIndicator: false];
        [self SendRequest];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame withType: (bool) isScrollable
{
    self.isScrollable = isScrollable;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat inset = 5.0f;
    layout.minimumInteritemSpacing = inset;
    layout.minimumLineSpacing = inset;
    layout.itemSize = CGSizeMake((self.frame.size.width-2*inset)/3, (self.frame.size.width-2*inset)/3);
    if (self.isScrollable)
    {
        [layout setScrollDirection: UICollectionViewScrollDirectionHorizontal];
    }
    else
    {
        [layout setScrollDirection: UICollectionViewScrollDirectionVertical];
    }
    
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        
        [self registerClass:[AroundCollectionViewCell class] forCellWithReuseIdentifier:@"AroundCollectionViewCell"];
        self.aroundDataArray = [[NSMutableArray alloc] init];
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setShowsVerticalScrollIndicator: false];
        [self setShowsHorizontalScrollIndicator: false];
        [self SendRequest];

    }
    return self;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return _aroundDataArray.count;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AroundCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AroundCollectionViewCell" forIndexPath:indexPath];
    AroundModel *model =  [_aroundDataArray objectAtIndex:indexPath.row];
    [cell.avatar sd_setImageWithURL:[NSURL URLWithString: model.image]];
    return cell;
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat inset = 5.0f;
    return CGSizeMake((self.frame.size.width-2*inset)/3, (self.frame.size.width-2*inset)/3);
    
}



-(void) SendRequest
{
    
    NSString *requestAround = [NSString stringWithFormat:@"%@%@%ld", [AppConfig GetBaseNextPageUrl], [AppConfig GetAroundBaseURL], [AppConfig GetCityID]];
    NSURL* url = [NSURL URLWithString:requestAround];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        // NSLog(@"%@",str);
        if (data.length > 0 && error== nil) {
            
            NSDictionary *jsonResult = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            if (jsonResult != nil) {
                NSArray *dataObject = [jsonResult valueForKey:@"data"];
                if (dataObject != nil) {
                    
                    for (NSDictionary* aroundObj in dataObject) {
                        AroundModel *aroundModel = [[AroundModel alloc]initWithDictionary:aroundObj error:nil];
                        [self.aroundDataArray insertObject:aroundModel atIndex:self.aroundDataArray.count];
                        
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [self reloadData];
                        
                        if (!self.isScrollable)
                        {
                            //Update Frame Size
                            [self performBatchUpdates:^{} completion:^(BOOL finished)
                             {
                                 [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.contentSize.width, self.contentSize.height)];
                                 if (self.parentView)
                                 {
                                     self.parentView.contentSize = CGSizeMake(self.parentView.contentSize.width, self.frame.origin.y + self.frame.size.height + 100.f);
                                 }
                                 
                             }
                             ];
                        }
                        
                    });
                    
                }
                
                
                
                
                
                
            }
            
        }
    }];
    [task resume];
}

@end
