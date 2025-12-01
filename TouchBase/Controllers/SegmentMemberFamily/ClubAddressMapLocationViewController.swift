//
//  ClubAddressMapLocationViewController.swift
//  TouchBase
//
//  Created by rajendra on 28/06/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit
import MapKit

class ClubAddressMapLocationViewController: UIViewController  {

    var venueLat:String!=""
    var venueLng:String!=""
    var venueName:String!=""
    
    @IBOutlet weak var addressMap: MKMapView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        openMapForPlace()
        // Do any additional setup after loading the view.
    }
    
    func openMapForPlace() {
        
        let lat1 : NSString = self.venueLat as! NSString
        let lng1 : NSString = self.venueLng as! NSString
        
        let latitude:CLLocationDegrees =  lat1.doubleValue
        let longitude:CLLocationDegrees =  lng1.doubleValue
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "\(self.venueName)"
        mapItem.openInMaps(launchOptions: options)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
