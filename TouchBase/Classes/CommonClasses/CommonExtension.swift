
//
//  CommonExtension.swift
//  KaizenDemo
//
//  Created by Apple on 04/12/16.
//  Copyright © 2016 Apple. All rights reserved.
//
import UIKit
import Foundation
//1.MARK:- for creating view as a 3D
import SVProgressHUD

extension UIViewController {
    func displayNavBarActivity() {
        //let indicator = UIActivityIndicatorView(style: .white)
        let indicator = UIActivityIndicatorView(style: .white)
        indicator.startAnimating()
        let item = UIBarButtonItem(customView: indicator)
        
        self.navigationItem.leftBarButtonItem = item
    }
    
    func dismissNavBarActivity() {
        self.navigationItem.leftBarButtonItem = nil
    }
}

/*
 
 I would recommend extension like this.
 
 extension UIViewController {
 func displayNavBarActivity() {
 let indicator = UIActivityIndicatorView(activityIndicatorStyle: .White)
 indicator.startAnimating()
 let item = UIBarButtonItem(customView: indicator)
 
 self.navigationItem.leftBarButtonItem = item
 }
 
 func dismissNavBarActivity() {
 self.navigationItem.leftBarButtonItem = nil
 }
 }
 Call self.displayNavBarActivity() before api call, and call self.dismissNavBarActivity() after api call done.
 
 However, I want you to check networkActivityIndicatorVisible of UIApplication. Consider using this option.
 
 Specify YES if the app should show network activity and NO if it should not. The default value is NO. A spinning indicator in the status bar shows network activity. The app may explicitly hide or show this indicator.
 */


extension UIDatePicker
{
   func setStyle()
   {
    
    if #available(iOS 13.4, *) {
        self.preferredDatePickerStyle = UIDatePickerStyle.wheels
        //self.contentMode = .scaleToFill
    } else {
        // Fallback on earlier versions
    }
   }
}

extension UIImageView {
    public func imageFromServerURL(_ urlString: String) {
        
        URLSession.shared.dataTask(with: URL(string: urlString)!, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }}



extension CGRect
{
    var Iphone: (w: CGFloat, h: CGFloat)
    {
       UIScreen.main.bounds
        size.width
        size.height
        return (size.width, size.height)
        
    }
    var Iphone5And5s: (w: CGFloat, h: CGFloat)
    {
        return (320.0, 568.0)
    }
    var Iphone6And6s: (w: CGFloat, h: CGFloat)
    {
        return (375.0, 667.0)
    }
    var Iphone6Plus: (w: CGFloat, h: CGFloat)
    {
        return (414.0, 736.0)
    }
    var Iphone7And7s: (w: CGFloat, h: CGFloat)
    {
        return (414.0, 736.0)
    }
    var Iphone7Plus: (w: CGFloat, h: CGFloat)
    {
        return (414.0, 736.0)
    }
    
    var Ipad: (w: CGFloat, h: CGFloat)
    {
        return (768.0, 1024)
    }
}
extension CGFloat
{
    static func methodForGetCurrentDeviceWidthAndHeight() -> (CGFloat,CGFloat)
    {
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = (screenSize.width)
        let screenHeight = (screenSize.height)
        
        
        return (CGFloat(screenWidth),CGFloat(screenHeight))
    }
}
extension UIView
{
    func ThreeDView()
    {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 2
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 2
    }
    //         viewPopupNoAssociated.center = CGPointMake(view.frame.size.width / 2,250)
    func methodForViewInCenterOfScreen()
    {
        self.center = CGPoint(x: self.frame.size.width / 2,y: 250)
        
    }
    func messageShowToast(_ messageString:String)
    {
        self.makeToast(messageString, duration: 2, position: CSToastPositionCenter)
        
    }
    func navigationLeftButton()
    {
        
    }
    
}



extension UILabel
{
    func labelFontfamilyAndSize(_ name: String ) -> String {
        self.font =  UIFont(name:"Roboto", size: 15)
        return ""
    }
    func labelFontSizeChange(_ name: String, size:CGFloat) -> String {
        self.font =  UIFont(name:"Roboto",size:size )
        return ""
    }
}

extension UITextField
{
    func textfieldFontfamilyAndSize(_ name: String) -> String {
        self.font =  UIFont(name:"Roboto", size: 15)
        return ""
        
    }
    func textfieldFontfamilyAndSizeCustomFontSize(_ name: String,intFontSize:CGFloat) -> String {
        self.font =  UIFont(name:"Roboto", size: intFontSize)
        return ""
        
    }
}

extension UITextView
{
    func textViewFontfamilyAndSize(_ name: String) -> String {
        self.font =  UIFont(name:"Roboto", size: 15)
        return ""
    }
}


extension UIButton
{
    
