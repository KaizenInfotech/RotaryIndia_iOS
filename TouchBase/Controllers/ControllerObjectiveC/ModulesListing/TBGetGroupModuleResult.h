//
//  TBGetGroupModuleResult.h
//  TouchBase
//
//  Created by Kaizan on 01/02/16.
//  Copyright © 2016 Parag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBGetGroupModuleResult : NSObject
@property(nonatomic, strong)NSString *status;
@property(nonatomic, strong)NSString *message;
@property(nonatomic,strong) NSArray  *GroupListResult;
@end
