//
//  TBCountryResult.h
//  TouchBase
//
//  Created by Kaizan on 03/02/16.
//  Copyright © 2016 Parag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBCountryResult : NSObject

@property(nonatomic, strong)NSString *status;
@property(nonatomic, strong)NSString *message;
@property(nonatomic, strong)NSArray  *CountryLists;
@property(nonatomic, strong)NSArray  *CategoryLists;

@end
