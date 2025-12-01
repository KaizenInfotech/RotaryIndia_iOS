//
//  SimpleCustomView.swift
//  CustomXIBSwift
//
//  Created by Karthik Prabhu Alagu on 06/08/15.
//  Copyright © 2015 KPALAGU. All rights reserved.
//


import UIKit



@IBDesignable class SimpleCustomView:UIView
{
    @IBOutlet weak var buttonOpticity: UIButton!
    @IBOutlet weak var viewForDPView: UIView!
    var view:UIView!;
    
    @IBOutlet weak var lblTitle: UILabel!
    
    var  dateTimeDisplay:String = ""
    var  dateAndTimeDisplay:String = ""
    let timeFormatter = Foundation.DateFormatter()
    let DateFormatter = Foundation.DateFormatter()
    var getValueForSelectPkg: String = ""
    var currentdate: String = ""
    var varGetTime24Hours: String = ""
    var varGetValuePassFromVCtoXib: String = ""

    
    @IBOutlet weak var dateTimePickerController: UIDatePicker!
    
    
    @IBInspectable var lblTitleText : String?
        {
        get{
            return lblTitle.text;
        }
        set(lblTitleText)
        {
            lblTitle.text = lblTitleText!;
            
            if(lblTitle.text == "Date")
            {
                setDateAndTimeFull()
            }
            else if (lblTitle.text == "Time")
            {
                setDateAndTime()
                
            }
            else if(lblTitle.text == "Time12Hours")
            {
                setTime12HoursWithAMPM()
            }
            else if(lblTitle.text == "DateAndTime")
            {
                SetDateAndTimeOnly()
            }
        }
    }

//    func getDataFromAnotherVC(dataString : String)
//    {
//        // dataString from SecondVC
//       varGetValuePassFromVCtoXib = dataString
//    }

