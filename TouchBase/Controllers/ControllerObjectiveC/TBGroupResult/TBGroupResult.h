//
//  TBGroupResult.h
//  TouchBase
//
//  Created by Umesh on 27/01/16.
//  Copyright © 2016 Parag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBGroupResult : NSObject
@property(nonatomic, strong)NSString *status;
@property(nonatomic, strong)NSString *message;
@property(nonatomic, strong)NSString *version;
@property(nonatomic,strong) NSArray* AllGroupListResults;
@property(nonatomic,strong) NSArray* PersonalGroupListResults;
@property(nonatomic,strong) NSArray* SocialGroupListResults;
@property(nonatomic,strong) NSArray* BusinessGroupListResults;
@end
