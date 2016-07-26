//
//  FoodCollectionViewCell.m
//  AutoHeightTable
//
//  Created by AnhLTV on 7/5/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import "FoodCollectionViewCell.h"

@implementation FoodCollectionViewCell
-(void) loadDataModel:(FoodModel*) foodModel
{
    
}

-(UIColor*) randomColor
{
    NSArray* colorArray = [NSArray arrayWithObjects: [UIColor brownColor], [UIColor blueColor], [UIColor greenColor], [UIColor purpleColor], [UIColor magentaColor], [UIColor orangeColor], nil];
    
    return [colorArray objectAtIndex:arc4random() % colorArray.count];
}
@end
