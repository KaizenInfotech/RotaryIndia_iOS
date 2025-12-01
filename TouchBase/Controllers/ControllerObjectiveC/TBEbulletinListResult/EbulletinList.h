//
//  EbulletinList.h
//  TouchBase
//
//  Created by Umesh on 04/02/16.
//  Copyright © 2016 Parag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EbulletinList : NSObject
@property(nonatomic, strong)NSString *ebulletinID;
@property(nonatomic, strong)NSString *ebulletinlink;
@property(nonatomic, strong)NSString *ebulletinType;
@property(nonatomic, strong)NSString *ebulletinDate;
@property(nonatomic, strong)NSString *isAdmin;
@property(nonatomic, strong)NSString *ebulletinTitle;
@property(nonatomic, strong)NSString * filterType;
@property(nonatomic, strong)NSString *createDateTime;
@property(nonatomic, strong)NSString *publishDateTime;

@property(nonatomic, strong)NSString *isRead;

@end
