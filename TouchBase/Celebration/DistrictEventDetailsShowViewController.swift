//
//  DistrictEventDetailsShowViewController.swift
//  TouchBase
//
//  Created by rajendra on 17/08/17.
//  Copyright © 2017 Parag. All rights reserved.
//

import UIKit
import SVProgressHUD
class DistrictEventDetailsShowViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableDistrictEventDetailsShow: UITableView!
    var eventID:String!=""

  
    var muarrayFindAClubEventList:NSMutableArray=NSMutableArray()
    var muDictionaryForEventDetails:NSMutableDictionary=NSMutableDictionary()
    var  muarrayClubDetail:NSMutableArray=NSMutableArray()
    var muarrayClubDetailsDistrict:NSMutableArray=NSMutableArray()
    
    var muarrayLatLong:NSMutableArray=NSMutableArray()
    var senderTag:Int=0
    var varRowHeight:CGFloat!=0.0
    
    
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
        // print(varGetTitleDescription)
        
        self.functionForGetEventDetails(eventID)
        
//        var varGetLat:String!=(muarrayFindAClubEventList[0].objectForKey("venueLat"))as! String
//        var varGetLong:String!=(muarrayFindAClubEventList[0].objectForKey("venueLon"))as! String
//        if(varGetLat=="")
//        {
//            varGetLat = "21.228124"
//        }
//        else
//        {
//        }
//        if(varGetLong=="")
//        {
//            varGetLong = "72.833770"
//        }
//        else
//        {
//        }
//        var placemarks:String! = getAddressFromLatLon(varGetLat, withLongitude: varGetLong)
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
                    
                    print(self.muarrayLatLong)
                    
                    
                    let varGetTitleDescription:String!=((self.muarrayLatLong[0] as! String)+((self.muarrayLatLong[1]) as! String))
                    
                    
                    print(varGetTitleDescription)
//                    var varGetLat:String!=(self.muarrayFindAClubEventList[0].objectForKey("venueLat"))as! String
//                    var varGetLong:String!=(self.muarrayFindAClubEventList[0].objectForKey("venueLon"))as! String
                    
//                    //need to get address from lat an dlong
//                    var varGetTimeandDate=(self.muarrayFindAClubEventList[0].objectForKey("eventDateTime"))
//                    
//                    self.muarrayClubDetail.addObject(self.muarrayFindAClubEventList[0].objectForKey("eventImg")!)
//                    self.muarrayClubDetail.addObject(varGetTitleDescription)
//                    self.muarrayClubDetail.addObject((self.muarrayFindAClubEventList[0].objectForKey("venue"))as! String )
//                    self.muarrayClubDetail.addObject(varGetTimeandDate!)
                    
                    self.tableDistrictEventDetailsShow.reloadData()
                    
                    
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
        buttonleft.addTarget(self, action: #selector(DistrictEventDetailsShowViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        //let add = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(DistrictEventDetailsShowViewController.AddEventAction))
       // add.tintColor = UIColor(red: 0/255.0, green: 174/255.0, blue: 239/255.0, alpha: 1.0)
        let mainMemberID = UserDefaults.standard.string(forKey: "isAdmin")//isAdmin
    }
    
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
 
