//
//  EventListDetailResult.h
//  TouchBase
//
//  Created by Umesh on 10/02/16.
//  Copyright © 2016 Parag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventListDetailResult : NSObject
@property(nonatomic, strong)NSString *status;
@property(nonatomic, strong)NSString *message;

@property(nonatomic, strong)NSString *SMSCount;
@property(nonatomic, strong)NSString *resultCount;
@property(nonatomic, strong)NSString *TotalPages;
@property(nonatomic, strong)NSString *currentPage;

@property(nonatomic, strong) NSArray *EventsListResult;
@property(nonatomic, strong)NSString * link;
@end
