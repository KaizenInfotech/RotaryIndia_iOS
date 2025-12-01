//
//  TBGlobalSearchGroupResult.h
//  TouchBase
//
//  Created by Kaizan on 18/02/16.
//  Copyright © 2016 Parag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBGlobalSearchGroupResult : NSObject

@property(nonatomic, strong)NSString *status;
@property(nonatomic, strong)NSString *message;
@property(nonatomic, strong)NSString *membername;
@property(nonatomic, strong)NSString *membermobile;
@property(nonatomic, strong)NSString *profilepicpath;
@property(nonatomic, strong)NSArray  *AllGlobalGroupListResults;

@end
