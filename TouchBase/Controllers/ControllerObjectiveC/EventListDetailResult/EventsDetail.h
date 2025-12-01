//
//  EventsDetail.h
//  TouchBase
//
//  Created by Kaizan on 10/02/16.
//  Copyright © 2016 Parag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventsDetail : NSObject

@property(nonatomic, strong)NSString *eventID;
@property(nonatomic, strong)NSString *eventImg;
@property(nonatomic, strong)NSString *eventTitle;
@property(nonatomic, strong)NSString *eventDesc;
@property(nonatomic, strong)NSString *eventDateTime;
@property(nonatomic, strong)NSString *goingCount;
@property(nonatomic, strong)NSString *maybeCount;
@property(nonatomic, strong)NSString *notgoingCount;
@property(nonatomic, strong)NSString *venue;
@property(nonatomic, strong)NSString *myResponse;
@property(nonatomic, strong)NSString *filterType;
@property(nonatomic, strong)NSString *grpID;
@property(nonatomic, strong)NSString *grpAdminId;
@property(nonatomic, strong)NSString *totalCount;
@property(nonatomic, strong)NSString *venueLat;
@property(nonatomic, strong)NSString *venueLon;
@property(nonatomic, strong)NSString *isQuesEnable;
@property(nonatomic, strong)NSArray  *repeatEventResult;
@property(nonatomic, strong)NSArray  *questionArray;
@property(nonatomic, strong)NSString *eventType;
@property(nonatomic, strong)NSString *inputIds;
@property(nonatomic, strong)NSString *pubDate;
@property(nonatomic, strong)NSString *expiryDate;
@property(nonatomic, strong)NSString *eventDate;
@property(nonatomic, strong)NSString *repeatDateTime;    //
@property(nonatomic, strong)NSString *questionType;
@property(nonatomic, strong)NSString *questionText;
@property(nonatomic, strong)NSString *option1;
@property(nonatomic, strong)NSString *option2;
@property(nonatomic, strong)NSString *questionId;
@property(nonatomic, strong)NSString *sendSMSNonSmartPh;
@property(nonatomic, strong)NSString * sendSMSAll;
@property(nonatomic, strong)NSString * rsvpEnable;


@property(nonatomic, strong)NSString *displayonbanner;



@property(nonatomic,strong)NSString *isAdmin;
@property(nonatomic,strong)NSString *memberprofileid;

@property(nonatomic, strong)NSString * link;


@end
