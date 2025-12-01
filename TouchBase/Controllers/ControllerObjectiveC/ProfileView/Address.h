//
//  Address.h
//  TouchBase
//
//  Created by Kaizan on 17/02/16.
//  Copyright © 2016 Parag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Address : NSObject

@property(nonatomic, strong)NSString *addressID;
@property(nonatomic, strong)NSString *addressType;
@property(nonatomic, strong)NSString *address;
@property(nonatomic, strong)NSString *city;
@property(nonatomic, strong)NSString *state;
@property(nonatomic, strong)NSString *country;
@property(nonatomic, strong)NSString *pincode;
@property(nonatomic, strong)NSString *phoneNo;
@property(nonatomic, strong)NSString *fax;


@end
