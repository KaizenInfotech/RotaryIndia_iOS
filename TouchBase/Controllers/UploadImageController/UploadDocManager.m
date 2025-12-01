
//
//  UploadDocManager.m
//  TouchBase
//
//  Created by Umesh on 19/02/16.
//  Copyright © 2016 Parag. All rights reserved.
//

#import "UploadDocManager.h"
#import "NSObject+JSONSerializableSupport.h"
#import "constants.h"

#import "UIView+Toast.h"

@implementation UploadDocManager
+(UploadDocManager*)getSharedInstance{
    static UploadDocManager *instance;
    if (!instance) {
        instance = [[self alloc] init];
    }
    return instance;
}





-(void)MultiplePhotoSendServerInShowCase:(UIImage *)PhotoImage param:(NSString *)stringCaption
{
    
    
    //NSUserDefaults.standardUserDefaults().setValue("Success5", forKey: "LastImageUpdateConfirmationYesOrNo")
    
    NSString *LastImageUpdate = [[NSUserDefaults standardUserDefaults] stringForKey:@"LastImageUpdateConfirmationYesOrNo"];
  
    NSString *groupID = [[NSUserDefaults standardUserDefaults] stringForKey:@"session_GetGroupId"];
    NSString *AlbumID = [[NSUserDefaults standardUserDefaults] stringForKey:@"session_AlbumID"];
    NSString *createdByUserIDProfileID = [[NSUserDefaults standardUserDefaults] stringForKey:@"session_createdByORUserIdOrProfileId"];
    NSString *descr = stringCaption;
    NSString *strDescr = [descr stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSLog(@"description++++++++++++++",strDescr);
    NSLog(@"%@",stringCaption);
    
    
    
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    int maxFileSize = 250*1024;
    NSData *imageData = UIImageJPEGRepresentation(PhotoImage, compression);
    while ([imageData length] > maxFileSize && compression > maxCompression)
    {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(PhotoImage, compression);
    }
    
    
    
    NSData *dataImage = imageData;
    NSString *urlStrings = [NSString stringWithFormat:@"%@Gallery/AddUpdateAlbumPhoto?",baseUrl];
    NSString *urlString = [NSString stringWithFormat:@"%@photoId=0&desc=%@&albumId=%@&groupId=%@&createdBy=%@",urlStrings,strDescr,AlbumID,groupID, createdByUserIDProfileID];
    
    // set your Image Name
    NSString *filename = @"YourImageFileName";
    // Create 'POST' MutableRequest with Data and Other Image Attachment.
    NSMutableURLRequest* request= [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    NSMutableData *postbody = [NSMutableData data];
    [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"%@.jpg\"\r\n", filename] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[NSData dataWithData:dataImage]];
    [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:postbody];
    
    //NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",returnString);
    
    [[NSUserDefaults standardUserDefaults]setValue:@"Yes" forKey:@"session_IsComingFromImageSave"];
    if ([returnData length] > 0)
    {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:returnData  options:kNilOptions error:&error];
        //[self.view makeToast:@"Photo added successfully" duration:3 position:CSToastPositionCenter];
        NSArray* latestLoans = [json objectForKey:@"LoadImageResult"];
        NSLog(@"LoadImageResult: %@", latestLoans);
        // NSString *returnString = [latestLoans valueForKey:@"stataus"];
        NSLog(@"==> sendSyncReq returnString: %@", urlString);
        NSString *strStatus=[latestLoans valueForKey:@"status"];
        if([strStatus  isEqual: @"0"])
        {
            [[NSUserDefaults standardUserDefaults] setValue:@"Changes" forKey:@"session_NewImageAddedSuccess"];
        }
        else
        {
            [[NSUserDefaults standardUserDefaults] setValue:@"NoChanges" forKey:@"session_NewImageAddedSuccess"];
        }
        
        if([LastImageUpdate isEqual:@"Success5"] && [strStatus  isEqual: @"0"])
        {
            [[NSUserDefaults standardUserDefaults] setValue:@"Yes" forKey:@"LastImageUpdateConfirmationYesOrNo"];
        }
        // NSLog(@"%d,dfdfdsfdsfds",counts);
        // NSLog(@"%d,dfdsfsdfsdfsd",_selectedAssetsArray.count);
        
        
    }
    else
    {
        NSLog(@"22222222222222");
        //[self methodForProgressBarHide];
        //[self dismissViewControllerAnimated:YES completion:nil];
    }
    
}


