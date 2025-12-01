//
//  TBGetSubGroupDetailListResult.h
//  TouchBase
//
//  Created by Umesh on 11/02/16.
//  Copyright © 2016 Parag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBGetSubGroupDetailListResult : NSObject
@property(nonatomic, strong)NSString *status;
@property(nonatomic, strong)NSString *message;
@property(nonatomic, strong)NSArray  *SubGroupResult;
@end
