//
//  TBMemberResult.h
//  TouchBase
//
//  Created by Kaizan on 04/02/16.
//  Copyright © 2016 Parag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBMemberResult : NSObject
@property(nonatomic, strong)NSString *status;
@property(nonatomic, strong)NSString *message;
@property(nonatomic, strong)NSString *resultCount;
@property(nonatomic, strong)NSString *TotalPages;
@property(nonatomic, strong)NSString *currentPage;
@property(nonatomic, strong) NSArray *MemberListResults;
@end
