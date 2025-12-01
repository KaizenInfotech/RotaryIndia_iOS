//
//  ImageFullViewViewController.swift
//  TouchBase
//
//  Created by deepak on 12/03/18.
//  Copyright © 2018 Parag. All rights reserved.
//

import UIKit
import SDWebImage
class ImageFullViewViewController: UIViewController {
    
    var varGetImageUrl:String!=""
    
    @IBOutlet weak var imageUserImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(varGetImageUrl)
        
      //  let alert = UIAlertController(title: "", message: "Processing...", preferredStyle: .alert)
       // self.present(alert, animated: true, completion: nil)
        
        // change to desired number of seconds (in this case 5 seconds)
//        let when = DispatchTime.now() + 1
//        DispatchQueue.main.asyncAfter(deadline: when){
//            // your code with delay
//            alert.dismiss(animated: true, completion: nil)
//        }
        
        
        imageUserImage.sd_setImage(with: URL(string: varGetImageUrl))
        functionForCreateNavigation()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func functionForCreateNavigation()
    {
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]            
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]  
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(AnnouncementDetailController.backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
        
        let shareButton = UIButton(type: UIButton.ButtonType.custom)
        shareButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        shareButton.setImage(UIImage(named:"share"),  for: UIControl.State.normal)
        shareButton.addTarget(self, action: #selector(ImageFullViewViewController.shareImage), for: UIControl.Event.touchUpInside)
        let sharing: UIBarButtonItem = UIBarButtonItem(customView: shareButton)
        var buttons:NSArray=NSArray()
        buttons = [sharing]
        self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]

    }
    
    @objc func shareImage() {
        let items: [Any] = [imageUserImage.image as Any]
        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    
     @objc func backClicked()
    {
     
            
            self.navigationController?.popViewController(animated: true)
        
    }
}