    func addBottomBorder() {
        let border = CALayer()
        border.backgroundColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        self.layer.addSublayer(border)
    }
    
    
    func setButtonFullBorder()
    {
        self.titleLabel?.textColor = UIColor.black
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 1.0
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor//UIColor(red: 78.8/255.0, green: 78.8/255.0, blue: 78.8/255.0, alpha: 1.0).CGColor
//UIColor.blackColor().CGColor
        self.titleLabel?.textAlignment = NSTextAlignment.center
        
    }
    
    func setButtonBackGroundColor()
    {
        self.layer.cornerRadius = 5.0
        self.layer.borderColor = UIColor(red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
            .cgColor
        self.layer.borderWidth = 2
        self.tintColor = UIColor.white
        self.backgroundColor = UIColor(red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
        
        
    }
    
    
    func setButtonTopBorder()
    {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0).cgColor//UIColor.darkGrayColor().CGColor
        border.frame = CGRect(x: 0, y: 1, width:  self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        
        
    }
    
    func setButtonBottomBorderForLogin()
    {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0).cgColor//UIColor.darkGrayColor().CGColor
        border.frame = CGRect(x: 0, y: self.frame.size.height-1 , width:  self.frame.size.width+50, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        
        
    }

    
    func setButtonBottomBorder()
    {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0).cgColor//UIColor.darkGrayColor().CGColor
        border.frame = CGRect(x: 0, y: self.frame.size.height-1 , width:  self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        
        
    }
}

extension UILabel
{
    func LabelColor()
    {
        self.textColor =  UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1)
    }
}
extension UITextView
{
    func increaseFontSize ()
    {
        self.font =  UIFont(name: self.font!.fontName, size: self.frame.size.height / 4)!
    }
    
    
    func functionTextViewFullBorder()
    {
        // self.backgroundColor = UIColor.whiteColor()
        self.layer.cornerRadius = 1.0
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor//UIColor(red: 78.8/255.0, green: 78.8/255.0, blue: 78.8/255.0, alpha: 1.0).CGColor//UIColor.lightGrayColor().CGColor
        
    }
}
extension UITextField
{
    
    func functionForSetRemoveTextFieldAllBorder()
    {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.height - 1, width: self.frame.width, height: 0.0)
        bottomLine.backgroundColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0).cgColor //UIColor.lightGrayColor().CGColor
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
    }
    
    
    
