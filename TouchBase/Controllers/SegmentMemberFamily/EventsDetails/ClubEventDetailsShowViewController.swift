//
//  ClubEventDetailsShowViewController.swift
//  TouchBase
//
//  Created by rajendra on 01/08/17.
//  Copyright © 2017 Parag. All rights reserved.
//
import SVProgressHUD
import UIKit
//import Kingfisher
class ClubEventDetailsShowViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var muarrayFindAClubEventList:NSMutableArray=NSMutableArray()
    var muDictionaryForEventDetails:NSMutableDictionary=NSMutableDictionary()
    
    var  muarrayClubDetail:NSMutableArray=NSMutableArray()
    var senderTag:Int=0
    var varRowHeight:CGFloat!=0.0
    @IBOutlet weak var tableviewClubEventDetails: UITableView!
    
    var grpId:String!=""
    var eventID:String!=""
    var profileId:String!=""
    var isCalled:String!=""
    var isfiltered = false
    var titles = ""
    var desc = ""
    var lat = ""
    var long = ""
    var eventdate = ""
    var img = ""
    var venue = ""
    
    var fullImage = ""
    
    
    override func viewWillAppear(_ animated: Bool) {
        createNavigationBar()
    }
    func functionForSetColorInString(_ stringKey:String,stringName:String)->NSAttributedString
        
    {
        
        let text = "I agree with TERMS and CONDITION"
        
        let linkTextWithColor = "CONDITION"
        
        
        
        let range = (text as NSString).range(of: linkTextWithColor)
        
        
        
        let attributedString = NSMutableAttributedString(string:text)
        
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray , range: range)
        
        var attributedStringss:NSAttributedString=NSAttributedString()
        
        let htmlStringss = "  <font size=\"5\"><span style=\"font-family: Roboto-Regular;\"><font color=\"#000000\">"+stringKey+"</font> <br/><br/><font color=\"#808080\">"+stringName+"</span></font> </font>"
        
        let encodedDatass = htmlStringss.data(using: String.Encoding.utf8)!
        
           let attributedOptionsss = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        
        do {
            
            attributedStringss = try NSAttributedString(data: encodedDatass, options: attributedOptionsss, documentAttributes: nil)
            
            
            
            // labelIAgreeWith.attributedText=attributedStringss;
            
        } catch _ {
            
            print("Cannot create attributed String")
            
        }
        
        print(attributedStringss)
        
        return attributedStringss
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("VENUEE----\(venue)")
//
//        if isCalled=="notify"
//        {
//            functionForGetEventDetails()
//        }
//        else
//        
//        {
//        print(self.muarrayFindAClubEventList)
        
           
        
        
       // print(varGetTitleDescription)
        /*
        var varGetLat:String!=(muarrayFindAClubEventList[senderTag].objectForKey("venueLat"))as! String
        var varGetLong:String!=(muarrayFindAClubEventList[senderTag].objectForKey("venueLon"))as! String
        
        if(varGetLat=="")
        {
            varGetLat = "21.228124"
        }
        else
        {
        }
        if(varGetLong=="")
        {
            varGetLong = "72.833770"
        }
        else
        {
        }
        var placemarks:String! = getAddressFromLatLon(varGetLat, withLongitude: varGetLong)
          */
       // }
        
        //need to get address from lat an dlong
       // var varGetTimeandDate=(muarrayFindAClubEventList[0].objectForKey("eventDateTime"))
       // var varGetFullAddress:String!=placemarks
        
       // muarrayClubDetail.addObject(muarrayFindAClubEventList[0].objectForKey("eventImg")!)
       // muarrayClubDetail.addObject(varGetTitleDescription)
       // muarrayClubDetail.addObject(varGetFullAddress)
       // muarrayClubDetail.addObject(varGetTimeandDate!)
        
       // print(muarrayClubDetail)
        //eventTitle
        //eventDesc
        // Do any additional setup after loading the view.
        if isfiltered {
            self.muarrayClubDetail.add(img)
            self.muarrayClubDetail.add(titles + desc)
            self.muarrayClubDetail.add(venue)
            self.muarrayClubDetail.add(eventdate)
        } else {
            let varGetTitleDescription:String!=(((self.muarrayFindAClubEventList[self.senderTag] as AnyObject).object(forKey: "eventTitle")!) as! String)+(((self.muarrayFindAClubEventList[0] as AnyObject).object(forKey: "eventDesc")!) as! String)
            print(varGetTitleDescription)
            var varGetLat:String!=((self.muarrayFindAClubEventList[self.senderTag] as AnyObject).object(forKey: "venueLat"))as! String
            var varGetLong:String!=((self.muarrayFindAClubEventList[self.senderTag] as AnyObject).object(forKey: "venueLon"))as! String
            
            //need to get address from lat an dlong
            let varGetTimeandDate=((self.muarrayFindAClubEventList[self.senderTag] as AnyObject).object(forKey: "eventDateTime"))
            
            
            self.muarrayClubDetail.add((self.muarrayFindAClubEventList[self.senderTag] as AnyObject).object(forKey: "eventImg")!)
            self.muarrayClubDetail.add(varGetTitleDescription)
            self.muarrayClubDetail.add(((self.muarrayFindAClubEventList[self.senderTag] as AnyObject).object(forKey: "venue"))as! String )
            self.muarrayClubDetail.add(varGetTimeandDate!)
        }
        self.tableviewClubEventDetails.reloadData()
    }
    
    func functionForGetFullAddress(_ doubleLat:Double,doubleLong:Double)->String
    {
        var varGetFullAddress:String!=""
        let longitude :CLLocationDegrees = doubleLong
        let latitude :CLLocationDegrees = doubleLat
        
        let location = CLLocation(latitude: latitude, longitude: longitude) //changed!!!
        print(location)
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            print(location)
            
            if error != nil
            {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
                return
            }
            
            if placemarks!.count > 0 {
                let pm = placemarks![0] 
                print(pm.locality)
                varGetFullAddress=pm.locality
                print(placemarks)
            }
            else
            {
                print("Problem with the data received from geocoder")
            }
        })
        print(varGetFullAddress)
        return varGetFullAddress
    }
    //////--------------
    func getAddressFromLatLon(_ pdblLatitude: String, withLongitude pdblLongitude: String)->String {
         var varGetFullAddress:String!=""
        var addressString : String = ""
        
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    let pm = placemarks![0]
                    print(pm.country)
                    print(pm.locality)
                    print(pm.subLocality)
                    print(pm.thoroughfare)
                    print(pm.postalCode)
                    print(pm.subThoroughfare)
                    
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                    
                    print(self.muarrayFindAClubEventList)
                    
                    
            let varGetTitleDescription:String!=(((self.muarrayFindAClubEventList[self.senderTag] as AnyObject).object(forKey: "eventTitle")!) as! String)+(((self.muarrayFindAClubEventList[0] as AnyObject).object(forKey: "eventDesc")!) as! String)
                    
                    
                    
                    
                    print(varGetTitleDescription)
                    var varGetLat:String!=((self.muarrayFindAClubEventList[self.senderTag] as AnyObject).object(forKey: "venueLat"))as! String
            var varGetLong:String!=((self.muarrayFindAClubEventList[self.senderTag] as AnyObject).object(forKey: "venueLon"))as! String
                   
                    //need to get address from lat an dlong
                    let varGetTimeandDate=((self.muarrayFindAClubEventList[self.senderTag] as AnyObject).object(forKey: "eventDateTime"))
                    
                    self.muarrayClubDetail.add((self.muarrayFindAClubEventList[self.senderTag] as AnyObject).object(forKey: "eventImg")!)
                    self.muarrayClubDetail.add(varGetTitleDescription)
                    self.muarrayClubDetail.add(((self.muarrayFindAClubEventList[self.senderTag] as AnyObject).object(forKey: "venue"))as! String )
                    self.muarrayClubDetail.add(varGetTimeandDate!)
                    
                    self.tableviewClubEventDetails.reloadData()
                    
                    
                    print(addressString)
                }
        })
        
        print(addressString)
        return addressString
    }
    //////-------------
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createNavigationBar(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title = "Events"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white //(red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(ClubEventDetailsShowViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        //let add = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(ClubEventDetailsShowViewController.AddEventAction))
        //add.tintColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
        let mainMemberID = UserDefaults.standard.string(forKey: "isAdmin")//isAdmin
//        if mainMemberID == "Yes"
//        {
//            self.navigationItem.rightBarButtonItem = add
//        }
        //Partial
    }
    
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
        if((self.presentingViewController) != nil){
            
            self.dismiss(animated: false, completion: nil)
            
            print("done")
            
        }
    }
    /*
     @IBOutlet weak var viewFirst: UIView!
     @IBOutlet weak var textviewDescription: UITextView!
     @IBOutlet weak var viewSecond: UIView!
     @IBOutlet weak var buttonAddress: UIButton!
     @IBOutlet weak var viewThird: UIView!
     @IBOutlet weak var buttonTimeMain: UIButton!
     @IBOutlet weak var buttonAddressMain: UIButton!
     @IBOutlet weak var buttonTime: UIButton!
     
     */
    
    @objc func imageTapped() {
        let objImageFullViewViewController = self.storyboard!.instantiateViewController(withIdentifier: "ImageFullViewViewController") as! ImageFullViewViewController
        objImageFullViewViewController.varGetImageUrl = self.fullImage
        self.navigationController?.pushViewController(objImageFullViewViewController, animated: true)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print("muarrayClubDetail.count--\(muarrayClubDetail)")
        return muarrayClubDetail.count
    }
     func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return varRowHeight
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "Cell") as! ClubEventDetailsShowTableViewCell
        cell.profilePic.layer.borderColor = UIColor.lightGray.cgColor
        
        cell.buttonTimeMain.addTarget(self, action: #selector(ClubEventDetailsShowViewController.buttonTimeMainClicked(_:)), for: UIControl.Event.touchUpInside)
        cell.buttonTimeMain.tag=indexPath.row;
        
        
        cell.buttonAddressMain.addTarget(self, action: #selector(ClubEventDetailsShowViewController.buttonAddressMainClicked(_:)), for: UIControl.Event.touchUpInside)
        cell.buttonAddressMain.tag=indexPath.row;
        
        
        print(muarrayClubDetail.object(at: indexPath.row)as! String)
        
        
            cell.viewFirst.frame = CGRect(x: 10.0, y: 5.0,  width: cell.viewFirst.frame.size.width,  height: 330)
            cell.viewSecond.frame = CGRect(x: 10.0, y: 5.0,  width: cell.viewFirst.frame.size.width,  height: 69)
            cell.viewThird.frame = CGRect(x: 10.0, y: 5.0,  width: cell.viewFirst.frame.size.width,  height: 69)

        if(indexPath.row==0)
        {
            let varGetImage = muarrayClubDetail.object(at: 0)
            print("************************************",varGetImage)
            
            if muarrayClubDetail.object(at: 0) as! String == ""
            {
              //  cell.profilePic.image = UIImage(named: "profile_pic")
                cell.profilePic.image = UIImage(named: "logdfdssdfsdo")
                  varRowHeight=1.0
            }
            else
            {
                let varGetImageUrl:String=muarrayClubDetail.object(at: 0) as! String
                print(varGetImageUrl)
                let url = URL(string: varGetImage as! String)
                /*
                KingfisherManager.sharedManager.retrieveImageWithURL(url!, optionsInfo: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, imageURL) -> () in
                    print(image)
                    cell.profilePic.image = image
                })
                */
                //let varGetImageUrl:String=muarrayClubDetail.object(at: 0) as! String
                let ImageProfilePic:String = (varGetImage as AnyObject).replacingOccurrences(of: " ", with: "%20")
                let checkedUrl = URL(string: ImageProfilePic)
                print("checkedUrl:::::  \(checkedUrl)")
                cell.profilePic.sd_setImage(with: checkedUrl)
                self.fullImage = (varGetImage as AnyObject).replacingOccurrences(of: " ", with: "%20")
                
                cell.profilePic.isUserInteractionEnabled = true
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
                 cell.profilePic.addGestureRecognizer(tapGesture)
                
                varRowHeight=300.0
            }
            cell.viewFirst.isHidden=false
            cell.textviewDescription.isHidden=true
            cell.viewSecond.isHidden=true
            cell.viewThird.isHidden=true
            
            
          
        }
        else  if(indexPath.row==1)
        {
            
            cell.textviewDescription.text=muarrayClubDetail.object(at: 1)as! String
            //--------
            //((self.muarrayFindAClubEventList[0].objectForKey("eventTitle")!) as! String)+((self.muarrayFindAClubEventList[0].objectForKey("eventDesc")!) as! String)
            var varGetTitle = ""
            var varGetDesc = ""
            if isfiltered {
                varGetTitle = titles
                varGetDesc = desc
            } else {
                varGetTitle=(muarrayFindAClubEventList[senderTag] as AnyObject).object(forKey: "eventTitle") as! String
                varGetDesc=(muarrayFindAClubEventList[senderTag] as AnyObject).object(forKey: "eventDesc") as! String
            }

            
//            var attributedStringss:NSAttributedString=NSAttributedString()
//            attributedStringss=functionForSetColorInString(varGetTitle, stringName: varGetDesc)
//            
//            cell.textviewDescription.attributedText=attributedStringss

            let attributedString = NSMutableAttributedString(string: varGetTitle, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
            attributedString.append(NSAttributedString(string: "\n\n\(varGetDesc)"))
            cell.textviewDescription.attributedText = attributedString
            
            
            
            
            let fixedWidth = cell.textviewDescription.frame.size.width
            cell.textviewDescription.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            let newSize = cell.textviewDescription.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            var newFrame = cell.textviewDescription.frame
            newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
            cell.textviewDescription.frame = newFrame;
            varRowHeight=newSize.height+5
            cell.viewFirst.isHidden=true
            cell.textviewDescription.isHidden=false
            cell.viewSecond.isHidden=true
            cell.viewThird.isHidden=true
           //varRowHeight=varRowHeight
        }
        else  if(indexPath.row==2)
        {
            cell.buttonAddress.setTitle(muarrayClubDetail.object(at: 2)as! String,  for: UIControl.State.normal)
            varRowHeight=75.0
            cell.viewFirst.isHidden=true
            cell.textviewDescription.isHidden=true
            cell.viewSecond.isHidden=false
            cell.viewThird.isHidden=true
        }
        else  if(indexPath.row==3)
        {
             cell.buttonTime.setTitle(muarrayClubDetail.object(at: 3)as! String,  for: UIControl.State.normal)
            varRowHeight=100.0
            cell.viewFirst.isHidden=true
            cell.textviewDescription.isHidden=true
            cell.viewSecond.isHidden=true
            cell.viewThird.isHidden=false
        }
        cell.textviewDescription.isUserInteractionEnabled=false
        return cell
    }
    @objc func buttonTimeMainClicked(_ sender:UIButton)
    {
      print("1")
    }
    @objc func buttonAddressMainClicked(_ sender:UIButton)
    {
         print("2")
        print(sender.tag)
        print("map clicked !")
       // var varGetValueContaining=muarrayValue.objectAtIndex(sender.tag)as! String
       // let opbjMzxcapAddressViewController = self.storyboard!.instantiateViewControllerWithIdentifier("MazxcpAddressViewController") as! MapAddressViewController
        var varGetLat = ""
        var varGetLong = ""
        var address = ""
        if isfiltered {
            varGetLat = lat
            varGetLong = long
            address = venue
        } else {
            varGetLat=((muarrayFindAClubEventList[senderTag] as AnyObject).object(forKey: "venueLat"))as! String
            varGetLong=((muarrayFindAClubEventList[senderTag] as AnyObject).object(forKey: "venueLon"))as! String
            address = ((muarrayFindAClubEventList[senderTag] as AnyObject).object(forKey: "venue"))as! String
        }
        
        
        
        
        
       // opbjMcvbapAddressViewController.varLat=varGetLat
       // opbjMacvbpAddressViewController.varLong=varGetLong
        //opbjMacvbpAddressViewController.varGetAddress=(muarrayFindAClubEventList[senderTag].objectForKey("venue"))as! String //muarrayClubDetail.objectAtIndex(2)as! String
       // opbjMacvbpAddressViewController.varGetAddress=varGetValueContaining
      //  self.navigationController?.pushViewController(opbjMacvpAddressViewController, animated: true)
        
        
        
        
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                print("This is Error:------>")
                self.view.makeToast("Address is not valid", duration: 3, position: CSToastPositionCenter)
                if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!))
                {
//                    UIApplication.shared.openURL(URL(string:"comgooglemaps://?saddr=&daddr=\("InvaidAddress"),\("InvaidAddress")&directionsmode=driving")!)
                    
                    if UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://?saddr=&daddr=\("InvaidAddress"),\("InvaidAddress")&directionsmode=driving")!) {
                         UIApplication.shared.open(URL(string:"comgooglemaps://?saddr=&daddr=\("InvaidAddress"),\("InvaidAddress")&directionsmode=driving")!, options: [:]) { success in
                             if success {
                                 print("The URL was successfully opened.")
                             } else {
                                 print("Failed to open the URL.")
                             }
                         }
                     }
                }
                else
                {}
            }
            else
            {
                if let placemark = placemarks?.first {
                    let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                    //Working in Swift new versions.
                    if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!))
                    {
//                        UIApplication.shared.openURL(NSURL(string:
//                            "comgooglemaps://?saddr=&daddr=\(Float(coordinates.latitude)),\(Float(coordinates.longitude))&directionsmode=driving")! as URL)
                        
                        if UIApplication.shared.canOpenURL(NSURL(string:
                                                                    "comgooglemaps://?saddr=&daddr=\(Float(coordinates.latitude)),\(Float(coordinates.longitude))&directionsmode=driving")! as URL) {
                             UIApplication.shared.open(NSURL(string:
                                                                "comgooglemaps://?saddr=&daddr=\(Float(coordinates.latitude)),\(Float(coordinates.longitude))&directionsmode=driving")! as URL, options: [:]) { success in
                                 if success {
                                     print("The URL was successfully opened.")
                                 } else {
                                     print("Failed to open the URL.")
                                 }
                             }
                         }

                        
                    } else
                    {
                        let directionsURL = "https://maps.apple.com/?saddr=&daddr=\(Float(coordinates.latitude)),\(Float(coordinates.longitude))"
                        guard let url = URL(string: directionsURL) else {
                            return
                        }
                        if #available(iOS 10.0, *) {
//                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            
                            if UIApplication.shared.canOpenURL(url as URL) {
                                UIApplication.shared.open(url as URL, options: [:]) { success in
                                        if success {
                                            print("The URL was successfully opened.")
                                        } else {
                                            print("Failed to open the URL.")
                                        }
                                    }
                                }

                            
                        } else {
//                            UIApplication.shared.openURL(url)
                            
                            if UIApplication.shared.canOpenURL(url as URL) {
                                UIApplication.shared.open(url as URL, options: [:]) { success in
                                        if success {
                                            print("The URL was successfully opened.")
                                        } else {
                                            print("Failed to open the URL.")
                                        }
                                    }
                                }

                            
                        }
                        NSLog("Can't use com.google.maps://");
                    }
  
                }
            }
        })
    }
    
    
    
    
    
    
    
    
    
    
    
    func functionForGetEventDetails()
    {
        let completeURL = baseUrl+row_GetDistricCommunicationtEventList
        let parameterst = [
            "grpID": grpId
        ]
        print(parameterst)
        print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            
            print(response)
            var dictResponseData:NSDictionary=NSDictionary()
            dictResponseData = response as! NSDictionary
            print(dictResponseData)
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
            }
            else
            {
            if((dictResponseData.object(forKey: "TBPublicEventList")! as AnyObject).object(forKey: "status") as! String == "0")
            {
                for i in 0..<(((dictResponseData.value(forKey: "TBPublicEventList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "grpID")! as AnyObject).count
                {
                    
                    /*"eventID": "12",
                     "eventImg": "http://www.rosteronwheels.com/Documents/Event/Group2765/thumb/06062017033639PM.png",
                     "eventTitle": "purple purl",
                     "eventDesc": "Cross to red",
                     "eventDateTime": "12 Jun 2017 03:37 PM",
                     "goingCount": "0",
                     "maybeCount": "0",
                     "notgoingCount": "0",
                     "venue": "Jaipur",
                     "myResponse": "0",
                     "filterType": "3",
                     "grpID": "2765",
                     "grpAdminId": "51272",
                     "isRead": "0",
                     "venueLat": "26.8969949",
                     "venueLon": "75.8104871"
                     */
                    
                    let varEventID=((((dictResponseData.value(forKey: "TBPublicEventList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "eventID")! as AnyObject).object(at: i)) as! String
                    let varEventImg=((((dictResponseData.value(forKey: "TBPublicEventList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "eventImg")! as AnyObject).object(at: i)) as! String
                    let varEventTitle=(((dictResponseData.value(forKey: "TBPublicEventList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "eventTitle")! as AnyObject).object(at: i) as! String
                    let varEventDesc=((((dictResponseData.value(forKey: "TBPublicEventList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "eventDesc")! as AnyObject).object(at: i)) as! String
                    let varEventDateTime=((((dictResponseData.value(forKey: "TBPublicEventList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "eventDateTime")! as AnyObject).object(at: i)) as! String
                    let varGoingCount=(((dictResponseData.value(forKey: "TBPublicEventList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "goingCount")! as AnyObject).object(at: i) as! String
                    let varMaybeCount=(((dictResponseData.value(forKey: "TBPublicEventList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "maybeCount")! as AnyObject).object(at: i) as! String
                    let varNotgoingCount=((((dictResponseData.value(forKey: "TBPublicEventList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "notgoingCount")! as AnyObject).object(at: i)) as! String
                    let varVenue=((((dictResponseData.value(forKey: "TBPublicEventList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "venue")! as AnyObject).object(at: i)) as! String
                    let varMyResponse=(((dictResponseData.value(forKey: "TBPublicEventList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "myResponse")! as AnyObject).object(at: i) as! String
                    let varFilterType=((((dictResponseData.value(forKey: "TBPublicEventList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "filterType")! as AnyObject).object(at: i)) as! String
                    let varGrpID=((((dictResponseData.value(forKey: "TBPublicEventList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "grpID")! as AnyObject).object(at: i)) as! String
                    let varGrpAdminId=((((dictResponseData.value(forKey: "TBPublicEventList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "grpAdminId")! as AnyObject).object(at: i)) as! String
                    let varIsRead=(((dictResponseData.value(forKey: "TBPublicEventList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "isRead")! as AnyObject).object(at: i) as! String
                    let varVenueLat=((((dictResponseData.value(forKey: "TBPublicEventList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "venueLat")! as AnyObject).object(at: i)) as! String
                    let varVenueLon=((((dictResponseData.value(forKey: "TBPublicEventList")! as AnyObject).value(forKey: "Result")! as AnyObject).value(forKey: "venueLon")! as AnyObject).object(at: i)) as! String
                    
                    
                    
                    
                    self.muarrayFindAClubEventList.add(varEventImg)
                    self.muarrayFindAClubEventList.add(varEventDesc)
                    self.muarrayFindAClubEventList.add(varVenue)
                    self.muarrayFindAClubEventList.add(varEventDateTime)
                    
//                    
//                    self.muDictionaryForEventDetails = ["eventID": varEventID,
//                        "eventImg": varEventImg,
//                        "eventTitle": varEventTitle,
//                        "eventDesc": varEventDesc,
//                        "eventDateTime": varEventDateTime,
//                        "goingCount": varGoingCount,
//                        "maybeCount": varMaybeCount,
//                        "notgoingCount": varNotgoingCount,
//                        "venue": varVenue,
//                        "myResponse": varMyResponse,
//                        "filterType": varFilterType,
//                        "grpID": varGrpID,
//                        "grpAdminId": varGrpAdminId,
//                        "isRead": varIsRead,
//                        "venueLat": varVenueLat,
//                        "venueLon": varVenueLon]
//                    
//                    
//                    
//                    self.muarrayClubDetail.addObject(self.muDictionaryForEventDetails)
                }
                //self.DeleteDataInlocal()
               // self.SaveDataInlocal(self.muarrayEventsDetailSendToNextScreen)
                self.tableviewClubEventDetails.reloadData()
            }
            SVProgressHUD.dismiss()
            }
        })
    }
}
