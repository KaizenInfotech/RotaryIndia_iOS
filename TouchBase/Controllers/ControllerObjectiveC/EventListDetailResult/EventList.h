//
//  EventList.h
//  TouchBase
//
//  Created by Umesh on 10/02/16.
//  Copyright © 2016 Parag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventList : NSObject
@property(nonatomic, strong)NSString *eventID;
@property(nonatomic, strong)NSString *eventImg;
@property(nonatomic, strong)NSString *eventTitle;
@property(nonatomic, strong)NSString *eventDateTime;
@property(nonatomic, strong)NSString *goingCount;
@property(nonatomic, strong)NSString *maybeCount;
@property(nonatomic, strong)NSString *notgoingCount;
@property(nonatomic, strong)NSString *venue;
@property(nonatomic, strong)NSString *myResponse;
@property(nonatomic, strong)NSString *filterType;
@property(nonatomic, strong)NSString *grpID;
@property(nonatomic, strong)NSString *isRead;
@property(nonatomic, strong)NSString *venueLat;
@property(nonatomic, strong)NSString *venueLon;
@property(nonatomic, strong)NSString * grpAdminId;

@end