    func functionTextFieldFullBorder()
    {
        //self.backgroundColor = UIColor.whiteColor()
        self.layer.cornerRadius = 1.0
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor// UIColor(red: 78.8/255.0, green: 78.8/255.0, blue: 78.8/255.0, alpha: 1.0).CGColor// UIColor.lightGrayColor().CGColor
        
    }
    func functionForCornerRadiusWithFullBorder()
    {
        self.layer.cornerRadius = 5.0
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    
    
    func functionForSetTextFieldBottomBorderForLogin()
    {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.height - 1, width: self.frame.width+50, height: 1.0)
        bottomLine.backgroundColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0).cgColor //UIColor.lightGrayColor().CGColor
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
    }
    
    func functionForSetTextFieldBottomBorder()
    {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.height - 1, width: self.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0).cgColor //UIColor.lightGrayColor().CGColor
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
    }
    func functionForSetTextFieldBottomBorderWhenEditing()
    {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.height - 1, width: self.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor(red: 250.0/255.0, green: 104.0/255.0, blue: 67.0/255.0, alpha: 1.0).cgColor
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
    }
    func functionForTextFieldAcceptOnlyDigit(_ stringGetEnteredText:String)->Bool
    {
        //let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
       // return stringGetEnteredText.rangeOfCharacter(from: invalidCharacters, options: [], range: stringGetEnteredText.characters.indices) == nil
   
    
       // let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
       /// let compSepByCharInSet = stringGetEnteredText.components(separatedBy: aSet)
        //let numberFiltered = compSepByCharInSet.joined(separator: "")
        
        //myy code
       // return  numberFiltered
        
        if let numRange = stringGetEnteredText.rangeOfCharacter(from: NSCharacterSet.letters) {
            return false
        } else {
            return true
        }
        
        
   // return true
    
    
    }
    func textFieldFullBorder()
    {
        //self.layer.borderColor=UIColor.darkGrayColor().CGColor
        //self.layer.borderWidth=0.0
        //self.layer.cornerRadius=1.0
        //  self.backgroundColor=UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0) //White
        self.rightViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        let image = UIImage(named: "downArrow_spaceRight")
        imageView.image = image
        self.rightView = imageView
    }
    func textFieldRemoveImage()
    {
        //self.layer.borderColor=UIColor.darkGrayColor().CGColor
        //self.layer.borderWidth=0.0
        //self.layer.cornerRadius=1.0
        //  self.backgroundColor=UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0) //White
        self.rightViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        let image = UIImage(named: "")
        imageView.image = image
        self.rightView = imageView
    }

}
extension UIImageView{
    
    func setImageFromURl(stringImageUrl url: String){
        
        if let url = URL(string: url) {
            if let data = try? Data(contentsOf: url) {
                self.image = UIImage(data: data)
            }
        }
    }
}
extension String {
    var isEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}"
        let emailTest  = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}
///-----
class commonClassFunction
{
    var appDelegate : AppDelegate!
    /*
    func functionForCheckIsSessionTimeoutOrNot()->(String,String)
    {
        var varValue:String!=""
        var varValueMessage:String!=""
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0)
        {
            var mainMemberID = NSUserDefaults.standardUserDefaults().stringForKey("masterUID")
            var updatedOn =  String ()
            let defaults = NSUserDefaults.standardUserDefaults()
            let Updatedefault = String(format: "updatedOn%@",mainMemberID!)
            updatedOn = "1970-01-01 00:00:00"
            if let str = defaults.valueForKey(Updatedefault) as! String?
            {
                print(str)
                updatedOn = str
            }
            else
            {
                updatedOn = "1970-01-01 00:00:00"
            }
            /*
             let post:NSString =  String(format:"masterUID=%@&imeiNo=%@&updatedOn=%@",mainMemberID!,UIDevice.currentDevice().identifierForVendor!.UUIDString,updatedOn)
             */
            
            // Group/GetAllGroupListSync",baseUrl
            //moduleId
            let completeURL = baseUrl+touchBase_GetAllGroupListSync
            let parameterst = [
                "masterUID" : mainMemberID!,
                "imeiNo" : UIDevice.currentDevice().identifierForVendor!.UUIDString,
                "updatedOn" : updatedOn
            ]
            
            print(parameterst)
            print(completeURL)
            var view:UIView=UIView()
            
