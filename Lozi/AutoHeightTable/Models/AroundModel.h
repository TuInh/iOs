//
//  AroundModel.h
//  Around
//
//  Created by AnhLTV on 6/29/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
@interface AroundModel : JSONModel
@property (strong,nonatomic) NSString *idAround;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *image;
@end
