//
//  AnnounceList.h
//  TouchBase
//
//  Created by Umesh on 04/02/16.
//  Copyright © 2016 Parag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnnounceList : NSObject
@property(nonatomic, strong)NSString *announID;
@property(nonatomic, strong)NSString *announTitle;
@property(nonatomic, strong)NSString *announceDEsc;
@property(nonatomic, strong)NSString *createDateTime;
@property(nonatomic, strong)NSString *isAdmin;
@property(nonatomic, strong)NSString *publishDateTime;
@property(nonatomic, strong)NSString * expiryDateTime;
@property(nonatomic, strong)NSString * isRead;
@property(nonatomic, strong)NSString * filterType;
@property(nonatomic, strong)NSString * announImg;
@property(nonatomic, strong)NSString * profileIds;
@property(nonatomic, strong)NSString * type;
@property(nonatomic, strong)NSString * createDate;
@property(nonatomic, strong)NSString * publishDate;
@property(nonatomic, strong)NSString * expiryDate;
@property(nonatomic, strong)NSString *sendSMSNonSmartPh;
@property(nonatomic, strong)NSString * sendSMSAll;

@property(nonatomic, strong)NSString * link;
@end