            ServiceManager().webserviceWithRequestMethod(HTTPMethod.POST, url: completeURL, parameters: parameterst, forTask: TaskType.kTaskLogin, currentView: view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
                //=> Handle server response
                print(response)
                let dd = response as! NSDictionary
                if (dd.objectForKey("status") as! String == "0")
                {
                   varValue="continue"
                }
                else if (dd.objectForKey("status") as! String == "2")
                {
                    // self.appDelegate.showAlsertView()
                   varValueMessage = dd.objectForKey("message") as! String
                    NSUserDefaults.standardUserDefaults().removeObjectForKey("updatedOn")
                    self.appDelegate.showAlsertViewWhenSessionTimeOut(varValueMessage)
                    let alert=UIAlertController(title: "Rotary India", message:dd.objectForKey("message") as! String, preferredStyle: UIAlertController.Style.alert);
                   self.appDelegate.setMobileViewAsRoot()
                    //alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.Default, handler: {(action:UIAlertAction) in
                        self.appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                        self.appDelegate.setMobileViewAsRoot()
                        // self.appDelegate.showAlsertView()
                        varValue="timeout"

                   // }));
                    //self.presentViewController(alert, animated: true, completion: nil);
                }
            })
        }
    return (varValue,varValueMessage)
    }
*/
    //get today date
    func functionForGetTodatDate()->String
    {
        let date = Foundation.Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMdd"
        let result:String! = formatter.string(from: date)
        print(result)
        return (formatter.string(from: date))
    }
    //get today date
    func functionForGetTodatDayMonthYear()->String
    {
        let date = Foundation.Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let result:String! = formatter.string(from: date)
        print(result)
        return (formatter.string(from: date))
    }
    
    //get current year
    func functionForGetCurrentYear()->String
    {
        let date = Foundation.Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let result:String! = formatter.string(from: date)
        print(result)
        return (formatter.string(from: date))
    }

    
    func functionForMonthWordWiseNEwdate(_ varGetMonth:String)->String
    {
        let varGetMonth = varGetMonth
        var varGetMonthNew:String!=""
        
        if(varGetMonth=="01" || varGetMonth=="1")
        {
            varGetMonthNew="Jan"
        }
        else  if(varGetMonth=="02" || varGetMonth=="2")
        {
            varGetMonthNew="Feb"
        }
        else  if(varGetMonth=="03" || varGetMonth=="3")
        {
            varGetMonthNew="Mar"
        }
        else  if(varGetMonth=="04" || varGetMonth=="4")
        {
            varGetMonthNew="Apr"
        }
        else  if(varGetMonth=="05" || varGetMonth=="5")
        {
            varGetMonthNew="May"
        }
        else  if(varGetMonth=="06" || varGetMonth=="6")
        {
            varGetMonthNew="Jun"
        }
        else  if(varGetMonth=="07" || varGetMonth=="7")
        {
            varGetMonthNew="Jul"
        }
        else  if(varGetMonth=="08" || varGetMonth=="8")
        {
            varGetMonthNew="Aug"
        }
        else  if(varGetMonth=="09" || varGetMonth=="9")
        {
            varGetMonthNew="Sept"
        }
        else  if(varGetMonth=="10")
        {
            varGetMonthNew="Oct"
        }
        else  if(varGetMonth=="11")
        {
            varGetMonthNew="Nov"
        }
        else  if(varGetMonth=="12")
        {
            varGetMonthNew="Dec"
        }
        print(varGetMonthNew)
        return varGetMonthNew
    }
    
    
    
    //Get Month character wise
    func functionForMonthWordWise(_ varGetMonth:String)->String
    {
        let varGetMonth = varGetMonth
        var varGetMonthNew:String!=""
        
        if(varGetMonth=="01" || varGetMonth=="1")
        {
           // varGetMonthNew="January"
            varGetMonthNew="Jan"

        }
        else  if(varGetMonth=="02" || varGetMonth=="2")
        {
           // varGetMonthNew="February"
            varGetMonthNew="Feb"

        }
        else  if(varGetMonth=="03" || varGetMonth=="3")
        {
           // varGetMonthNew="March"
            varGetMonthNew="Mar"

        }
        else  if(varGetMonth=="04" || varGetMonth=="4")
        {
           // varGetMonthNew="April"
            varGetMonthNew="April"

        }
        else  if(varGetMonth=="05" || varGetMonth=="5")
        {
           // varGetMonthNew="May"
            varGetMonthNew="May"

        }
        else  if(varGetMonth=="06" || varGetMonth=="6")
        {
           // varGetMonthNew="June"
            varGetMonthNew="Jun"

        }
        else  if(varGetMonth=="07" || varGetMonth=="7")
        {
           // varGetMonthNew="July"
            varGetMonthNew="Jul"

        }
        else  if(varGetMonth=="08" || varGetMonth=="8")
        {
           // varGetMonthNew="August"
            varGetMonthNew="Aug"

        }
        else  if(varGetMonth=="09" || varGetMonth=="9")
        {
           // varGetMonthNew="September"
            varGetMonthNew="Sep"

        }
        else  if(varGetMonth=="10")
        {
           // varGetMonthNew="October"
            varGetMonthNew="Oct"

        }
        else  if(varGetMonth=="11")
        {
           // varGetMonthNew="November"
            varGetMonthNew="Nov"

        }
        else  if(varGetMonth=="12")
        {
           // varGetMonthNew="December"
            varGetMonthNew="Dec"

        }
        return varGetMonthNew
    }

    //password
    func isPasswordSame(_ password: String , confirmPassword : String) -> Bool {
        if password == confirmPassword{
            return true
        }
        else{
            return false
        }
    }
    //password length
    func isPwdLenth(_ password: String , confirmPassword : String) -> Bool {
        if password.characters.count <= 7 && confirmPassword.characters.count <= 7{
            return true
        }
        else{
            return false
        }
    }
    //phone number
    func validate(_ value: String) -> Bool
    {
    let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
    let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
    let result =  phoneTest.evaluate(with: value)
    return result
    }
    //email
