//
//  GroupList.h
//  TouchBase
//
//  Created by Kaizan on 01/02/16.
//  Copyright © 2016 Parag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupList : NSObject

@property(nonatomic, strong)NSString *groupModuleId;
@property(nonatomic, strong)NSString *groupId;
@property(nonatomic, strong)NSString *moduleId;
@property(nonatomic, strong)NSString *moduleName;
@property(nonatomic, strong)NSString *moduleStaticRef;
@property(nonatomic, strong)NSString *image;
@property(nonatomic, strong)NSString * masterProfileID;
@property(nonatomic, strong)NSString * isCustomized;


@property(nonatomic, strong)NSString *moduleID;
@property(nonatomic, strong)NSString *modulePriceRs;
@property(nonatomic, strong)NSString *modulePriceUS;
@property(nonatomic, strong)NSString *moduleInfo;
@end
