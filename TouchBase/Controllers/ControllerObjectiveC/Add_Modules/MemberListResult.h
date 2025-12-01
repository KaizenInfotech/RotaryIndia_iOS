////
//  MemberListResult.h
//  TouchBase
//
//  Created by Kaizan on 04/02/16.
//  Copyright © 2016 Parag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MemberListResult : NSObject
@property(nonatomic, strong)NSString *masterUID;
@property(nonatomic, strong)NSString *grpID;
@property(nonatomic, strong)NSString *profileID;
@property(nonatomic, strong)NSString *groupName;
@property(nonatomic, strong)NSString *memberName;
@property(nonatomic, strong)NSString *pic;
@property(nonatomic, strong)NSString *membermobile;
@property(nonatomic, strong)NSString * grpCount;

@end
