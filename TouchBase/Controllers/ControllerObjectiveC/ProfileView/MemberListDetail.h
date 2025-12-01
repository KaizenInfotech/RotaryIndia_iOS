//
//  MemberListDetail.h
//  TouchBase
//
//  Created by Kaizan on 04/02/16.
//  Copyright © 2016 Parag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MemberListDetail : NSObject

@property(nonatomic, strong)NSString *masterID;
@property(nonatomic, strong)NSString *grpID;
@property(nonatomic, strong)NSString *profileID;
@property(nonatomic, strong)NSString *isAdmin;
@property(nonatomic, strong)NSString *memberName;
@property(nonatomic, strong)NSString *memberEmail;
@property(nonatomic, strong)NSString *memberMobile;
@property(nonatomic, strong)NSString *memberCountry;
@property(nonatomic, strong)NSString *profilePic;

@property(nonatomic, strong)NSString *isPersonalDetVisible;
@property(nonatomic, strong)NSString *isBusinDetVisible;
@property(nonatomic, strong)NSString *isFamilDetailVisible;

@property(nonatomic, strong)NSArray  *familyMemberDetails;
@property(nonatomic, strong)NSArray  *personalMemberDetails;
@property(nonatomic, strong)NSArray  *BusinessMemberDetails;

@property(nonatomic, strong)NSArray  *addressDetails;


@end
