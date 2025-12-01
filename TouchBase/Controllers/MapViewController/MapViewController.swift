//
//  MapViewController.swift
//  TouchBase
//
//  Created by Umesh on 29/02/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit
import MapKit
class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    var vnLat:NSString!
    var vnLon:NSString!
    var locName:NSString!
    let regionRadius: CLLocationDistance = 1000
    override func viewDidLoad() {
        super.viewDidLoad()
        let theSpan:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01 , longitudeDelta: 0.01)
        let latitude: CLLocationDegrees = vnLat.doubleValue
        let longitude: CLLocationDegrees = vnLon.doubleValue
        
        let locatn: CLLocation = CLLocation(latitude: latitude,
            longitude: longitude)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: locatn.coordinate.latitude , longitude: locatn.coordinate.longitude)
        let theRegion:MKCoordinateRegion = MKCoordinateRegion(center: location, span: theSpan)
        
        mapView.setRegion(theRegion, animated: true)
        let anotation = MKPointAnnotation()
      //  anotation.coordinate = location
       // anotation.title = locName as String
        //anotation.subtitle = "This is the location !!!"
       // mapView.removeAnnotation(anotation)
        mapView.removeAnnotations(mapView.annotations)
       // mapView.addAnnotation(anotation)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