//
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
//    {
//        return muarrayClubDetailsDistrict.count
//    }
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int
//    {
//        return 1
//    }
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
//    {
//        return varRowHeight
//    }
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
//    {
//        let cell =  tableView.dequeueReusableCellWithIdentifier("Cell") as! ClubEventDetailsShowTableViewCell
//        
//     cell.buttonAddressMain.setTitle((muarrayClubDetailsDistrict.objectAtIndex(indexPath.row).objectForKey("eventTitle"))as! String, forState: .Normal)
//        return cell
//    }
    
    //MARK:- Server Calling
    //Event Details
    func functionForGetEventDetails(_ grpId:String)
    {
        let completeURL =  baseUrl+rowDistrictEventDetailsFromCalendar
        let parameterst = [
            "eventID": grpId
        ]
        print(parameterst)
        print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
            }
            else
            {
            print(response)
            var dictResponseData:NSDictionary=NSDictionary()
            dictResponseData = response as! NSDictionary
            print(dictResponseData)
            if((dictResponseData.object(forKey: "TBPublicEventList")! as AnyObject).object(forKey: "status") as! String == "0")
            {
                
                let varEventID=(((dictResponseData.object(forKey: "TBPublicEventList")! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "eventID")) as! String
                let varEventImg=(((dictResponseData.object(forKey: "TBPublicEventList")! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "eventImg")) as! String
                let varEventTitle=((dictResponseData.object(forKey: "TBPublicEventList")! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "eventTitle") as! String
                let varEventDesc=(((dictResponseData.object(forKey: "TBPublicEventList")! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "eventDesc")) as! String
                let varEventDateTime=(((dictResponseData.object(forKey: "TBPublicEventList")! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "eventDateTime")) as! String
                let varGoingCount=((dictResponseData.object(forKey: "TBPublicEventList")! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "goingCount") as! String
                let varMaybeCount=((dictResponseData.object(forKey: "TBPublicEventList")! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "maybeCount") as! String
                let varNotgoingCount=(((dictResponseData.object(forKey: "TBPublicEventList")! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "notgoingCount")) as! String
                let varVenue=(((dictResponseData.object(forKey: "TBPublicEventList")! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "venue")) as! String
                let varMyResponse=((dictResponseData.object(forKey: "TBPublicEventList")! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "myResponse") as! String
                let varFilterType=(((dictResponseData.object(forKey: "TBPublicEventList")! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "filterType")) as! String
                let varGrpID=(((dictResponseData.object(forKey: "TBPublicEventList")! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "grpID")) as! String
                let varGrpAdminId=(((dictResponseData.object(forKey: "TBPublicEventList")! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "grpAdminId")) as! String
                let varIsRead=((dictResponseData.object(forKey: "TBPublicEventList")! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "isRead") as! String
                var varVenueLat=(((dictResponseData.object(forKey: "TBPublicEventList")! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "venueLat")) as! String
                var varVenueLon=(((dictResponseData.object(forKey: "TBPublicEventList")! as AnyObject).object(forKey: "Result")! as AnyObject).object(forKey: "venueLon")) as! String
         
                
                
                
                
                self.muarrayClubDetail.add(varEventImg)
                self.muarrayClubDetail.add(varEventTitle)
                self.muarrayClubDetail.add(varVenue)
                self.muarrayClubDetail.add(varEventDateTime)
                
                self.muarrayFindAClubEventList.add(varEventTitle)
                self.muarrayFindAClubEventList.add(varEventDesc)

                self.muarrayLatLong.add(varVenueLat)
                self.muarrayLatLong.add(varVenueLon)
                
                        if(varVenueLat=="" || varVenueLat=="venueLat")
                        {
                            //varVenueLat = "21.228124"
                        }
                        else
                        {
                        }
                        if(varVenueLon=="" || varVenueLon=="venueLon")
                        {
                            //varVenueLon = "72.833770"
                        }
                        else
                        {
                        }
                
                if((varVenueLat=="" || varVenueLat=="venueLat") && (varVenueLon=="" || varVenueLon=="venueLon"))
                {
                    
                }
                else
                {
                    
                   // NSUserDefaults.standardUserDefaults().setValue(varVenueLat, forKey: "session_setGetLatitude")
                   // NSUserDefaults.standardUserDefaults().synchronize()
                    //2.
                    //NSUserDefaults.standardUserDefaults().setValue(varVenueLon, forKey: "session_setGetLatitude")
                   // NSUserDefaults.standardUserDefaults().synchronize()
                    
                  var placemarks:String! = self.getAddressFromLatLon(varVenueLat, withLongitude: varVenueLon)
                }
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
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
//                    self.muarrayClubDetailsDistrict.addObject(self.muDictionaryForEventDetails)
//                    self.muarrayClubDetail=self.muarrayClubDetailsDistrict
                   self.tableDistrictEventDetailsShow.reloadData()
            }
        }
            SVProgressHUD.dismiss()
        })
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
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
                /////-----------
        
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
                cell.profilePic.image = UIImage(named: "profile_pic")
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
                
                
                ////
                
               
                let ImageProfilePic:String = (varGetImage as AnyObject).replacingOccurrences(of: " ", with: "%20")
                    let checkedUrl = URL(string: ImageProfilePic)
                    cell.profilePic.sd_setImage(with: checkedUrl)
                
                ////
                
                
                
                
                
                
                
            }
            cell.viewFirst.isHidden=false
            cell.textviewDescription.isHidden=true
            cell.viewSecond.isHidden=true
            cell.viewThird.isHidden=true
            
            
            varRowHeight=335.0
        }
        else  if(indexPath.row==1)
        {
            
            cell.textviewDescription.text=muarrayClubDetail.object(at: 1)as! String
            //--------
            //((self.muarrayFindAClubEventList[0].objectForKey("eventTitle")!) as! String)+((self.muarrayFindAClubEventList[0].objectForKey("eventDesc")!) as! String)
            
            
            var varGetTitle=muarrayFindAClubEventList.object(at: 0) as! String
            var varGetDesc=muarrayFindAClubEventList.object(at: 1)  as! String
            
            
            var attributedStringss:NSAttributedString=NSAttributedString()
            attributedStringss=functionForSetColorInString(varGetTitle, stringName: varGetDesc)
            
            cell.textviewDescription.attributedText=attributedStringss
            
            
            
            
            
            
            
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
    func buttonTimeMainClicked(_ sender:UIButton)
    {
        print("1")
    }
    func buttonAddressMainClicked(_ sender:UIButton)
    {
        print("2")
        print(sender.tag)
        print("map clicked !")
        // var varGetValueContaining=muarrayValue.objectAtIndex(sender.tag)as! String
        let opbjMapAddressViewController = self.storyboard!.instantiateViewController(withIdentifier: "MapAddressViewController") as! MapAddressViewController
       
        
        
        print(muarrayClubDetail.object(at: 2)as! String)
        
        // opbjMapAddressViewController.varLat=varGetLat
        // opbjMapAddressViewController.varLong=varGetLong
        opbjMapAddressViewController.varGetAddress=muarrayClubDetail.object(at: 2)as! String //muarrayClubDetail.objectAtIndex(2)as! String
        // opbjMapAddressViewController.varGetAddress=varGetValueContaining
        self.navigationController?.pushViewController(opbjMapAddressViewController, animated: true)
        
        
        
    }
    

    
    
    
    
}