-(void)MultiplePhotoUpdateGalleryPhoto:(UIImage *)PhotoImage  Query:(NSString *)strquerystiring

{
    CGFloat compression = 0.19f;
    
    CGFloat maxCompression = 0.1f;
    
    int maxFileSize = 250*1024;
    
    NSData *imageData = UIImageJPEGRepresentation(PhotoImage, compression);
    
    while ([imageData length] > maxFileSize && compression > maxCompression)
        
    {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(PhotoImage, compression);
    }

    NSData *dataImage = imageData;
    // NSString *urlStrings = [NSString stringWithFormat:@"%@Gallery/AddUpdateAlbumPhoto?",baseUrl];
    
    // NSString *urlString = [NSString stringWithFormat:@"%@%@",urlStrings,strquerystiring];
    
    
    
    // set your Image Name
    
    NSString *filename = @"YourImageFileName";
    
    // Create 'POST' MutableRequest with Data and Other Image Attachment.
    
    NSMutableURLRequest* request= [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:strquerystiring]];
    
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *postbody = [NSMutableData data];
    
    [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"%@.jpg\"\r\n", filename] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postbody appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
//    printf(dataImage);
    [postbody appendData:[NSData dataWithData:dataImage]];
    
    [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setHTTPBody:postbody];
    
    
    
    //NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    
    
    NSLog(@"Return String is here :-: %@",returnString);
    
    
    
    [[NSUserDefaults standardUserDefaults]setValue:@"Yes" forKey:@"session_IsComingFromImageSave"];
    
    if ([returnData length] > 0)
        
    {
        
        NSError* error;
        
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:returnData  options:kNilOptions error:&error];
        
        //[self.view makeToast:@"Photo added successfully" duration:3 position:CSToastPositionCenter];
        
        NSArray* latestLoans = [json objectForKey:@"LoadImageResult"];
        
        NSLog(@"LoadImageResult: %@", latestLoans);
        
        // NSString *returnString = [latestLoans valueForKey:@"stataus"];
        
        NSLog(@"==> sendSyncReq returnString: %@", strquerystiring);
        
        NSString *strStatus=[latestLoans valueForKey:@"status"];
        
        if([strStatus  isEqual: @"0"])
            
        {
            
            [[NSUserDefaults standardUserDefaults] setValue:@"Changes" forKey:@"session_NewImageAddedSuccess"];
            
        }
        
        else
            
        {
            
            [[NSUserDefaults standardUserDefaults] setValue:@"NoChanges" forKey:@"session_NewImageAddedSuccess"];
            
        }
      
    }
    
    else
        
    {
        
        NSLog(@"22222222222222");
        
        //[self methodForProgressBarHide];
        
        //[self dismissViewControllerAnimated:YES completion:nil];
        
    }
    
  
}


