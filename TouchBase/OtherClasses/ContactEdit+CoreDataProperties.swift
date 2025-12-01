//
//  ContactEdit+CoreDataProperties.swift
//  
//
//  Created by Umesh on 08/09/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension ContactEdit
{

    @NSManaged var name: String?
    @NSManaged var mobileNumber: String?

}
