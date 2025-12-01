//
//  ServiceMapViewController.swift
//  TouchBase
//
//  Created by Umesh on 25/07/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit
import MapKit

class ServiceMapViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var mapView: MKMapView!
    var vnLat:NSString!
    var vnLon:NSString!
    var locName:NSString!
    @IBOutlet var locText : UITextField!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        createNavigationBar()
        self.title = "Get Direction"
        let theSpan:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01 , longitudeDelta: 0.01)
        let latitude: CLLocationDegrees = vnLat.doubleValue
        let longitude: CLLocationDegrees = vnLon.doubleValue
        
        let locatn: CLLocation = CLLocation(latitude: latitude,
                                            longitude: longitude)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: locatn.coordinate.latitude , longitude: locatn.coordinate.longitude)
        let theRegion:MKCoordinateRegion = MKCoordinateRegion(center: location, span: theSpan)
        mapView.showsUserLocation = true
        mapView.mapType = MKMapType.satellite
        mapView.setRegion(theRegion, animated: true)
        let anotation = MKPointAnnotation()
          anotation.coordinate = location
         anotation.title = locName as String
        //anotation.subtitle = "This is the location !!!"
        // mapView.removeAnnotation(anotation)
        mapView.removeAnnotations(mapView.annotations)
         mapView.addAnnotation(anotation)
        self.locText.text = locName as String
        
        let uilgr = UILongPressGestureRecognizer(target: self, action: #selector(ServiceMapViewController.addAnnotation(_:)))
        uilgr.minimumPressDuration = 1.0
        mapView.addGestureRecognizer(uilgr)
        // Do any additional setup after loading the view.
    }
    @objc func addAnnotation(_ gestureRecognizer:UIGestureRecognizer)
    {
//        if gestureRecognizer.state == UIGestureRecognizer.StateBegan {
//            var touchPoint = gestureRecognizer.locationInView(mapView)
//            var newCoordinates = mapView.convertPoint(touchPoint, toCoordinateFromView: mapView)
//            let annotation = MKPointAnnotation()
//            annotation.coordinate = newCoordinates
//            
//            CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: newCoordinates.latitude, longitude: newCoordinates.longitude), completionHandler: {(placemarks, error) -> Void in
//                if error != nil {
//                    print("Reverse geocoder failed with error" + error!.localizedDescription)
//                    return
//                }
//                
//                if placemarks!.count > 0 {
//                    let pm = placemarks![0] as! CLPlacemark
//                    
//                    // not all places have thoroughfare & subThoroughfare so validate those values
//                    //annotation.title = pm.thoroughfare! + ", " + pm.subThoroughfare!
//                   // annotation.subtitle = pm.subLocality
//                    self.mapView.addAnnotation(annotation)
//                    print(pm)
//                }
//                else {
//                    annotation.title = "Unknown Place"
//                    self.mapView.addAnnotation(annotation)
//                    print("Problem with the data received from geocoder")
//                }
//                self.vnLon = newCoordinates.longitude as! String
//                self.vnLat = newCoordinates.latitude as! String
//                print("new loc \(self.vnLat)")
//                //places.append(["name":annotation.title,"latitude":"\(newCoordinates.latitude)","longitude":"\(newCoordinates.longitude)"])
//            })
//        }
        if gestureRecognizer.state != .began { return }
        
        let touchPoint = gestureRecognizer.location(in: self.mapView)
        let touchMapCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = touchMapCoordinate
        mapView.addAnnotation(annotation)
        self.vnLon =  String(format:"%f", touchMapCoordinate.longitude) as NSString
        self.vnLat =  String(format:"%f", touchMapCoordinate.latitude) as NSString
        print("new loc \(self.vnLat)")
        
    }
   
    func createNavigationBar(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title=""
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(ServiceMapViewController.backClicked), for: UIControl.Event.touchUpInside)
        

        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        let buttonlog = UIButton(type: UIButton.ButtonType.custom)
        buttonlog.frame = CGRect(x: 0, y: 0, width: 60, height: 40)
        buttonlog.titleLabel?.textAlignment = NSTextAlignment.right
        buttonlog.titleLabel?.font = UIFont(name: "Open Sans", size: 15)
        buttonlog.setTitle("Save",  for: UIControl.State.normal)
        buttonlog.addTarget(self, action: #selector(ServiceMapViewController.skipClicked), for: UIControl.Event.touchUpInside)
        let skipButton: UIBarButtonItem = UIBarButtonItem(customView: buttonlog)
        self.navigationItem.rightBarButtonItem = skipButton
        
    }
    @objc func skipClicked()
    {
        UserDefaults.standard.set(vnLat, forKey: "serviceLat")
        UserDefaults.standard.set(vnLon, forKey: "serviceLon")
        self.navigationController?.popViewController(animated: true)
    }
     @objc func backClicked()
    {
        UserDefaults.standard.set("", forKey: "serviceAddress")
        UserDefaults.standard.set("", forKey: "serviceLat")
        UserDefaults.standard.set("", forKey: "serviceLon")
        self.navigationController?.popViewController(animated: true)
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
