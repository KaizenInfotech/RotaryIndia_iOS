//
//  ImageFullViewController.swift
//  TouchBase
//
//  Created by Umesh on 08/03/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit

class ImageFullViewController: UIViewController,UIScrollViewDelegate {
    @IBOutlet weak var fullImg:UIImageView!
    var urlLink:NSString!
    var appDelegate:AppDelegate!
    @IBOutlet var indicator:UIActivityIndicatorView!
      let bounds = UIScreen.main.bounds
    @IBOutlet var scrollImg:UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden=true
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        indicator.startAnimating()
       createNavigationBar()
        
       
        // Do any additional setup after loading the view.
        if let checkedUrl = URL(string: urlLink as String) {
            self.fullImg.sd_setImage(with: checkedUrl)
            indicator.stopAnimating()
//            appDelegate.getDataFromUrl(checkedUrl) { (data, response, error)  in
//                DispatchQueue.main.async { () -> Void in
//                    guard let data = data, error == nil else { return }
//                    print(response?.suggestedFilename ?? "")
//                    print("Download Finished")
//                    self.fullImg.image = UIImage(data: data)
//                    self.indicator.stopAnimating()
//                    //  cell.activityLoader.stopAnimating()
//                }
            //}
        }else{
            //galleryplaceholder.png
             self.fullImg.image = UIImage(named: "galleryplaceholder.png")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.fullImg.translatesAutoresizingMaskIntoConstraints = true
        self.fullImg.frame=CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView?
    {
        return self.fullImg
    }
    @IBAction func backCliked(){
        self.navigationController?.isNavigationBarHidden=false
        self.navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func createNavigationBar(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title = ""
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white //(red: 24/255.0, green: 117/255.0, blue: 210/255.0, alpha: 1.0)
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(ImageFullViewController.backClicked), for: UIControl.Event.touchUpInside)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
