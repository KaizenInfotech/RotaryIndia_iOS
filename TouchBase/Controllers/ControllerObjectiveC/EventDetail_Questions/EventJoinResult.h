//
//  EventJoinResult.h
//  TouchBase
//
//  Created by Kaizan on 29/02/16.
//  Copyright © 2016 Parag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventJoinResult : NSObject

@property(nonatomic, strong)NSString *status;
@property(nonatomic, strong)NSString *message;
@property(nonatomic, strong)NSString *goingCount;
@property(nonatomic, strong)NSString *maybeCount;
@property(nonatomic, strong)NSString *notgoingCount;

@end
