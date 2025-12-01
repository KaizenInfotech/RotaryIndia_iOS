//
//  DocumentList.h
//  TouchBase
//
//  Created by Kaizan on 23/03/16.
//  Copyright © 2016 Parag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DocumentList : NSObject

@property(nonatomic, strong)NSString *docID;
@property(nonatomic, strong)NSString *docTitle;
@property(nonatomic, strong)NSString *docType;
@property(nonatomic, strong)NSString *docURL;
@property(nonatomic, strong)NSString *createDateTime;
@property(nonatomic, strong)NSString *docAccessType;
@property(nonatomic, strong)NSString *isRead;

@end
