//
//  CreateAlbumModel.swift
//  TouchBase
//
//  Created by Umesh on 04/01/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit

class CreateAlbumModel: NSObject
{
    let letGetAlbumId:String! = nil
    let letGetDescription:String! = nil
    let letGetId:String! = nil
    let letImage:String! = nil
    let letIsAdmin:String! = nil
    let letTitle:String! = nil
    let letType:String! = nil
    
    
    /*
     + (NSMutableArray *) saveServiceProviderListInfo:(NSArray *)serviceProviderListArray {
     if (serviceProviderListArray.count == 0)
     return nil;
     
     NSMutableArray *commonArray = [[NSMutableArray alloc] init];
     
     [serviceProviderListArray enumerateObjectsUsingBlock:^(NSDictionary *dictServiceProviderList, NSUInteger idx, BOOL *stop) {
     HelpITWebList *sPList = [[HelpITWebList alloc] init];
     
     if ([dictServiceProviderList hasValueForKey:k_API_HelpITSPID]) {
     sPList.sPID = [dictServiceProviderList valueForKey:k_API_HelpITSPID];
     }
     if ([dictServiceProviderList hasValueForKey:k_API_HelpITSPName]) {
     sPList.sPName = [dictServiceProviderList valueForKey:k_API_HelpITSPName];
     }
     if ([dictServiceProviderList hasValueForKey:k_API_HelpITSPURL]) {
     sPList.sPURL = [dictServiceProviderList valueForKey:k_API_HelpITSPURL];
     }
     if ([dictServiceProviderList hasValueForKey:k_API_HelpITSPEmail]) {
     sPList.sPEmail = [dictServiceProviderList valueForKey:k_API_HelpITSPEmail];
     }
     if ([dictServiceProviderList hasValueForKey:k_API_HelpITSPContactNo]) {
     sPList.sPContactNo = [dictServiceProviderList valueForKey:k_API_HelpITSPContactNo];
     }
     
     if (sPList)
     {
     [commonArray addObject:sPList];
     }
     }];
     return commonArray;
     }
     */
    
    func saveServiceProviderListInfo(_ dict:NSArray)->NSArray
    {
       
        
        //print(dict.valueForKey("newAlbums"))
       // var muarray:NSMutableArray=NSMutableArray()
       // muarray=dict.valueForKey("newAlbums") as! NSMutableArray
        //print(dict.valueForKey("newAlbums")as! NSMutableArray)
        return dict
    }
    
    
}





