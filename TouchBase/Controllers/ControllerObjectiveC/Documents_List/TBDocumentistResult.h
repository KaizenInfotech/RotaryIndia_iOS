//
//  TBDocumentistResult.h
//  TouchBase
//
//  Created by Kaizan on 23/03/16.
//  Copyright © 2016 Parag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBDocumentistResult : NSObject

@property(nonatomic, strong)NSString *status;
@property(nonatomic, strong)NSString *message;
@property(nonatomic, strong)NSString *smscount;

@property(nonatomic, strong)NSArray *DocumentLsitResult;

@end
