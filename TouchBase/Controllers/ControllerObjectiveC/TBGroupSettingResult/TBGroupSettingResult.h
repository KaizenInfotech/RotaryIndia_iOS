//
//  TBGroupSettingResult.h
//  TouchBase
//
//  Created by Umesh on 29/03/16.
//  Copyright © 2016 Parag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBGroupSettingResult : NSObject
@property(nonatomic, strong)NSString *status;
@property(nonatomic, strong)NSString *message;
@property(nonatomic, strong)NSString *isMob;
@property(nonatomic, strong)NSString *isEmail;
@property(nonatomic, strong)NSString *isPersonal;
@property(nonatomic, strong)NSString *isFamily;
@property(nonatomic, strong)NSString *isBusiness;
@property(nonatomic, strong)NSArray *GRpSettingResult;

@end
