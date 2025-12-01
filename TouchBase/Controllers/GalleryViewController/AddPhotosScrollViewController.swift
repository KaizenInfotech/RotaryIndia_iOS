//
//  AddPhotosScrollViewController.swift
//  TouchBase
//
//  Created by Umesh on 26/09/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit

class AddPhotosScrollViewController: UIViewController,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UIPageViewControllerDelegate,UIPageViewControllerDataSource,webServiceDelegate
{
    var pageController : UIPageViewController!
    var pageTitles : NSArray?
    var pageInteger :Int?
    var isAdmin :NSString!
    //  var pageImages : NSArray!
    
    //  var pageTitles : NSMutableArray = NSMutableArray()
    
    
    var appDelegate : AppDelegate = AppDelegate()
    //
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var ImageView: UIImageView!
    
    var innerView: UIView!
    var innerImage: UIImageView!
    // var img:UIImageView!
    
    var tap = UITapGestureRecognizer()
    var img: UIImageView!
    //  var passPhotos : NSMutableArray = NSMutableArray()
    var passPhotos = [UIImage]()
    
    @IBOutlet var selectedImgDetailImgView: UIImageView!
    
    @IBOutlet var selectedImgDetailTextView: UITextView!
    
    @IBOutlet var selectedImgDetailDescriptionLbl: UILabel!
    
    
    
    @IBOutlet var photosTbleView: UITableView!
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        // self.pageTitles = NSArray(objects: "Ganesh","Shravan","Abhishek","Satish","Mangesh")
        //  self.pageImages = NSArray(objects: "bubble_left.png","bubble_right.png")
        self.pageController = self.storyboard?.instantiateViewController(withIdentifier: "pageVC") as! UIPageViewController
        self.pageController.dataSource = self
        
        print("..pageInteger\(pageInteger)")
        let startVc = self.viewcontrollerAtIndex(pageInteger!) as PagerViewController
        let viewControllers1 = NSArray(objects: startVc)
        
        self.pageController.view.backgroundColor = UIColor.clear
        self.pageController.setViewControllers(viewControllers1 as? [UIViewController], direction: .forward, animated: true, completion: nil)
        self.pageController.view.frame = CGRect(x: 0, y: 47, width: self.view.frame.width, height: self.view.frame.height)
        self.addChild(self.pageController)
        self.view.addSubview(self.pageController.view)
        self.pageController.didMove(toParent: self)
        
