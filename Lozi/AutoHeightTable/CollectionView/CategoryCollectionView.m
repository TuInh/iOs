//
//  AroundCollectionView.m
//  Around
//
//  Created by AnhLTV on 6/30/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

#import "CategoryCollectionView.h"
#import "DataLoader.h"

@implementation CategoryCollectionView


- (instancetype)initWithFrame:(CGRect)frame
{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat inset = 5.0f;
    layout.minimumInteritemSpacing = inset;
    layout.minimumLineSpacing = inset;
    layout.itemSize = CGSizeMake((self.frame.size.width-2*inset)/3, (self.frame.size.width-2*inset)/3);
    
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        
        [self registerClass:[CategoryCollectionViewCell class] forCellWithReuseIdentifier:@"CategoryCollectionViewCell"];
        self.categoryDataArray = [[NSMutableArray alloc] init];
        [self SendRequest];
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.categoryDataArray.count;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CategoryCollectionViewCell" forIndexPath:indexPath];
    CategoryModel *model =  [self.categoryDataArray objectAtIndex:indexPath.row];
    [cell setModelData: model];
    return cell;
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat inset = 5.0f;
    return CGSizeMake((self.frame.size.width-2*inset)/3, (self.frame.size.width-2*inset)/3);
    
}



-(void) SendRequest
{
    
    NSString *requestAround = [NSString stringWithFormat:@"%@%@%ld", [AppConfig GetBaseNextPageUrl], [AppConfig GetCategoryBaseURL], [AppConfig GetCityID]];
    NSURL* url = [NSURL URLWithString:requestAround];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data.length > 0 && error== nil) {
            
            NSDictionary *jsonResult = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            if (jsonResult != nil) {
                NSArray *dataObject = [jsonResult valueForKey:@"data"];
                if (dataObject != nil) {
                    
                    for (NSDictionary* aroundObj in dataObject) {
                        CategoryModel *categoryModel = [[CategoryModel alloc]initWithDictionary:aroundObj error:nil];
                        [self.categoryDataArray insertObject:categoryModel atIndex:self.categoryDataArray.count];
                        
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [self reloadData];
                        
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
                        
                        
                    });
                    
                }
                
                
                
                
                
                
            }
            
        }
    }];
    [task resume];
}

@end