-(void)MultiplePhotoUpdateAddPhoto:(UIImage *)PhotoImage param:(NSString *)stringCaption photoID:(NSString *)photoIDdd
{
    
    
    NSString *groupID = [[NSUserDefaults standardUserDefaults] stringForKey:@"session_GetGroupId"];
    NSString *AlbumID = [[NSUserDefaults standardUserDefaults] stringForKey:@"session_AlbumID"];
    NSString *createdByUserIDProfileID = [[NSUserDefaults standardUserDefaults] stringForKey:@"session_createdByORUserIdOrProfileId"];
    NSString *descr = stringCaption;
    NSString *strDescr = [descr stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSLog(@"description++++++++++++++",strDescr);
    NSLog(@"%@",stringCaption);
    
    
    
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    int maxFileSize = 250*1024;
    NSData *imageData = UIImageJPEGRepresentation(PhotoImage, compression);
    while ([imageData length] > maxFileSize && compression > maxCompression)
    {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(PhotoImage, compression);
    }
    
    
    NSData *dataImage = imageData;
    NSString *urlStrings = [NSString stringWithFormat:@"%@Gallery/AddUpdateAlbumPhoto?",baseUrl];
    NSString *urlString = [NSString stringWithFormat:@"%@photoId=%@&desc=%@&albumId=%@&groupId=%@&createdBy=%@",urlStrings,photoIDdd,strDescr,AlbumID,groupID, createdByUserIDProfileID];
    
    // set your Image Name
    NSString *filename = @"YourImageFileName";
    // Create 'POST' MutableRequest with Data and Other Image Attachment.
    NSMutableURLRequest* request= [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    NSMutableData *postbody = [NSMutableData data];
    [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"%@.jpg\"\r\n", filename] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[NSData dataWithData:dataImage]];
    [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:postbody];
    
    //NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",returnString);
    
    [[NSUserDefaults standardUserDefaults]setValue:@"Yes" forKey:@"session_IsComingFromImageSave"];
    if ([returnData length] > 0)
    {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:returnData  options:kNilOptions error:&error];
        //[self.view makeToast:@"Photo added successfully" duration:3 position:CSToastPositionCenter];
        NSArray* latestLoans = [json objectForKey:@"LoadImageResult"];
        NSLog(@"LoadImageResult: %@", latestLoans);
        // NSString *returnString = [latestLoans valueForKey:@"stataus"];
        NSLog(@"==> sendSyncReq returnString: %@", urlString);
        NSString *strStatus=[latestLoans valueForKey:@"status"];
        if([strStatus  isEqual: @"0"])
        {
            [[NSUserDefaults standardUserDefaults] setValue:@"Changes" forKey:@"session_NewImageAddedSuccess"];
        }
        else
        {
            [[NSUserDefaults standardUserDefaults] setValue:@"NoChanges" forKey:@"session_NewImageAddedSuccess"];
        }
    
        
        // NSLog(@"%d,dfdfdsfdsfds",counts);
        // NSLog(@"%d,dfdsfsdfsdfsd",_selectedAssetsArray.count);
        
        
    }
    else
    {
        NSLog(@"22222222222222");
        //[self methodForProgressBarHide];
        //[self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
}


- (void)uploadToServerUsingImage:(NSData *)imageData andFileName:(NSString *)filename moduleName:(NSString*)moduleName {
    
    NSString *urlString = [NSString stringWithFormat:@"%@upload/UploadImage?module=%@",baseUrl,moduleName];
    
    NSLog(urlString);
    
    
    
    if (([filename length] -3 ) > 0) {
        NSString *contentType = [NSString stringWithFormat:@"Content-Type: image/%@", [filename substringFromIndex:[filename length] - 3]];
    }
    
    // allocate and initialize the mutable URLRequest, set URL and method.
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    request.timeoutInterval=60;
    // define the boundary and newline values
    NSString *boundary = @"uwhQ9Ho7y873Ha";
    NSString *kNewLine = @"\r\n";
    
    // Set the URLRequest value property for the HTTP Header
    // Set Content-Type as a multi-part form with boundary identifier
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // prepare a mutable data object used to build message body
    NSMutableData *body = [NSMutableData data];
    
    // set the first boundary
    [body appendData:[[NSString stringWithFormat:@"--%@%@", boundary, kNewLine] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // Set the form type and format
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"%@", @"uploaded_file", filename, kNewLine] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Type: image/png"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // Now append the image itself.  For some servers, two carriage-return line-feeds are necessary before the image
    [body appendData:[[NSString stringWithFormat:@"%@%@", kNewLine, kNewLine] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:imageData];
    [body appendData:[kNewLine dataUsingEncoding:NSUTF8StringEncoding]];
    
    // Add the terminating boundary marker & append a newline
    [body appendData:[[NSString stringWithFormat:@"--%@--", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[kNewLine dataUsingEncoding:NSUTF8StringEncoding]];
    // Setting the body of the post to the request.
    [request setHTTPBody:body];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    // TODO: Next three lines are only used for testing using synchronous conn.
    // NSData *returnData;// = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    [NSURLConnection sendAsynchronousRequest:request queue:queue  completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if ([data length] > 0 && error == nil)
             [self doSomething:data];
         
         
     }];
    
    // You will probably want to replace above 3 lines with asynchronous connection
    //    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
}

-(void) doSomething:(NSData*) data{
    NSString *returnString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"==> sendSyncReq returnString: %@", returnString);
    // [activityIndicator stopAnimating];
    LoadImageResult* lodImg = [LoadImageResult fromJSONData:[returnString dataUsingEncoding:NSUTF8StringEncoding]];
    [self.delegate getUploadImgSucceeded:lodImg];
}

//////--
- (void)uploadToServerUsingDocumentsNew:(NSString *)imageData andFileName:(NSString *)filename moduleName:(NSString*)moduleName {
    // set this to your server's address
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@upload/UploadAllDocs?module=%@",baseUrl,moduleName];
    NSLog(@"post param %@",urlString);
    
    // set the content type, in this case it needs to be: "Content-Type: image/jpg"
    // Extract 'jpg' or 'png' from the last three characters of 'filename'
    if (([filename length] -3 ) > 0) {
        NSString *contentType = [NSString stringWithFormat:@"Content-Type: image/%@", [filename substringFromIndex:[filename length] - 3]];
    }
    
    // allocate and initialize the mutable URLRequest, set URL and method.
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    request.timeoutInterval=60;
    // define the boundary and newline values
    NSString *boundary = @"uwhQ9Ho7y873Ha";
    NSString *kNewLine = @"\r\n";
    
    // Set the URLRequest value property for the HTTP Header
    // Set Content-Type as a multi-part form with boundary identifier
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // prepare a mutable data object used to build message body
    NSMutableData *body = [NSMutableData data];
    
    // set the first boundary
    [body appendData:[[NSString stringWithFormat:@"--%@%@", boundary, kNewLine] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // Set the form type and format
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"%@", @"uploaded_file", filename, kNewLine] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Type: image/png"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // Now append the image itself.  For some servers, two carriage-return line-feeds are necessary before the image
    [body appendData:[[NSString stringWithFormat:@"%@%@", kNewLine, kNewLine] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:imageData];
    [body appendData:[kNewLine dataUsingEncoding:NSUTF8StringEncoding]];
    
    // Add the terminating boundary marker & append a newline
    [body appendData:[[NSString stringWithFormat:@"--%@--", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[kNewLine dataUsingEncoding:NSUTF8StringEncoding]];
    // Setting the body of the post to the request.
    [request setHTTPBody:body];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue  completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if ([data length] > 0 && error == nil)
             [self doSomething12:data];
     }];
}
///---

- (void)uploadToServerUsingDocuments:(NSData *)imageData andFileName:(NSString *)filename moduleName:(NSString*)moduleName {
    // set this to your server's address
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@upload/UploadAllDocs?module=%@",baseUrl,moduleName];
    NSLog(@"post param %@",urlString);
    // set the content type, in this case it needs to be: "Content-Type: image/jpg"
    // Extract 'jpg' or 'png' from the last three characters of 'filename'
    if (([filename length] -3 ) > 0) {
        NSString *contentType = [NSString stringWithFormat:@"Content-Type: image/%@", [filename substringFromIndex:[filename length] - 3]];
    }
    
    // allocate and initialize the mutable URLRequest, set URL and method.
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    request.timeoutInterval=60;
    // define the boundary and newline values
    NSString *boundary = @"uwhQ9Ho7y873Ha";
    NSString *kNewLine = @"\r\n";
    
    // Set the URLRequest value property for the HTTP Header
    // Set Content-Type as a multi-part form with boundary identifier
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // prepare a mutable data object used to build message body
    NSMutableData *body = [NSMutableData data];
    
    // set the first boundary
    [body appendData:[[NSString stringWithFormat:@"--%@%@", boundary, kNewLine] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // Set the form type and format
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"%@", @"uploaded_file", filename, kNewLine] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Type: image/png"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // Now append the image itself.  For some servers, two carriage-return line-feeds are necessary before the image
    [body appendData:[[NSString stringWithFormat:@"%@%@", kNewLine, kNewLine] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:imageData];
    [body appendData:[kNewLine dataUsingEncoding:NSUTF8StringEncoding]];
    
    // Add the terminating boundary marker & append a newline
    [body appendData:[[NSString stringWithFormat:@"--%@--", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[kNewLine dataUsingEncoding:NSUTF8StringEncoding]];
    // Setting the body of the post to the request.
    [request setHTTPBody:body];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue  completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if ([data length] > 0 && error == nil)
             [self doSomething12:data];
         
         
     }];
}

-(void) doSomething12:(NSData*) data{
    // NSData *returnData = [NSURLConnection sendSynchronousRequest:data returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"==> sendSyncReq returnString: %@", returnString);
    LoadImageResult* lodImg = [LoadImageResult fromJSONData:[returnString dataUsingEncoding:NSUTF8StringEncoding]];
    [self.delegate getUploadDocSucceeded:lodImg];
}

- (void)uploadProfilePicTOServer:(NSData *)imageData andProfileID:(NSString *)ProfileID andGroupID:(NSString*)GrpID{
    // set this to your server's address
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@Member/UploadProfilePhoto?ProfileID=%@&GrpID=%@",baseUrl,ProfileID,GrpID];
    NSLog(@"url %@",urlString);
    
    NSString *filename = @"Profile";
    
    // set the content type, in this case it needs to be: "Content-Type: image/jpg"
    // Extract 'jpg' or 'png' from the last three characters of 'filename'
    if (([filename length] -3 ) > 0) {
        NSString *contentType = [NSString stringWithFormat:@"Content-Type: image/%@", [filename substringFromIndex:[filename length] - 3]];
    }
    
    // allocate and initialize the mutable URLRequest, set URL and method.
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    request.timeoutInterval=60;
    // define the boundary and newline values
    NSString *boundary = @"uwhQ9Ho7y873Ha";
    NSString *kNewLine = @"\r\n";
    
    // Set the URLRequest value property for the HTTP Header
    // Set Content-Type as a multi-part form with boundary identifier
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // prepare a mutable data object used to build message body
    NSMutableData *body = [NSMutableData data];
    
    // set the first boundary
    [body appendData:[[NSString stringWithFormat:@"--%@%@", boundary, kNewLine] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // Set the form type and format
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"%@", @"uploaded_file", filename, kNewLine] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Type: image/png"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // Now append the image itself.  For some servers, two carriage-return line-feeds are necessary before the image
    [body appendData:[[NSString stringWithFormat:@"%@%@", kNewLine, kNewLine] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:imageData];
    [body appendData:[kNewLine dataUsingEncoding:NSUTF8StringEncoding]];
    
    // Add the terminating boundary marker & append a newline
    [body appendData:[[NSString stringWithFormat:@"--%@--", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[kNewLine dataUsingEncoding:NSUTF8StringEncoding]];
    // Setting the body of the post to the request.
    [request setHTTPBody:body];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue  completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if ([data length] > 0 && error == nil)
             [self doSomething11:data];
         
         
     }];
    
    // TODO: Next three lines are only used for testing using synchronous conn.
    // NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    //[indicator stopAnimating];
    // You will probably want to replace above 3 lines with asynchronous connection
    //    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
}
-(void) doSomething11:(NSData*) data{
    NSString *returnString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"==> sendSyncReq returnString: %@", returnString);
    UploadImageResult* lodImg = [UploadImageResult fromJSONData:[returnString dataUsingEncoding:NSUTF8StringEncoding]];
    [self.delegate getUploadProfilePicSucceeded:lodImg];
}

-(void) createNsArrayDic:(NSArray *)NameArray andNumberArray:(NSArray *)NumberArray andGroupID:(NSString *)GroupID andMasterUID:(NSString *)MasterUID
{
    NSMutableArray* ArrayDic = [[NSMutableArray alloc]init];
    
    for (int i=0; i < NameArray.count; i++)
    {
        NSDictionary *dicObject = [[NSDictionary alloc]initWithObjectsAndKeys:[NumberArray objectAtIndex:i],@"mobile",[NameArray objectAtIndex:i],@"userName",GroupID,@"groupId",MasterUID,@"masterID", nil];
        
        [ArrayDic addObject:dicObject];
    }
    
    [self.delegate getDicArraySucceeded:ArrayDic];
    
    NSLog(@"dict obj = %@",ArrayDic);
}



-(void) createNsArrayDicTOAddSingleMember:(NSString *)Name andNumber:(NSString *)Number andGroupID:(NSString *)GroupID andMasterUID:(NSString *)MasterUID andCountryId:(NSString *)CountryID andMemberEmail:(NSString *)MemberEmailID
{
    NSMutableArray* ArrayDicArray = [[NSMutableArray alloc]init];
    
    NSMutableDictionary *memberData = [NSMutableDictionary dictionaryWithObjectsAndKeys:Number,@"mobile", nil];
    [memberData setObject:Name forKey:@"userName"];
    [memberData setObject:GroupID forKey:@"groupId"];
    [memberData setObject:MasterUID forKey:@"masterID"];
    [memberData setObject:CountryID forKey:@"countryId"];
    [memberData setObject:MemberEmailID forKey:@"memberEmail"];
    [ArrayDicArray addObject:memberData];
    [self.delegate getDicArrayAddSingleMemberSucceeded:ArrayDicArray];
    
    NSLog(@"dict obj = %@",ArrayDicArray);
}




@end