        var xOffset = 0
        let height = 100
        let width = 83
        for index in 0..<passPhotos.count
        {
            //  ImageView = UIImageView(frame: CGRect(x: xOffset, y: 10, width: 160, height: 100))
            
            // img.image = UIImage(named:"dashboardplaceholder.png")!
            
            
            innerView = UIView(frame: CGRect(x: xOffset, y: 0, width: width, height: height))
            innerView.backgroundColor = UIColor.clear
            
            let productGraybgImgView = UIImageView(frame: CGRect(x: -5, y: -5, width: width + 10, height: height - 20))
            //                    productGraybgImgView.image = UIImage(named:"dashboardplaceholder.png")!
            productGraybgImgView.backgroundColor = UIColor.clear
            
            var productWhitebgImgView: UIImageView!
            productWhitebgImgView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height - 38))
            //                    productWhitebgImgView.image = UIImage(named:"dashboardplaceholder.png")!
            productWhitebgImgView.backgroundColor = UIColor.clear
            
            innerImage = UIImageView(frame: CGRect(x: 5, y: 5, width: width - 10, height: height - 30))
            
            
            innerView.addSubview(productGraybgImgView)
            innerView.addSubview(productWhitebgImgView)
            innerView.addSubview(innerImage)
            
            let  dict = pageTitles![index] as! NSDictionary
            innerImage.image = UIImage(named: "dashboardplaceholder")
            if let checkedUrl = URL(string: dict.object(forKey: "url") as! String) {
                appDelegate.getDataFromUrl(checkedUrl) { (data, response, error)  in
                    DispatchQueue.main.async { () -> Void in
                        guard let data = data, error == nil else { return }
                        print(response?.suggestedFilename ?? "")
                        print("Download Finished")
                        self.innerImage.image  = UIImage(data: data)
                        
                        //  cell.activityLoader.stopAnimating()
                    }
                }
            }
            
            
            xOffset += 80
            let singleTap = UITapGestureRecognizer(target: self, action:#selector(AddPhotosScrollViewController.OpenGallary))
            singleTap.numberOfTapsRequired = 1
            innerImage.isUserInteractionEnabled = true
            
            innerImage.addGestureRecognizer(singleTap)
            
            scrollView.addSubview(innerView)
        }
        
        
        
        let scrollWidth = 100
        scrollView.contentSize = CGSize(width: scrollWidth + xOffset , height: 80)
        
        
        
        
        
        
        
        self.createNavigationBar()
        // Do any additional setup after loading the view.
    }
    @objc func OpenGallary(_ sender: UITapGestureRecognizer)
    {
        let recognizer = (sender as UIGestureRecognizer)
        let imageView = (recognizer.view! as! UIImageView)
        selectedImgDetailImgView.image = imageView.image
        
        
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return (self.pageTitles?.count)!
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        
        let cell = photosTbleView.dequeueReusableCell(withIdentifier: "AddPhotosDetailViewCell", for: indexPath) as! AddPhotosDetailViewCell
        
        
        //        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(AddPhotosScrollViewController.imageTapped(_:)))
        //        tapGestureRecognizer.numberOfTapsRequired = 1
        //        tapGestureRecognizer.numberOfTouchesRequired = 1
        //        img.userInteractionEnabled = true
        //        img.addGestureRecognizer(tapGestureRecognizer)
        
        //        let xView = 0
        //        let height = 110
        //        let width = 83
        
        
        
        
        //        for view: UIView in cell.photosScrollView.subviews
        //        {
        //            view.removeFromSuperview()
        //        }
        //
        //        innerView = UIView(frame: CGRect(x: xView, y: 0, width: width, height: height))
        //
        //        let productGraybgImgView = UIImageView(frame: CGRect(x: -5, y: -5, width: width + 10, height: height + 10))
        //        productGraybgImgView.image = UIImage(named:"dashboardplaceholder.png")!
        //
        //        var productWhitebgImgView: UIImageView!
        //        productWhitebgImgView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height - 38))
        //         productWhitebgImgView.image = UIImage(named:"dashboardplaceholder.png")!
        //
        //        innerImage = UIImageView(frame: CGRect(x: 5, y: 5, width: width - 10, height: height - 48))
        //
        //        innerView.addSubview(productGraybgImgView)
        //        innerView.addSubview(productWhitebgImgView)
        //        innerView.addSubview(innerImage)
        //
        //        cell.photosScrollView.addSubview(innerView)
        //        cell.photosScrollView.contentSize = CGSizeMake(cell.photosScrollView.frame.size.height*10, cell.photosScrollView.frame.size.height)
        
        return cell
    }
    
    
    func createNavigationBar()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title = "AddPhotos"
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white//(red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(AddPhotoViewController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(AddPhotoViewController.backClicked))
        add.tintColor = UIColor.white
        
        let editB = UIButton(type: UIButton.ButtonType.custom)
        editB.frame = CGRect(x: 50, y: 0, width: 30, height: 40)
        editB.setImage(UIImage(named:"overflow_btn_blue"),  for: UIControl.State.normal)
        editB.addTarget(self, action: #selector(AddPhotosScrollViewController.DropDownAction), for: UIControl.Event.touchUpInside)
        let edit: UIBarButtonItem = UIBarButtonItem(customView: editB)
        
        //        let settingButton = UIButton(type: UIButton.ButtonType.custom)
        //        settingButton.frame = CGRectMake(0, 0, 30, 40)
        //        settingButton.setImage(UIImage(named:"appsettings_btn"), forState: UIControl.State.Normal)
        //        settingBujktton.addTarget(self, action: #selector(MainDashboardViewController.SettingsAction), forControlEvents: UIControl.Event.TouchUpInside)
        //        let setting: UIBarButtonItem = UIBarButtonItem(customView: settingButton)
        let buttons : NSArray = [edit]
        self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
        if isAdmin == "No" {
            dropDownView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        }else{
            dropDownView.frame = CGRect(x: self.view.frame.size.width-150, y: 64, width: 150, height: 157)
        }
        
        //        if(""){
        //            dropDownView.frame = CGRectMake(self.view.frame.size.width-150, 64, 150, 207)
        //        }else{
        //            dropDownView.frame = CGRectMake(self.view.frame.size.width-150, 64, 150, 160)
        //        }
        dropDownView.isHidden = true
        dropDownView.backgroundColor = UIColor.white
        dropDownView.layer.borderWidth = 0.5
        dropDownView.layer.borderColor = UIColor.lightGray.cgColor
        //  self.view.addSubview(dropDownView)
        UIApplication.shared.keyWindow?.addSubview(dropDownView)
        // window.addSubview(dropDownView)
        dropDown_flag = false
        
        let button1 = UIButton()
        button1.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        button1.setTitleColor(UIColor.darkGray,  for: UIControl.State.normal)
        button1.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        button1.contentEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        button1.addTarget(self, action: #selector(AddPhotosScrollViewController.ProfileViewAction), for: .touchUpInside)
        button1.setTitle("Edit",  for: UIControl.State.normal)
        button1.titleLabel?.font = UIFont(name: "OpenSans-Semibold", size: 15)
        dropDownView.addSubview(button1)
        
        let border = UIImageView()
        border.frame = CGRect(x: 0, y: 52, width: 150, height: 1)
        border.backgroundColor = UIColor.lightGray
        dropDownView.addSubview(border)
        
        let button2 = UIButton()
        button2.frame = CGRect(x: 0, y: 55, width: 150, height: 50)
        button2.addTarget(self, action: #selector(AddPhotosScrollViewController.ProfileViewAction), for: .touchUpInside)
        button2.setTitle("Delete",  for: UIControl.State.normal)
        button2.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        button2.contentEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        button2.setTitleColor(UIColor.darkGray,  for: UIControl.State.normal)
        button2.titleLabel?.font = UIFont(name: "OpenSans-Semibold", size: 15)
        dropDownView.addSubview(button2)
        
        let border1 = UIImageView()
        border1.frame = CGRect(x: 0, y: 105, width: 150, height: 1)
        border1.backgroundColor = UIColor.lightGray
        dropDownView.addSubview(border1)
        
        let button3 = UIButton()
        button3.frame = CGRect(x: 0, y: 106, width: 150, height: 50)
        button3.addTarget(self, action: #selector(AddPhotosScrollViewController.ProfileViewAction), for: .touchUpInside)
        button3.setTitle("Share",  for: UIControl.State.normal)
        button3.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        button3.contentEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        button3.setTitleColor(UIColor.darkGray,  for: UIControl.State.normal)
        button3.titleLabel?.font = UIFont(name: "OpenSans-Semibold", size: 15)
        dropDownView.addSubview(button3)
        
        
        
    }
     @objc func backClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    func viewcontrollerAtIndex(_ pageIndex :Int) -> PagerViewController
    {
        if((self.pageTitles!.count == 0) || (pageIndex >= self.pageTitles!.count))
        {
            return PagerViewController()
        }
        
        print("....index\(index)")
        let vc : PagerViewController = self.storyboard?.instantiateViewController(withIdentifier: "PagerViewController") as! PagerViewController
        print("....pageTitles\(pageTitles)")
        
        
        let  dict = self.pageTitles![pageIndex] as! NSDictionary
        
        vc.imageUrl = dict.object(forKey: "url") as? String as! NSString
        vc.titleText = dict.object(forKey: "description") as? String
        vc.pageIndex = pageIndex
        
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        let vc = viewController as! PagerViewController
        var index = vc.pageIndex! as Int
        
        if (index == 0 || index == NSNotFound)
        {
            return nil
        }
        
        index -= 1
        print("....index\(index)")
        print("....pageIndex\(vc.pageIndex! as Int)")
        return self.viewcontrollerAtIndex(index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        
        
        let vc = viewController as! PagerViewController
        print("....pageIndex\(vc.pageIndex! as Int)")
        var index = vc.pageIndex! as Int
        
        if (index  == NSNotFound)
        {
            return nil
        }
        
        index += 1
        
        if (index == self.pageTitles!.count)
        {
            return nil
        }
        
        return self.viewcontrollerAtIndex(index)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int
    {
        print("....self.pageTitles.count\(self.pageTitles!.count)")
        return self.pageTitles!.count
        
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int
    {
        return 0
    }
    
    
    
    var dropDown_flag = Bool()
    let dropDownView = UIView()
    
    @objc func DropDownAction()
    {
        if dropDown_flag == false
        {
            dropDown_flag = true
            dropDownView.isHidden = false
            UIApplication.shared.keyWindow?.addSubview(dropDownView)
            let tap = UITapGestureRecognizer(target: self, action: #selector(MainDashboardViewController.handleTap(_:)))
            // view.addGestureRecognizer(tap)
        }
        else
        {
            dropDown_flag = false
            dropDownView.isHidden = true
            dropDownView.removeFromSuperview()
        }
        //self.navigationController!.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier("rootDash") as UIViewController, animated: true)
    }
    
    func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        appDelegate.window = nil
        
        if dropDown_flag == false
        {
            if dropDownView.isHidden == false
            {
                dropDown_flag = true
            }
            else
            {
                dropDown_flag = false
            }
            dropDownView.isHidden = true
            dropDownView.removeFromSuperview()
        }
        else
        {
            if dropDownView.isHidden == false
            {
                dropDown_flag = false
            }
            else
            {
                dropDown_flag = true
            }
            dropDownView.isHidden = true
            dropDownView.removeFromSuperview()
        }
        
    }
    
    
    @objc func ProfileViewAction()
    {
        if dropDown_flag == false
        {
            if dropDownView.isHidden == false
            {
                dropDown_flag = true
            }
            else
            {
                dropDown_flag = false
            }
            dropDownView.removeFromSuperview()
        }
        else
        {
            if dropDownView.isHidden == false
            {
                dropDown_flag = false
            }
            else
            {
                dropDown_flag = true
            }
            dropDownView.removeFromSuperview()
        }
        
        
        
    }
    
    
    
}
 
