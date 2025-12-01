//
//  TBAddModuleResult.h
//  TouchBase
//
//  Created by Kaizan on 02/02/16.
//  Copyright © 2016 Parag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBAddModuleResult : NSObject
@property(nonatomic, strong)NSString *status;
@property(nonatomic, strong)NSString *message;
@property(nonatomic, strong)NSString *grpID;
@property(nonatomic, strong)NSString *grpname;
@property(nonatomic, strong)NSString *grpImg;
@property(nonatomic, strong)NSArray *ModulesLsitResult;
@property(nonatomic, strong)NSString *trialMsg;
@end