//    func functionForisValidEmail(testStr:String) -> Bool
//    {
//        print("validate emilId: \(testStr)")
//        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
//        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//        let result = emailTest.evaluateWithObject(testStr)
//        return result
//    }
//    
    
    //date formatted
    func functionForDateMonthYearProper(_ stringFullDate:String,stringMidContainCharacter:String,stringRightMonthWhichFormatAvailable:String,stringWhichFormat:String,stringSeprateBy:String)->(String)
    {
        
        print(stringFullDate)
        
        //(familyClass.dOB, stringMidContainCharacter: "-",stringRightMonthWhichFormatAvailable:"Digit",stringWhichFormat: "ddmm",stringSeprateBy: " ")
        var varGetDay:String!=""
        var varGetMonth:String!=""
        var varGetYear:String!=""
        var varGetFormattedDate:String!=""
        if(stringMidContainCharacter=="/")
        {
            let arraySplit=stringFullDate.components(separatedBy: "/")
            varGetDay=arraySplit[0]
            varGetMonth=arraySplit[1]
            varGetYear=arraySplit[2]
        }
        if(stringMidContainCharacter=="-")
        {
            let arraySplit=stringFullDate.components(separatedBy: "-")
            varGetDay=arraySplit[0]
            varGetMonth=arraySplit[1]
            varGetYear=arraySplit[2]
        }
        //--
        if(stringRightMonthWhichFormatAvailable=="Digit")
        {
            if(varGetMonth=="01" || varGetMonth=="1")
            {
                varGetMonth="Jan"
            }
            else  if(varGetMonth=="02" || varGetMonth=="2")
            {
                varGetMonth="Feb"
            }
            else  if(varGetMonth=="03" || varGetMonth=="3")
            {
                varGetMonth="Mar"
            }
            else  if(varGetMonth=="04" || varGetMonth=="4")
            {
                varGetMonth="Apr"
            }
            else  if(varGetMonth=="05" || varGetMonth=="5")
            {
                varGetMonth="May"
            }
            else  if(varGetMonth=="06" || varGetMonth=="6")
            {
                varGetMonth="Jun"
            }
            else  if(varGetMonth=="07" || varGetMonth=="7")
            {
                varGetMonth="Jan"
            }
            else  if(varGetMonth=="08" || varGetMonth=="8")
            {
                varGetMonth="Aug"
            }
            else  if(varGetMonth=="09" || varGetMonth=="9")
            {
                varGetMonth="Sep"
            }
            else  if(varGetMonth=="10")
            {
                varGetMonth="Oct"
            }
            else  if(varGetMonth=="11")
            {
                varGetMonth="Nov"
            }
            else  if(varGetMonth=="12")
            {
                varGetMonth="Dec"
            }
        }
        else   if(stringRightMonthWhichFormatAvailable=="Alpha")
        {
        }
        //1ddmm //2.ddmmyy
        if(stringWhichFormat=="ddmm")
        {
            varGetFormattedDate=varGetDay+stringSeprateBy+varGetMonth
        }
        else if(stringWhichFormat=="ddmmyy")
        {
            varGetFormattedDate=varGetDay+stringSeprateBy+varGetMonth
        }
        else if(stringWhichFormat=="mmddyy")
        {
            varGetFormattedDate=varGetDay+stringSeprateBy+varGetMonth
        }
        else if(stringWhichFormat=="yymmdd")
        {
            varGetFormattedDate=varGetDay+stringSeprateBy+varGetMonth
        }
        print("formatted date will be sent to you:---"+varGetFormattedDate)
        return(varGetFormattedDate)
        /*
         let(varGetFormattedDate)=commonClassFunction().functionForDateMonthYearProper(personalClass.value, stringMidContainCharacter: "-",stringRightMonthWhichFormatAvailable:"Digit",stringWhichFormat: "ddmm",stringSeprateBy: " ")
         
         */
    }
    //--code by Rajendra Jat compare date
    func functionForCompareDatewithTime(_ stringFirstDate:String!,stringSecondDate:String!)->String
    {
        var varGetDateStatus:String!=""
        // let strTime = "2015-07-27 19:29:50 +0000"
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm a"
        //formatter.dateFromString(letPublishDatenTime) // Returns "Jul 27, 2015, 12:29 PM" PST
        print("first:-----")
        print(stringFirstDate)
           print("second:-----")
        print(stringSecondDate)

        if(stringFirstDate.characters.count>2 && stringSecondDate.characters.count>2)
        {
//            let letFirstDate:Foundation.Date=formatter.date(from: stringFirstDate)!
//        let letLastDate:Foundation.Date=formatter.date(from: stringSecondDate)
        
     let letFirstDate = stringFirstDate
            let letLastDate = stringSecondDate
            if(letFirstDate? .compare((letLastDate)!) == .orderedDescending)
        {
           varGetDateStatus="Descending"
        }
            else if(letFirstDate? .compare((letLastDate)!) == .orderedSame)
        {
         varGetDateStatus="Same"
        }
            else if(letFirstDate? .compare((letLastDate)!) == .orderedAscending)
        {
          varGetDateStatus="Ascending"
        }
        }
        return varGetDateStatus
        /*
         var varGetDateStatus=commonClassFunction().functionForCompareDatewithTime(letPublishDatenTime, stringSecondDate: letExpireDatenTime)
         
         if(varGetDateStatus=="Descending")
         {
         self.view.makeToast("Publish date can not be greater than from Expire date" , duration: 3, position: CSToastPositionCenter)
         }
         else if(varGetDateStatus=="Same")
         {
         self.view.makeToast("Publish date and time can not be same as Expire date and time", duration: 3, position: CSToastPositionCenter)
         }
         else if(varGetDateStatus=="Ascending")
         {
         self.view.makeToast("Publish date can be less from Expire date", duration: 3, position: CSToastPositionCenter)
         }
         */
    }
    
    
    
}



