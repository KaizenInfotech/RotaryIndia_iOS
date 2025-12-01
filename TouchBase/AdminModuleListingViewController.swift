/*
 
 Input:
 {
 "Fk_groupID":"2765","fk_ProfileID":"261732"
 }
 
 */
import SVProgressHUD
import MessageUI
import UIKit
import Alamofire
import SJSegmentedScrollView
import SDWebImage
import SVProgressHUD
class AdminModuleListingViewController: UIViewController,webServiceDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate {
    var allmoduleCAtArry:NSMutableArray!
    
    
    
    var Fk_groupID:String!=""
    var fk_ProfileID:String!=""

    
    fileprivate let cellIdentifier = "collectionCell"
    //MARK:- Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    //MARK:- ViewDidload
    override func viewDidLoad()
    {
        super.viewDidLoad()
       // allmoduleCAtArry.add("9")
         fetchData()
        self.collectionView.alwaysBounceVertical = true;
    }
    //MARK:- ViewWillAppear
    override func viewWillAppear(_ animated: Bool)
    {
        print("allmoduleCAtArry:=:=: \(allmoduleCAtArry)")
        collectionView.isUserInteractionEnabled=true
        SVProgressHUD.dismiss()
         self.collectionView.reloadData()
        createNavigationBar()
       
    }
    //MARK:- Functions
    func fetchData()
    {
        /*
        let completeURL = baseUrl+"Group/getAdminSubModules"
        var parameterst = ["":""]
        parameterst =  ["Fk_groupID": Fk_groupID,
                        "fk_ProfileID": fk_ProfileID
        ]
        print(parameterst)
        print(completeURL)
        ServiceManager().webserviceWithRequestMethod(HTTPMethod.post, url: completeURL, parameters: parameterst as [AnyHashable: Any], forTask: TaskType.kTaskLogin, currentView: self.view, useAccessToken: false, completionHandler: {(response: AnyObject) -> Void in
            //=> Handle server response
            let dd = response as! NSDictionary
            print("dd \(dd)")
            var varGetValueServerError = response.object(forKey: "serverError")as? String
            if(varGetValueServerError == "Error")
            {
                self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                SVProgressHUD.dismiss()
            }
            else
            {
                var varGetValueServerError = response.object(forKey: "serverError")as? String
                if(varGetValueServerError == "Error")
                {
                    self.view.makeToast("Something went wrong, Please try again later", duration: 2, position: CSToastPositionCenter)
                    SVProgressHUD.dismiss()
                }
                else
                {
                    if((dd.object(forKey: "AdminSubmodulesResult")! as AnyObject).object(forKey: "status") as! String == "0")
                    {
                        print((dd.object(forKey: "AdminSubmodulesResult")! as AnyObject).object(forKey: "list"))
                        var myNewName = NSMutableArray()
                        var getListjsonResult: NSArray=NSArray()
                        getListjsonResult=(dd.object(forKey: "AdminSubmodulesResult")! as AnyObject).object(forKey: "list") as! NSArray
                         self.allmoduleCAtArry = NSMutableArray(array:getListjsonResult)
                         self.collectionView.reloadData()
                    }
                }
            }
        })
        */
    }
    func createNavigationBar()
    {
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = "Admin"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        //self.navigationController?.navigationBar.barTintColor = UIColor(red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        //let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
//        buttonleft.addTarget(self, action: #selector(MainDashboardViewController.backClicked), for: UIControl.Event.touchUpInside)
          buttonleft.addTarget(self, action: #selector(backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
    }
      @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
       // if(allmoduleCAtArry.count>0)
        //{
        return allmoduleCAtArry.count
        //}
       // return 6
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CustomCollectionViewCell
        cell.layer.borderColor = UIColor.white.cgColor
        var dict :NSDictionary!
        if(allmoduleCAtArry.count>0)
        {
        print(allmoduleCAtArry)
        dict=allmoduleCAtArry[indexPath.row] as! NSDictionary
        print(dict)
        cell.grpName.text=dict.object(forKey: "Title") as? String
        cell.moduleId=dict.object(forKey: "ModuleID") as! String as NSString
        
        if let checkedUrl = URL(string: dict.object(forKey: "imgurl") as! String)
        {
            cell.moduleIcon.sd_setImage(with: checkedUrl)
        }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSpacing = CGFloat(0) //Define the space between each cell
        let leftRightMargin = CGFloat(0) //If defined in Interface Builder for "Section Insets"
        let numColumns = CGFloat(3) //The total number of columns you want
        
        let totalCellSpace = cellSpacing * (numColumns - 1)
        let screenWidth = UIScreen.main.bounds.width
        let width = ((screenWidth - leftRightMargin - totalCellSpace) / numColumns)
        let height = CGFloat(110) //whatever height you want
        return CGSize(width:width-7, height:height);
    }
    var varGetValueModuleID:String!=""
     var isCategory:String!=""
    var varGroupID:String!=""
    var groupUniqueName:String!=""
    //groupUniqueName
      var isAdmin:String!=""
      var userID:String!=""
      var moduleId:String!=""
      var moduleName:String!=""
    
    ///
    var grpDetailPrevious:NSDictionary!

   // var moduleName:String!=""
    var grpName:String!=""
    
    
    
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        print(indexPath.row)
        var dict :NSDictionary!
        dict = allmoduleCAtArry[indexPath.row] as! NSDictionary
        print(dict)
        var getModuleID:String!=""
        getModuleID=dict.object(forKey: "ModuleID") as? String
        SVProgressHUD.show()
//        let objAdminListWebViewViewController = self.storyboard?.instantiateViewController(withIdentifier: "AdminListWebViewViewController") as! AdminListWebViewViewController
//        objAdminListWebViewViewController.URLstr = dict.object(forKey: "url") as? String
//        objAdminListWebViewViewController.moduleName = dict.object(forKey: "Title") as? String
//        self.navigationController?.pushViewController(objAdminListWebViewViewController, animated: true)
        
        
                let editProfileScreen = self.storyboard?.instantiateViewController(withIdentifier: "RotaryOrgWebViewViewController") as! RotaryOrgWebViewViewController
        editProfileScreen.url = dict.object(forKey: "url") as? String ?? ""
                editProfileScreen.moduleName = dict.object(forKey: "Title") as? String
                editProfileScreen.varFromCalling = "Edit Profile"
                print(editProfileScreen.URLstr)
                self.navigationController?.pushViewController(editProfileScreen, animated: true)
        
//        let editProfileScreen = self.storyboard?.instantiateViewController(withIdentifier: "WebSiteOpenUrlViewController") as! WebSiteOpenUrlViewController
//        editProfileScreen.varOpenUrl = dict.object(forKey: "url") as? String ?? ""
//        editProfileScreen.navTitle = dict.object(forKey: "Title") as? String ?? ""
//        print(editProfileScreen.varOpenUrl)
//        self.navigationController?.pushViewController(editProfileScreen, animated: true)
//        
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}

/*06 June 2019 after adding remain module of Admin module 2.32pm*/
