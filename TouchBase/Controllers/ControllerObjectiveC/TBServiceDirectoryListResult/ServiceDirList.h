//
//  ServiceDirList.h
//  TouchBase
//
//  Created by Umesh on 21/07/16.
//  Copyright © 2016 Parag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceDirList : NSObject
@property(nonatomic, strong)NSString *serviceMemberName;
@property(nonatomic, strong)NSString *serviceDescription;
@property(nonatomic, strong)NSString *serviceImage;
@property(nonatomic, strong)NSString *serviceThumbimage;
@property(nonatomic, strong)NSString *serviceMobile1;
@property(nonatomic, strong)NSString *serviceMobile2;
@property(nonatomic, strong)NSString *servicePaxNo;
@property(nonatomic, strong)NSString *serviceEmail;
@property(nonatomic, strong)NSString *serviceKeywords;
@property(nonatomic, strong)NSString *serviceAddress;
@property(nonatomic, strong)NSString *serviceLatitude;
@property(nonatomic, strong)NSString *serviceLongitude;
@property(nonatomic, strong)NSString *serviceCountry1;
@property(nonatomic, strong)NSString *serviceCountry2;


@property(nonatomic, strong)NSString *serviceWebSite;

@end
