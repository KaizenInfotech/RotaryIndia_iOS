//
//  TBGetSubGroupListResult.h
//  TouchBase
//
//  Created by Kaizan on 09/02/16.
//  Copyright © 2016 Parag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBGetSubGroupListResult : NSObject

@property(nonatomic, strong)NSString *status;
@property(nonatomic, strong)NSString *message;
@property(nonatomic, strong)NSArray  *SubGroupResult;

@end
