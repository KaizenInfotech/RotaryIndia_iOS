//
//  Menu.h
//  MWPhotoBrowser
//
//  Created by Michael Waterfall on 21/10/2010.
//  Copyright 2010 d3i. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWPhotoBrowser/MWPhotoBrowser.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface Menu : UIViewController <MWPhotoBrowserDelegate> {
    UISegmentedControl *_segmentedControl;
    NSMutableArray *_selections;
}

@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) NSMutableArray *thumbs;
@property (nonatomic, strong) NSMutableArray *assets;

@property (nonatomic, strong) ALAssetsLibrary *ALAssetsLibrary;
@property NSMutableArray *muarrayHoldingImageUrl;
@property NSMutableArray *muarrayHoldingImageDescription;
@property NSMutableArray *muarrayHoldingPhotoId;

@property NSString *strSelectedPhotoIndex;
@property NSString *strFromClub;
@property NSString *strFromDistrictGallery;
- (void)loadAssets;

@end
