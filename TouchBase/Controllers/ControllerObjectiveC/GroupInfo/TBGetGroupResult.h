//
//  TBGetGroupResult.h
//  TouchBase
//
//  Created by Kaizan on 26/02/16.
//  Copyright © 2016 Parag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBGetGroupResult : NSObject
@property(nonatomic, strong)NSString *status;
@property(nonatomic, strong)NSString *message;
@property(nonatomic, strong)NSArray *getGroupDetailResult;
@end
