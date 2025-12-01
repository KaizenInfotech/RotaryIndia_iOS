//
//  TBServiceDirectoryListResult.h
//  TouchBase
//
//  Created by Umesh on 21/07/16.
//  Copyright © 2016 Parag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBServiceDirectoryListResult : NSObject
@property(nonatomic, strong)NSString *status;
@property(nonatomic, strong)NSString *message;


@property(nonatomic, strong)NSArray *ServiceDirListResult;
@end
