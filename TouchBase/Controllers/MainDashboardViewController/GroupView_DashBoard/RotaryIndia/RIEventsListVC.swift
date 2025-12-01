//
//  RIEventsListVC.swift
//  TouchBase
//
//  Created by IOS on 22/06/20.
//  Copyright © 2020 Parag. All rights reserved.
//

import UIKit
import EventKit

class EventCell:UITableViewCell
{
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblStatus: UILabel!

    @IBOutlet weak var btnLocation: UIButton!
    @IBOutlet weak var btnReminder: UIButton!
    
}

class RIEventsListVC: UIViewController,UITableViewDataSource,UITableViewDelegate,RIServerDelegate,UISearchBarDelegate
{
    
    @IBOutlet weak var msgLabel: UILabel!
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var reminderView: UIView!
    @IBOutlet var eventNameReminderLabel: UILabel!
    @IBOutlet var ReminderPickerView: UIDatePicker!

    let commonClass:CommonRIClass=CommonRIClass()
    var muarrayEventList:NSMutableArray=NSMutableArray()
    var filteredArray:NSArray=NSArray()
    let bounds = UIScreen.main.bounds
    var Date : String!
    var Time : String!
    var appDelegate : AppDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        ReminderPickerView.setStyle()
        searchBar.delegate=self
        commonClass.setNavigationBar(moduleName: "Events", uiVC: self)
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        commonClass.riServerDelegate=self
        listTableView.isHidden=true
        commonClass.getModuleListFromServer(fromYear: "",toYear: "")
    }
    override func viewWillAppear(_ animated: Bool) {
     commonClass.setNavigationBar(moduleName: "Events", uiVC: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:EventCell=tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCell
        cell.selectionStyle = .none
        if let row_data = filteredArray.object(at: indexPath.row) as? NSDictionary
        {
          cell.lblTitle.text=(row_data.object(forKey: "eventTitle") as! String)
          let myDateString=row_data.object(forKey: "eventDateTime") as? String
            let myStringArr=myDateString!.components(separatedBy: " ")
            if(myStringArr.count > 0){
                       cell.lblDate.text = myStringArr[0]
                       cell.lblMonth.text = myStringArr[1].uppercased()
                       cell.lblTime.text = String(format: "%@ %@",myStringArr[3],myStringArr[4])
                
            }
            let isRead = row_data.object(forKey: "isRead") as? String
            if(isRead == "No"){
                
                cell.lblTitle.textColor=UIColor(red: 25/255.0, green: 118/255.0, blue: 210/255.0, alpha: 1.0)
                
            }else{
                
                cell.lblTitle.textColor=UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
                
            }
            let filterType = row_data.object(forKey: "filterType") as? String
            
            if(filterType=="1"){
                cell.lblStatus.text=String(format: "Published")
            }else if(filterType=="2"){
                cell.lblStatus.text=String(format: "Scheduled")
            }else if(filterType=="3"){
                cell.lblStatus.text=String(format: "Expired")
            }
            
            if let location = row_data.object(forKey: "venue") as? String
            {
              cell.lblLocation.text = location
            }
            cell.btnReminder.addTarget(self, action: #selector(setReminderAction(_:)), for: UIControl.Event.touchUpInside)
            cell.btnReminder.tag = indexPath.row
            cell.btnLocation.addTarget(self, action: #selector(btnLocationClick(_:)), for: UIControl.Event.touchUpInside)
            cell.btnLocation.tag = indexPath.row

         }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //eventID
        if let row_data = filteredArray.object(at: indexPath.row) as? NSDictionary
        {
        if searchBar.isFirstResponder
        {
            searchBar.resignFirstResponder()
        }
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "RIEventsDetailController") as! RIEventsDetailController
        secondViewController.grpId = "-1"
            secondViewController.eventID = row_data.object(forKey: "eventID") as! String as NSString
        secondViewController.varIsRSVPEnableorDisable=0
        secondViewController.isCategory="1"
        self.navigationController?.pushViewController(secondViewController, animated: true)
        }
    }
    
     func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Comes in search bar event")
        if searchText.count>0
        {
            let resultPredicate = NSPredicate(format: "eventTitle contains[c] %@", searchText)
            self.filteredArray = self.muarrayEventList.filtered(using: resultPredicate) as NSArray
        }
        else
        {
            filteredArray = muarrayEventList
        }
        
        if filteredArray.count>0
                  {
                      listTableView.isHidden=false
                      msgLabel.isHidden=true
                  }
                  else
                  {
                      msgLabel.isHidden=false
                      msgLabel.text="No results"
                  }
        listTableView.reloadData()

    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func OnReceiveEventResult(EvenResult: NSDictionary) {
        print("Comes in Event Controller View")
        if let EventListDetailResult = EvenResult.object(forKey: "EventListDetailResult") as? NSDictionary
        {
            if EventListDetailResult.object(forKey: "status") as! String == "0"
            {
                if let EventsListResult = EventListDetailResult.object(forKey: "EventsListResult") as? NSArray
                {
                    
                    for i in 0 ..< EventsListResult.count
                    {
                        if let  mainDictionary = EventsListResult.object(at: i) as? NSDictionary
                        {
                            if let dictionary = mainDictionary.object(forKey: "EventList") as? NSDictionary
                            {
                                muarrayEventList.add(dictionary)
                            }
                        }
                    }

                    if muarrayEventList.count>0
                    {
                        self.filteredArray = muarrayEventList.mutableCopy() as! NSArray
                        self.msgLabel.isHidden=true
                        self.listTableView.isHidden=false
                        self.listTableView.reloadData()
                    }
                    else
                    {
                        self.msgLabel.text="No results"
                        self.msgLabel.isHidden=false
                        self.listTableView.isHidden=true
                    }
                }
                else
                {
                    self.msgLabel.text="Could not connect to server"
                }
            }
            else
            {
                if let message = EventListDetailResult.object(forKey: "message") as? String{
                    if message.contains("Record not found")
                    {self.msgLabel.text="No results"}else{self.msgLabel.text=message}
                }
                else
                {
                self.msgLabel.text="Could not connect to server"
                }
            }
        }
    }
    
       
    @objc  func btnLocationClick(_ sender:UIButton){
           
           if let dict = muarrayEventList.object(at: sender.tag) as? NSDictionary
           {
               if let vname = dict.object(forKey: "venue") as? String
               {
                   let address = vname
                   let geocoder = CLGeocoder()
                   geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
                       if((error) != nil){
                           print("This is Error:------>")
                           self.view.makeToast("Address is not valid", duration: 3, position: CSToastPositionCenter)
                           if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!))
                           {
//                               UIApplication.shared.openURL(URL(string:"comgooglemaps://?saddr=&daddr=\("InvaidAddress"),\("InvaidAddress")&directionsmode=driving")!)
                               
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
                               if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!))
                               {
//                                   UIApplication.shared.openURL(NSURL(string:
//                                       "comgooglemaps://?saddr=&daddr=\(Float(coordinates.latitude)),\(Float(coordinates.longitude))&directionsmode=driving")! as URL)
                                   
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
                                   
                                   
                               }
                               else
                               {
                                   let directionsURL = "http://maps.apple.com/?saddr=&daddr=\(Float(coordinates.latitude)),\(Float(coordinates.longitude))"
                                   guard let url = URL(string: directionsURL) else {
                                       return
                                   }
                                   if #available(iOS 10.0, *) {
                                       UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                   } else {
//                                       UIApplication.shared.openURL(url)
                                       
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
                                   NSLog("Can't use comgooglemaps://");
                               }
                           }
                       }
                   })
               }
           }
       }
    
    //MARK: - Extra Reminder methods

    @objc func dateValueChanged(_ sender:UIDatePicker)
    {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:00"
        let strDate = dateFormatter.string(from: sender.date)
        
        let strSplit = strDate.characters.split(separator: " ")
        Date = String(strSplit.first!)
        Time = String(strSplit.last!)
    }
    
    @objc func setReminderAction(_ sender:UIButton)
    {
        
        reminderView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        self.view .addSubview(reminderView)
        
        
        ReminderPickerView.addTarget(self, action: #selector(dateValueChanged(_:)), for: UIControl.Event.valueChanged)

        let grp = muarrayEventList.object(at: sender.tag) as! NSDictionary
        eventNameReminderLabel.text = grp.object(forKey: "eventTitle") as? String

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:00"
        let strDate = dateFormatter.string(from: ReminderPickerView.date)
        
        let strSplit = strDate.characters.split(separator: " ")
        let Date = String(strSplit.first!)
        let time = String(strSplit.last!)
        
        print(Date)
        print(time)
        
        
        appDelegate = UIApplication.shared.delegate
            as? AppDelegate
        
        print(appDelegate)
        appDelegate!.eventStore = EKEventStore()   // changes by DPK  inner to outer
        if appDelegate!.eventStore == nil {
            
            appDelegate!.eventStore!.requestAccess(to: EKEntityType.reminder, completion:
                {(granted, error) in
                    if !granted
                    {
                        print("Access to store not granted")
                        print(error!.localizedDescription)
                    }
                    else
                    {
                        print("Access granted")
                    }
            })
        }
    }
    
    
    @IBAction func closeReminderView(_ sender: AnyObject)
     {
         reminderView.removeFromSuperview()
     }
     
     
     @IBAction func SaveReminder(_ sender: AnyObject)
     {
         if (appDelegate!.eventStore != nil)
         {
             self.createReminder()
             
         }
         else
         {
             self.createReminder()
         } // changes by DPK
     }
     
     func createReminder() {
         
         let reminder = EKReminder(eventStore: appDelegate!.eventStore!)
         reminder.title = String(format:"Reminder for %@",eventNameReminderLabel.text!)
         reminder.calendar = appDelegate!.eventStore!.defaultCalendarForNewReminders()
         let date = ReminderPickerView.date
         let alarm = EKAlarm(absoluteDate: date)
         
         self.view.makeToast("Reminder added successfully!", duration: 2, position: CSToastPositionCenter)
         reminder.addAlarm(alarm)
         
         do {
             try appDelegate!.eventStore!.save(reminder, commit: true)
             
         } catch
         {
             print(error)
         }
         
        let store = EKEventStore()
         store.requestAccess(to: .event) {(granted, error) in
             if !granted { return }
             let event = EKEvent(eventStore: store)
             event.title = String(format:"Reminder for %@",self.eventNameReminderLabel.text!)
             let date1 = self.ReminderPickerView.date
             event.startDate = date1 //today
             event.endDate = event.startDate.addingTimeInterval(60*60*24) //1 hour long meeting
             event.calendar = store.defaultCalendarForNewEvents
             do {
                 try store.save(event, span: .thisEvent, commit: true)
                 //self.savedEventId = event.eventIdentifier //save event id to access this particular event later
             } catch {
                 // Display error to user
             }
         }
         
         
         reminderView.removeFromSuperview()
         
     }

}
