//
//  EventModel.h
//  AutoHeightTable
//
//  Created by AnhLTV on 7/11/16.
//  Copyright © 2016 AnhLTV. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "AttendeeModel.h"

@protocol AttendeeModel
@end

@interface EventModel : JSONModel
@property (strong,nonatomic) NSArray<AttendeeModel>* attendee;
@property (assign,nonatomic) long numberOfAttendee;
@property (strong,nonatomic) NSString* coverMobile;
@property (strong,nonatomic) NSString* createdAt;
@property (strong,nonatomic) NSString* startTime;
@property (strong,nonatomic) NSString* endTime;
@property (strong,nonatomic) NSString* mota;
@property (strong,nonatomic) NSString* title;
@end
