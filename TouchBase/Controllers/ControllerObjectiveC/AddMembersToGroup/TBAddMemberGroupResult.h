//
//  TBAddMemberGroupResult.h
//  TouchBase
//
//  Created by Kaizan on 26/02/16.
//  Copyright © 2016 Parag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBAddMemberGroupResult : NSObject

@property(nonatomic, strong)NSString *status;
@property(nonatomic, strong)NSString *message;
@property(nonatomic, strong)NSString *totalMember;
@property(nonatomic, strong)NSArray *AddMemberResult;
@end
