//
//  albumListDisplay.h
//  TouchBase
//
//  Created by Umesh on 21/09/16.
//  Copyright © 2016 Parag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBAlbumsListResult : NSObject

@property(nonatomic, strong)NSString *status;
@property(nonatomic, strong)NSString *message;
@property(nonatomic, strong)NSString *updatedOn;

@property(nonatomic ,retain) NSString *Result;


//@property (nonatomic, strong) NSString *deletedAlbums;
//@property (getter=thenewAlbums) NSArray *newAlbums;
//@property (nonatomic, strong) NSArray *updatedAlbums;



//@property(nonatomic ,retain) NSDictionary *Result;
//@property(nonatomic ,strong) NSString *deletedAlbums;




@end
