//
//  LoginResult.h
//  TouchBase
//
//  Created by Umesh on 22/01/16.
//  Copyright © 2016 Parag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginResult : NSObject
@property(nonatomic, strong)NSString *status;
@property(nonatomic, strong)NSString *message;
@property(nonatomic, strong)NSString *otp;

@property(nonatomic, strong)NSString *isexists;
@property(nonatomic, strong)NSString *masterUID;
@property(nonatomic, strong)NSString *isMemeberNotRegistered;

@end
