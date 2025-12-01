//
//  TBServiceDirectoryResult.h
//  TouchBase
//
//  Created by Umesh on 20/07/16.
//  Copyright © 2016 Parag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBServiceDirectoryResult : NSObject
@property(nonatomic, strong)NSString *status;
@property(nonatomic, strong)NSString *message;
@property(nonatomic, strong)NSString *Date;

@property(nonatomic, strong)NSArray *ServiceDirectoryResult;
@end
