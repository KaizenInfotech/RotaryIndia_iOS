////
////  Menu.m
////  MWPhotoBrowser
////
////  Created by Michael Waterfall on 21/10/2010.
////  Copyright 2010 d3i. All rights reserved.
////

#import <Photos/Photos.h>
#import "Menu.h"
#import "SDImageCache.h"
#import "MWCommon.h"

@implementation Menu
@synthesize muarrayHoldingImageUrl,muarrayHoldingImageDescription,strSelectedPhotoIndex,muarrayHoldingPhotoId,strFromClub,strFromDistrictGallery;
int intIsLAstScreenComing=0;
#pragma mark -
#pragma mark Initialization


#pragma mark -
#pragma mark View

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
-(void)viewDidAppear:(BOOL)animated
{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = @"Loading........";
    
    
    [self.view bringSubviewToFront:label];
    
    
    label.hidden=YES;
    
    
    
//    NSString *UpdateImageOrNot = [[NSUserDefaults standardUserDefaults] stringForKey:@"Session_Update_Image"];
//    NSLog(@"%@",UpdateImageOrNot);
    
//    if([UpdateImageOrNot isEqualToString:@"UpdateImages"])
//    {
//       
//    }
//    else
//    {
//        
//    }
//    
    
    if(intIsLAstScreenComing==1)
    {
        intIsLAstScreenComing=0;
        [self.navigationController popViewControllerAnimated:YES];
        label.hidden=YES;
        
    }
    else
    {
        intIsLAstScreenComing=1;
        [self.view addSubview:label];
        label.hidden=YES;
    }
}
- (void)viewDidLoad {

    //NSLog(muarrayHoldingImageUrl) ;
    //NSLog(muarrayHoldingImageDescription) ;
    ///
    self.navigationItem.hidesBackButton = NO;
    
    self.title=@"Album";
    
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];

    /*«««««««--add dynamic uiimage--»»»»»»»»*/
    UIImageView *dot =[[UIImageView alloc] initWithFrame:CGRectMake(0,0,1000,1000)];
    dot.image=[UIImage imageNamed:@"indicatorNew.png"];
    [self.view addSubview:dot];

    NSMutableArray *photos = [[NSMutableArray alloc] init];
    //  NSMutableArray *thumbs = [[NSMutableArray alloc] init];
    MWPhoto *photo;// *thumb;
    BOOL displayActionButton = YES;
    BOOL displaySelectionButtons = NO;
    BOOL displayNavArrows = NO;
    BOOL enableGrid = YES;
    BOOL startOnGrid = NO;
    BOOL autoPlayOnAppear = NO;
    
    //NSLog(@"%@", muarrayHoldingImageUrl.count);
    
    
    for(int i=0;i<muarrayHoldingImageUrl.count;i++)
    {
        // NSURL *url = [NSURL URLWithString:muarrayHoldingImageUrl[i]];
        
        NSLog(@"%@", muarrayHoldingImageUrl[i]);
        photo = [MWPhoto photoWithURL:[NSURL URLWithString:muarrayHoldingImageUrl[i]]];
    
        photo.caption = muarrayHoldingImageDescription[i];
        [photos addObject:photo];
    }
    startOnGrid = YES;
    displayNavArrows = YES;
				
    
    self.photos = photos;
    //self.thumbs = thumbs;
    
    // Create browser
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = displayActionButton;
    browser.displayNavArrows = displayNavArrows;
    browser.displaySelectionButtons = displaySelectionButtons;
    browser.alwaysShowControls = displaySelectionButtons;
    browser.zoomPhotosToFill = YES;
    browser.enableGrid = enableGrid;
    browser.startOnGrid = startOnGrid;
    browser.enableSwipeToDismiss = NO;
    browser.autoPlayOnAppear = autoPlayOnAppear;
    
    //my code
    //browser.strFromClubs=strFromClub;
    //browser.strFromDistrictGallerys=strFromDistrictGallery;
    [browser setCurrentPhotoIndex:0];
    [browser setCurrentPhotoIndex:[strSelectedPhotoIndex intValue]];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:browser];
    nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:nc animated:YES completion:nil];

    // HomeViewController *obj = [[HomeViewController alloc] init];
    // [self.navigationController pushViewController:browser animated:YES];

}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser
{
    return _photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    if (index < _photos.count)
    {
        NSLog(@"Rajendra JAt:-----%d", index);
        NSLog(@"Rajendra _photos.count--------", _photos.count);

        [[NSUserDefaults standardUserDefaults] setObject:[muarrayHoldingImageDescription objectAtIndex:index] forKey:@"session_imageDescription"];
        [[NSUserDefaults standardUserDefaults] synchronize];

        [muarrayHoldingImageUrl objectAtIndex:index];
        [[NSUserDefaults standardUserDefaults] setObject:[muarrayHoldingImageUrl objectAtIndex:index] forKey:@"session_imageIndex"];
        [[NSUserDefaults standardUserDefaults] synchronize];

        NSLog(@"%@",[muarrayHoldingPhotoId objectAtIndex:index]);
        [[NSUserDefaults standardUserDefaults] setObject:[muarrayHoldingPhotoId objectAtIndex:index] forKey:@"session_imagePhotoId"];
        [[NSUserDefaults standardUserDefaults] synchronize];

        return [_photos objectAtIndex:index];
    }
    return nil;
}

//- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser actionButtonPressedForPhotoAtIndex:(NSUInteger)index
//{
//    NSLog(@"Enter in share button click");
//    NSArray *items1= @[[muarrayHoldingImageDescription objectAtIndex:index]];
//
//    UIActivityViewController * activityViewController =[[UIActivityViewController alloc] initWithActivityItems:items1 applicationActivities:nil];
//     activityViewController.excludedActivityTypes = @[];
//     activityViewController.popoverPresentationController.sourceView = self.view;
//
//    UIViewController *vc = self.view.window.rootViewController;
//    //UINavigationController *navigationController =[[UINavigationController alloc] initWithRootViewController:vc ];
//  //  [navigationController pushViewController:activityViewController animated:true];
//    [vc presentViewController: activityViewController animated: true completion:nil];
//
//}

@end



