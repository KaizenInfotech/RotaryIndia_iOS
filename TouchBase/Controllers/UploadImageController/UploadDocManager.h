
//
//  UploadDocManager.h
//  TouchBase
//
//  Created by Umesh on 19/02/16.
//  Copyright © 2016 Parag. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoadImageResult.h"
#import "UploadImageResult.h"
#import <UIKit/UIKit.h>
@protocol uploadDocDelegate <NSObject>

@optional
-(void)getUploadImgSucceeded:(LoadImageResult*)response;
-(void)getUploadDocSucceeded:(LoadImageResult*)response;
-(void)getDicArraySucceeded:(NSMutableArray*)response;
-(void)getDicArrayAddSingleMemberSucceeded:(NSMutableArray*)response;
-(void)getUploadProfilePicSucceeded:(UploadImageResult*)response;
@end

@interface UploadDocManager : NSObject
@property (nonatomic,weak) id<uploadDocDelegate> delegate;
@property(nonatomic,strong) NSMutableData *receivedData;
+(UploadDocManager*)getSharedInstance;
- (void)uploadToServerUsingImage:(NSData *)imageData andFileName:(NSString *)filename moduleName:(NSString*)moduleName;
-(void) createNsArrayDic:(NSArray *)NameArray andNumberArray:(NSArray *)NumberArray andGroupID:(NSString *)GroupID andMasterUID:(NSString *)MasterUID;

- (void)uploadProfilePicTOServer:(NSData *)imageData andProfileID:(NSString *)ProfileID andGroupID:(NSString*)GrpID;


- (void)uploadToServerUsingDocuments:(NSData *)imageData andFileName:(NSString *)filename moduleName:(NSString*)moduleName;

- (void)uploadToServerUsingDocumentsNew:(NSString *)imageData andFileName:(NSString *)filename moduleName:(NSString*)moduleName;



-(void) createNsArrayDicTOAddSingleMember:(NSString *)Name andNumber:(NSString *)Number andGroupID:(NSString *)GroupID andMasterUID:(NSString *)MasterUID andCountryId:(NSString *)CountryID andMemberEmail:(NSString *)MemberEmailID;


-(void)MultiplePhotoUpdateAddPhoto:(UIImage *)PhotoImage param:(NSString *)stringCaption photoID:(NSString *)photoIDdd;

-(void)MultiplePhotoSendServerInShowCase:(UIImage *)PhotoImage param:(NSString*)stringCaption;
 -(void)MultiplePhotoUpdateGalleryPhoto:(UIImage *)PhotoImage  Query:(NSString *)strquerystiring;

@end
