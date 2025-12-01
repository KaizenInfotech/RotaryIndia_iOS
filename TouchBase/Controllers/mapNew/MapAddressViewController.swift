import Foundation
import UIKit
import UIKit
import CoreLocation
import MapKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}

class MapAddressViewController: UIViewController,CLLocationManagerDelegate,UIGestureRecognizerDelegate
{
    var  varGetAddress:String!=""
    //MARK:- Interface Builder
    @IBOutlet var buttonAddress: UIButton!
    @IBOutlet var buttonDone: UIButton!
    @IBOutlet var mapviewUSerLocation: MKMapView!
    //MARK:- Local Variable
    var locationManager = CLLocationManager()
    var letLatitude:Double? = nil
    var letLongitude:Double? = nil
    //MARK:- Public Variable
    var varGetProperAddress:String?
    var centerAnnotation = MKPointAnnotation()
    var centerAnnotationView = MKPinAnnotationView()
    //MARK:- 1.ViewDidLoad
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //gps
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        // mapviewUSerLocation.userInteractionEnabled=false
        // add home button for current location
        self.navigationItem.rightBarButtonItems = [MKUserTrackingBarButtonItem(mapView: mapviewUSerLocation)]
        //--add left button on naigation
        //        let buttonDone = UIBarButtonItem(title: "Done", style: .Done, target: self, action: #selector(buttonDoneclickEvent))
        //        navigationItem.leftBarButtonItems = [buttonDone]
        createNavigationBar()
    }
    
    func createNavigationBar(){
        self.title="Address"
        // let attributes = [NSFontAttributeName : UIFont(name: "Roboto-Regular", size: 17)!, NSForegroundColorAttributeName : UIColor.whiteColor()]
        // self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor(red: 0/255.0, green: 96/255.0, blue: 170/255.0, alpha: 1.0)
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height: 40)
        buttonleft.setImage(UIImage(named:"back_btn"),  for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(MapAddressViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    
    
    
    //MARK:- 2.ViewDidppear
    override func viewDidAppear(_ animated: Bool)
    {
        buttonAddress.titleLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping
        buttonAddress.titleLabel!.textAlignment = .center
        buttonAddress.backgroundColor = UIColor.white
        buttonAddress.layer.borderColor = UIColor.yellow.cgColor
        buttonAddress.layer.borderWidth = 2
    }
    //MARK:- ViewwillAppear
    override func viewWillAppear(_ animated: Bool)
    {
        //1.
        let letGetIfFormattedAddressExist = UserDefaults.standard.string(forKey: "session_setGetFormattedAddress")
        UserDefaults.standard.synchronize()
        if(letGetIfFormattedAddressExist?.characters.count>0)
        {
            //1.
            letLatitude = Double(UserDefaults.standard.string(forKey: "session_setGetLatitude")!)
            UserDefaults.standard.synchronize()
            //2.
            letLongitude = Double(UserDefaults.standard.string(forKey: "session_setGetLongitude")!)
            UserDefaults.standard.synchronize()
            functionForSetLatnLongOnMap()
        }
    }
    //MARK:-  3.GPS location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in
            let locValue:CLLocationCoordinate2D = self.locationManager.location!.coordinate
            self.letLatitude = locValue.latitude
            self.letLongitude = locValue.longitude
            if (error != nil)
            {
                return
            }
            if placemarks!.count > 0
            {
                let pm = placemarks![0]
                self.displayLocationInfo(pm)
            }
            else
            {
                // print("Problem with the data received from geocoder")
            }
            self.functionForSetLatnLongOnMap()
        })
    }
    func displayLocationInfo(_ placemark: CLPlacemark?)
    {
        if placemark != nil
        {
            locationManager.stopUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        //  print("Error while updating location " + error.localizedDescription)
    }
    //MARK:- 4.Button Click Event
    
    @IBAction func buttonBackClickEvent(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: {});
    }
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
        
        //self.dismissViewControllerAnimated(true, completion: {});
        
    }
    @IBAction func buttonSearchClickEvent(_ sender: AnyObject)
    {
       // let objSearchStylistViewController = ABCGooglePlacesSearchViewController()
        //self.navigationController?.pushViewController(objSearchStylistViewController, animated: true)
    }
    //  MARK:- 5.Function for set lat and long on Map
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool)
    {
        self.centerAnnotation.coordinate = self.mapviewUSerLocation.centerCoordinate
        let mapLatitude = mapviewUSerLocation.centerCoordinate.latitude
        let mapLongitude = mapviewUSerLocation.centerCoordinate.longitude
        self.letLatitude = mapLatitude
        self.letLongitude = mapLongitude
        self.mapviewUSerLocation.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = mapView.centerCoordinate
        annotation.title = "Location"
        setUsersClosestCity(letLatitude! , long:letLongitude!)
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    //------set lat and long on map ----
    func functionForSetLatnLongOnMap()
    {
        let latDelta:CLLocationDegrees = 0.01
        let longDelta:CLLocationDegrees = 0.01
        let theSpan:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        let pointLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(self.letLatitude!,self.letLongitude!)
        let region:MKCoordinateRegion = MKCoordinateRegion(center: pointLocation, span: theSpan)
        mapviewUSerLocation.setRegion(region, animated: true)
        functionForCommonSetOnMapLatandLong()
        
        
        ////-----
        
        let address = varGetAddress
        print(varGetAddress)
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(address!, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                print("This is Error:------>")
                print("Error", error)
                // self.navigationController?.popViewControllerAnimated(true)
                
                let alertController = UIAlertController(title: "", message: "Unable to find the location as the address may be incomplete.", preferredStyle: .alert)
                self.present(alertController, animated: true, completion: nil)
                let delay = 4.0 * Double(NSEC_PER_SEC)
                let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
                DispatchQueue.main.asyncAfter(deadline: time, execute: {
                    alertController.dismiss(animated: true, completion: nil)
                    self.navigationController?.popViewController(animated: true)
                })
                
                
                
            }
            else
            {
                if let placemark = placemarks?.first {
                    let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                    
                    
                    
                    print(placemark)
                    print(coordinates.latitude)
                    print(coordinates.longitude)
                    let pointLocationn:CLLocationCoordinate2D = CLLocationCoordinate2DMake(coordinates.latitude,coordinates.longitude)
                    let regionn:MKCoordinateRegion = MKCoordinateRegion(center: pointLocationn, span: theSpan)
                    self.mapviewUSerLocation.setRegion(regionn, animated: true)
                    
                    
                    
                }
            }
        })
        
        
        
    }
    //MARK:- code for when you drag the map
    /*-----------------------------------------------------*/
    func setUsersClosestCity(_ lat:Double,long:Double)
    {
        functionForCommonSetOnMapLatandLong()
    }
    //MARK:- Common method for set lat and long on map
    func functionForCommonSetOnMapLatandLong()
    {
        let location = CLLocation(latitude: self.letLatitude!, longitude: self.letLongitude!) //changed!!!
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {( placemarks, error) -> Void in
            if let placemark = placemarks?.last , let addrList = placemark.addressDictionary?["FormattedAddressLines"] as? [String]
            {
                let address =  addrList.joined(separator: ", ")
                print(address)
                self.buttonAddress.setTitle("  "+address+",    ",  for: UIControl.State.normal)
            }
        })
    }
}
