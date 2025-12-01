//
//  TBEntityInfoResult.h
//  TouchBase
//
//  Created by Kaizan on 08/06/16.
//  Copyright © 2016 Parag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBEntityInfoResult : NSObject

@property(nonatomic, strong)NSString *status;
@property(nonatomic, strong)NSString *message;
@property(nonatomic, strong)NSString *groupName;
@property(nonatomic, strong)NSString *groupImg;
@property(nonatomic, strong)NSString *contactNo;
@property(nonatomic, strong)NSString *address;
@property(nonatomic, strong)NSString *email;
@property(nonatomic, strong)NSArray *EntityInfoResult;
@property(nonatomic, strong)NSArray *AdminInfoResult;

@end
