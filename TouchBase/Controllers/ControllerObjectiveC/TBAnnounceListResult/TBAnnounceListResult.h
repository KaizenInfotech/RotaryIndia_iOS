//
//  TBAnnounceListResult.h
//  TouchBase
//
//  Created by Umesh on 04/02/16.
//  Copyright © 2016 Parag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBAnnounceListResult : NSObject
@property(nonatomic, strong)NSString *status;
@property(nonatomic, strong)NSString *message;

@property(nonatomic, strong)NSString *smscount;

@property(nonatomic,strong) NSArray  *AnnounListResult;
@end
