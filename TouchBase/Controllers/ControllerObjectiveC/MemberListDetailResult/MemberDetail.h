//
//  MemberDetail.h
//  TouchBase
//
//  Created by Kaizan on 29/01/16.
//  Copyright © 2016 Parag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MemberDetail : NSObject
@property(nonatomic, strong)NSString *masterUID;
@property(nonatomic, strong)NSString *memberName;
@property(nonatomic, strong)NSString *profilePicPath;
@property(nonatomic, strong)NSString *memberEmailId;
@property(nonatomic, strong)NSString *mobileNo;
@property(nonatomic, strong)NSString *deviceToken;
@property(nonatomic, strong)NSString *countryCode;

@end
