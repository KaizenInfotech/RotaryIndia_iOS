//
//  CustomisedDashViewController.swift
//  TouchBase
//
//  Created by Umesh on 28/01/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit
import Alamofire
class CustomisedDashViewController: UIViewController,webServiceDelegate,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var bottomBtn:UIButton!
    var textOfbtm:String!
    var catText:String!
    fileprivate let cellIdentifier = "modulecollectionCell"
    var unCategoriesArry:NSMutableArray!
    var profileIds:NSMutableArray!
    var appDelegate : AppDelegate!
    var allmoduleCAtArry:NSMutableArray!
    override func viewDidLoad() {
        super.viewDidLoad()
        createNavigationBar()
        unCategoriesArry  = NSMutableArray ()
        // Do any additional setup after loading the view.
        profileIds = NSMutableArray()
        allmoduleCAtArry = NSMutableArray ()
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")//isAdmin
        fetchData()
        //        let wsm : WebserviceClass = WebserviceClass.sharedInstance
        //        wsm.delegates=self
        //        wsm.getAllGroupsOFUSer(mainMemberID!)
        
    }
    
    
    func fetchData (){
        print(catText)
        unCategoriesArry=[]
        var databasePath : String
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("NewTouchbase.db")
        // open database
        databasePath = fileURL.path
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }else{
            // self.Createtablecity()
        }
        print(databasePath)
        let contactDB = FMDatabase(path: databasePath as String)
        if contactDB == nil {
            print("Error: \(contactDB?.lastErrorMessage())")
        }
        let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
        if (contactDB?.open())! {
            let querySQL = "SELECT *  FROM GROUPMASTER where myCategory = 0"
            
            
            let results:FMResultSet? = contactDB?.executeQuery(querySQL,
                                                               withArgumentsIn: nil)
            
            while results?.next() == true {
                print((results?.string(forColumn: "grpId"))! as String)
                print((results?.string(forColumn: "grpName"))! as String)
                print((results?.string(forColumn: "grpImg"))! as String)
                let dd = NSMutableDictionary ()
                dd.setValue((results?.string(forColumn: "grpId"))! as String, forKey:"grpId")
                dd.setValue((results?.string(forColumn: "grpName"))! as String, forKey:"grpName")
                dd.setValue((results?.string(forColumn: "grpImg"))! as String, forKey:"grpImg")
                dd.setValue((results?.string(forColumn: "grpProfileid"))! as String, forKey:"grpProfileid")
                dd.setValue((results?.string(forColumn: "isGrpAdmin"))! as String, forKey:"isGrpAdmin")
                //unCategoriesArry=[]
                unCategoriesArry.add(dd)
                
            }
            
            
        }
    }
    
    
    
    
    //    func mygroupsDelegateFunction(string: TBGroupResult) {
    //        print(string.status)
    //        if(string.status  == "0"){
    //            if(string.AllGroupListResults.count > 0){
    //
    //                allmoduleCAtArry=string.AllGroupListResults
    //                let predicate3 = NSPredicate(format: "myCategory contains %@", "0")
    //                unCategoriesArry = allmoduleCAtArry.filteredArrayUsingPredicate(predicate3)
    //                collectionView.reloadData()
    //            }else
    //            {
    //                allmoduleCAtArry=[]
    //                unCategoriesArry=[]
    //            }
    //        }else{
    //            allmoduleCAtArry=[]
    //            unCategoriesArry=[]
    //        }
    //        if(unCategoriesArry.count > 0){
    //            bottomBtn.hidden = false
    //        }else{
    //            bottomBtn.hidden = true
    //        }
    //    }
    
    func createNavigationBar(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title=textOfbtm
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(CustomisedDashViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
     @objc func backClicked(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return unCategoriesArry.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ModuleCollectionViewCell
        // cell.delegates=self
        
        var dict:NSDictionary!
        dict = unCategoriesArry[indexPath.row] as! NSDictionary
        cell.grpName.text = dict.object(forKey: "grpName") as? String
        cell.imgUser.image = UIImage(named: "dashboardplaceholder")
        cell.imgUser.image = UIImage(named: "dashboardplaceholder")
        if let checkedUrl = URL(string: dict.object(forKey: "grpImg") as! String) {
            
            appDelegate.getDataFromUrl(checkedUrl) { (data, response, error)  in
                DispatchQueue.main.async { () -> Void in
                    guard let data = data, error == nil else { return }
                    print(response?.suggestedFilename ?? "")
                    print("Download Finished")
                    cell.imgUser.image = UIImage(data: data)
                    
                    //  cell.activityLoader.stopAnimating()
                }
            }
        }
        return cell
    }
    
    func imageWithGradient(_ img:UIImage!) -> UIImage{
        
        UIGraphicsBeginImageContext(img.size)
        let context = UIGraphicsGetCurrentContext()
        
        img.draw(at: CGPoint(x: 0, y: 0))
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let locations:[CGFloat] = [0.65, 1.0]
        //1 = opaque
        //0 = transparent
        let bottom = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4).cgColor
        let top = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        //myy code
        //let gradient = CGGradient(colorsSpace: colorSpace, colors: [top, bottom], locations: locations)
        //let gradient = CGGradient(colorsSpace: colorSpace, colors: [nil], locations: locations)

        
       // let startPoint = CGPoint(x: img.size.width/2, y: 0)
       // let endPoint = CGPoint(x: img.size.width/2, y: img.size.height)
        
        
        //context!.drawLinearGradient(gradient!,start: startPoint,end: endPoint, options: CGGradientDrawingOptions(rawValue: 0))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image!
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        var dict:NSDictionary!
        dict = unCategoriesArry[indexPath.row] as! NSDictionary
        
        //        print("id of grp \(grp.grpId)")
        
        let cell : ModuleCollectionViewCell = collectionView.cellForItem(at: indexPath) as! ModuleCollectionViewCell
        
        if cell.chkBTn.currentImage!.isEqual(UIImage(named: "CHECK_BLUE_ROW")) {
            //do something here
            cell.chkBTn .setImage(UIImage(named: "UN_CHECK_BLUE_ROW"),  for: UIControl.State.normal)
            print("inside if")
            profileIds.remove((dict.object(forKey: "grpProfileid") as? String)!)
        }else{
            profileIds.add((dict.object(forKey: "grpProfileid") as? String)!)
            
            cell.chkBTn .setImage(UIImage(named: "CHECK_BLUE_ROW"),  for: UIControl.State.normal)
            print("inside else")
        }
        
        let strprofileIDs = profileIds.componentsJoined(by: ",")
        print(strprofileIDs)
        //        let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("mainDash") as! MainDashboardViewController
        //        //secondViewController.grpDetail=grp
        //        self.navigationController?.pushViewController(secondViewController, animated: true)
        
        // self.navigationController!.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier("mainDash") as UIViewController, animated: true)
    }
    @IBAction func AllButtonAction(_ sender: AnyObject){
        if profileIds.count > 0 {
            let n: Int! = self.navigationController?.viewControllers.count
            let myUIViewController = self.navigationController?.viewControllers[n-2]
            print("view at back \(myUIViewController)")
            let strprofileIDs = profileIds.componentsJoined(by: ",")
            let mainMemberID = UserDefaults.standard.string(forKey: "masterUID")
            //        let wsm : WebserviceClass = WebserviceClass.sharedInstance
            //        wsm.delegates=self
            self.updateGroupsOFUSer(strprofileIDs as NSString, mycategory: catText as! NSString, memberMainId: mainMemberID! as NSString)
            //myUIViewController?.childViewControllers.
        }
        
    }
    
    func updateGroupsOFUSer(_ memberProfileId: NSString,mycategory:NSString,memberMainId:NSString) {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
         if(Reachability(hostName: "www.apple.com" as String).currentReachabilityStatus() != 0){
            
            
            /*-------------------------------------------------------------*/
            
            //  let post:NSString = String(format: "memberProfileId=%@&mycategory=%@&memberMainId=%@",memberProfileId,mycategory,memberMainId) as NSString
            //                NSLog("PostData: %@",post);
            //                let url:URL = URL(string:String(format: "%@Group/UpdateMemberGroupCategory",baseUrl))!
            
            
            let url = URL(string: baseUrl+"Group/UpdateMemberGroupCategory")!
            var params: [String: String] = [
                "memberProfileId": memberProfileId as String,
                "mycategory": mycategory as String,
                "memberMainId": memberMainId as String
            ]
            print(url)
            print(params)
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                switch response.result {
                case .success:
                    // var result = [String:String]()
                    if let value = response.result.value {
                        //let string = NSString(data: data!, encoding: String.Encoding.isoLatin1)
                       // print("Response 8888 \(string!)")
                        //
                        
                        let dic = response.result.value!
                        let data = try? JSONSerialization.data(withJSONObject: dic, options: [])
                        
                        
                        //let data = string!.data(using: String.Encoding.utf8, allowLossyConversion: false)
                        let jsonObject: AnyObject? = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions()) as AnyObject
                        print("jsonObject \(jsonObject!)")
                        let dd = jsonObject as! NSDictionary
                        print("dd \(dd)")
                        if (dd.object(forKey: "status") as! String == "0"){
                            self.navigationController?.popViewController(animated: true)
                        }
                        //--------------------------------------------
                        /*
                         let dic = response.result.value!
                         let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
                         let jsonString = String(data: jsonData!, encoding: .utf8)!
                         print(jsonString)
                         let welcome:WelcomeResult!
                         welcome = WelcomeResult.fromJSONData(jsonData) as! WelcomeResult
                         self.window = nil
                         self.delegates?.WelcomeDelegateFunction!(welcome: welcome)
                         */
                        //-------------------------------------------
                    }
                case .failure(_): break
                }
            }
            
            /*-------------------------------------------------------------*/
            
            
            
            //loaderViewMethod()
            //            do {
            //                let post:NSString = String(format: "memberProfileId=%@&mycategory=%@&memberMainId=%@",memberProfileId,mycategory,memberMainId) as NSString
            //                NSLog("PostData: %@",post);
            //                let url:URL = URL(string:String(format: "%@Group/UpdateMemberGroupCategory",baseUrl))!
            //                let postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
            //                let postLength:NSString = String( postData.count ) as NSString
            //                let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
            //                request.httpMethod = "POST"
            //                request.httpBody = postData
            //                request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
            //                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            //                request.setValue("application/json", forHTTPHeaderField: "Accept")
            //
            //
            //                do {
            //                    //  urlData = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
            //                    NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main) { (response: URLResponse?, data: Data?, error: NSError?) in
            //                        let string = NSString(data: data!, encoding: String.Encoding.isoLatin1)
            //                        print("Response 8888 \(string!)")
            //                        //
            //                        let data = string!.data(using: String.Encoding.utf8, allowLossyConversion: false)
            //                        let jsonObject: AnyObject? = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions())
            //                        print("jsonObject \(jsonObject!)")
            //                        let dd = jsonObject as! NSDictionary
            //                        print("dd \(dd)")
            //                        if (dd.object(forKey: "status") as! String == "0"){
            //                            self.navigationController?.popViewController(animated: true)
            //                        }
            //                        } as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void as! (URLResponse?, Data?, Error?) -> Void
            //                }
            //
            //
            //            }
        }
    }
    
    
    func updatemyGroupsOFUSerSuccss(_ string:TBGroupResult){
        print("chk click")
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