    override init(frame: CGRect)
    {
        super.init(frame: frame)
        loadViewFromNib ()
        if(lblTitle.text == "Date")
        {
            setDateAndTimeFull()
        }
        else if (lblTitle.text == "Time")
        {
            setDateAndTime()

        }
        else if(lblTitle.text == "Time12Hours")
        {
            setTime12HoursWithAMPM()
        }
        else if(lblTitle.text == "DateAndTime")
        {
            SetDateAndTimeOnly()
        }
       
        
        //setDateAndTimeFull()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        loadViewFromNib ()
        if(lblTitle.text == "Date")
        {
            setDateAndTimeFull()
        }
        else if (lblTitle.text == "Time")
        {
            setDateAndTime()
            
        }
        else if(lblTitle.text == "Time12Hours")
        {
            setTime12HoursWithAMPM()
        }
        else if(lblTitle.text == "DateAndTime")
        {
            SetDateAndTimeOnly()
        }
    }
    //MARK:- Function
    func loadViewFromNib()
    {
       
        let bundle = Bundle(for: type(of: self))
        //        let bundle = NSBundle(forClass: self.dynamicType)  //Deprecated auto DPK
 
        let nib = UINib(nibName: "SimpleCustomView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        viewForDPView.center = view.center
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.alpha = 1
        viewForDPView.alpha = 1
        self.addSubview(view);

    }
    
    //MARK:- Time 12 Hours Formate
    func setTime12HoursWithAMPM()
    {
        dateTimePickerController.datePickerMode = UIDatePicker.Mode.time
        dateTimePickerController.setStyle()
       // dateTimePickerController.locale = NSLocale(localeIdentifier: "en_GB")
        dateTimePickerController.minuteInterval = 1
        let date = Foundation.Date()
        // let currentDate: NSDate = NSDate()
        let formatter = Foundation.DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        currentdate = formatter.string(from: date)
        //only time show
        timeFormatter.timeStyle = Foundation.DateFormatter.Style.short
        dateTimeDisplay = timeFormatter.string(from: dateTimePickerController.date)
        print(dateTimeDisplay)
    }
    
    //Time in 24 Hours WithOUT AM PM
    func setDateAndTime()
    {
        dateTimePickerController.datePickerMode = UIDatePicker.Mode.time
        dateTimePickerController.setStyle()
        dateTimePickerController.locale = Locale(identifier: "en_GB")
        dateTimePickerController.minuteInterval = 5
        let date = Foundation.Date()
        // let currentDate: NSDate = NSDate()
        let formatter = Foundation.DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        currentdate = formatter.string(from: date)
        //only time show
        timeFormatter.timeStyle = Foundation.DateFormatter.Style.short
        dateTimeDisplay = timeFormatter.string(from: dateTimePickerController.date)
        print(dateTimeDisplay)
        /*------------------------------------------*/
        let dateAsString = dateTimeDisplay
        let dateFormatterr = Foundation.DateFormatter()
        dateFormatterr.dateFormat = "h:mm a"
        let dater = dateFormatterr.date(from: dateAsString)
        print(dater)
        dateFormatterr.dateFormat = "HH:mm a"
        let date24 = dateFormatterr.string(from: dater!)
        //Remove AM PM For 24 Hours Formate
        var arraySplitStartTimes = date24.components(separatedBy: " ")
        print(arraySplitStartTimes)
        dateTimeDisplay = arraySplitStartTimes[0]
        print(dateTimeDisplay)

    }
    
    //Only Date
    func setDateAndTimeFull()
    {
        dateTimePickerController.datePickerMode = UIDatePicker.Mode.date
        dateTimePickerController.setStyle()
       // dateTimePickerController.locale = NSLocale(localeIdentifier: "en_GB")
       // dateTimePickerController.minuteInterval = 15
        let date = Foundation.Date()
        // let currentDate: NSDate = NSDate()
        let formatter = Foundation.DateFormatter()
        formatter.dateFormat = "dd/MM/yyy"
        currentdate = formatter.string(from: date)
        //full date and time show
        DateFormatter.dateStyle = Foundation.DateFormatter.Style.short
        dateTimeDisplay = DateFormatter.string(from: dateTimePickerController.date) + " " + timeFormatter.string(from: dateTimePickerController.date)
       // print(dateTimeDisplay)
        //print(currentdate)
        
        
        
        dateTimePickerController.datePickerMode = UIDatePicker.Mode.date
        dateTimePickerController.setStyle()
        let dateFormatter = Foundation.DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let selectedDate = dateFormatter.string(from: dateTimePickerController.date)
        dateTimeDisplay=selectedDate
        print(selectedDate)
    }
    
    //Only DateAndTime
    func SetDateAndTimeOnly()
    {
//        //dateTimePickerController.datePickerMode = UIDatePicker.Mode.DateAndTime
//        // dateTimePickerController.locale = NSLocale(localeIdentifier: "en_GB")
//        // dateTimePickerController.minuteInterval = 15
//        let date = NSDate()
////        // let currentDate: NSDate = NSDate()
////        let formatter = NSDateFormatter()
////        formatter.dateFormat = "MM-dd-yyyy"
////        currentdate = formatter.stringFromDate(date)
////        //only time show
////        timeFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
////        dateTimeDisplay = timeFormatter.stringFromDate(dateTimePickerController.date)
////       
//        
//        let dateFormatter = NSDateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm"
//        let strDate = dateFormatter.stringFromDate(dateTimePickerController.date)
//        print(strDate)
//        dateAndTimeDisplay = strDate
//        print(dateAndTimeDisplay)
        
      
        dateTimePickerController.datePickerMode = UIDatePicker.Mode.dateAndTime
        // dateTimePickerController.locale = NSLocale(localeIdentifier: "en_GB")
        // dateTimePickerController.minuteInterval = 15
        let date = Foundation.Date()
        // let currentDate: NSDate = NSDate()
        let formatter = Foundation.DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm a"
        currentdate = formatter.string(from: date)
        print(currentdate)
        //only time show
        timeFormatter.timeStyle = Foundation.DateFormatter.Style.short
        timeFormatter.dateFormat = "hh:mm a"
        dateTimeDisplay = timeFormatter.string(from: dateTimePickerController.date)
        dateTimePickerController.setStyle()
        //full date and time show
        DateFormatter.dateStyle = Foundation.DateFormatter.Style.short
        DateFormatter.dateFormat = "yyyy-MM-dd"
        dateAndTimeDisplay = DateFormatter.string(from: dateTimePickerController.date) + " " + timeFormatter.string(from: dateTimePickerController.date)
        print(dateAndTimeDisplay)
        
        
    }
    

    @IBAction func buttonCancelClickEvent(_ sender: AnyObject) {
        let abc = "ClosePicker"
        print(abc)
        let myDict: [String:AnyObject] = [
            "varUserFullNameFB":  abc as AnyObject
        ]
        NotificationCenter.default.post(name: Notification.Name(rawValue: "NotificationIdentifierForGettingValueForPickerCloseWithpoutValueSelect"), object: nil, userInfo: myDict)
    }
    
    
    
    
    @IBAction func buttonOpticityClickEvent(_ sender: AnyObject)
    {
        let abc = "ClosePicker"
        print(abc)
        let myDict: [String:AnyObject] = [
            "varUserFullNameFB":  abc as AnyObject
        ]
        NotificationCenter.default.post(name: Notification.Name(rawValue: "NotificationIdentifierForGettingValueForPickerCloseWithpoutValueSelect"), object: nil, userInfo: myDict)
    }
    
    //MARK:- Button Action
    @IBAction func buttonGoToParentClickEvent(_ sender: AnyObject)
    {
        if(lblTitle.text == "Date")
        {
            setDateAndTimeFull()
        }
        else if (lblTitle.text == "Time")
        {
            setDateAndTime()
            
        }
        else if(lblTitle.text == "Time12Hours")
        {
            setTime12HoursWithAMPM()
        }
        else if(lblTitle.text == "DateAndTime")
        {
            SetDateAndTimeOnly()
            
            dateTimeDisplay = dateAndTimeDisplay
        }
        
        let abc = dateTimeDisplay
        print(abc)
        let myDict: [String:AnyObject] = [
            "varUserFullNameFB":  abc as AnyObject
        ]
        NotificationCenter.default.post(name: Notification.Name(rawValue: "NotificationIdentifierForGettingValue"), object: nil, userInfo: myDict)
    }

    
}
