//
//  TBGetLinkResult.h
//  TouchBase
//
//  Created by Apple on 26/11/16.
//  Copyright © 2016 Parag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBGetLinkResult : NSObject

@property(nonatomic, strong)NSString *status;
@property(nonatomic, strong)NSString *message;
@property(nonatomic, strong)NSString *link;
@property(nonatomic, strong)NSString *discription;
@property(nonatomic, strong)NSString *lableText;




@property(nonatomic ,retain) NSArray *getLinkResult;

@end