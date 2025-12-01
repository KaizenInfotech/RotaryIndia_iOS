//
//  PagerViewController.swift
//  TouchBase
//
//  Created by Umesh on 27/09/16.
//  Copyright © 2016 Parag. All rights reserved.
//

import UIKit
class PagerViewController: UIViewController
{
    
     var appDelegate : AppDelegate = AppDelegate()
    var pageIndex :Int?
    var titleText :String?
    var imageFile : UIImage?
    var imageUrl : NSString!
    
    var dropDown_flag = Bool()
    let dropDownView = UIView()

    
    @IBOutlet var scrollDetailView: UIScrollView!
    @IBOutlet var scrollDescription: UIScrollView!
   
    @IBOutlet var ImageDescriptionTextView: UITextView!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var expandDetailView: UIView!
    @IBOutlet var expandImageViewBtn: UIButton!
    @IBAction func expandImageViewBtnAction(_ sender: AnyObject)
    {
        let tag = sender.tag;
        print("tag...\(tag)")
        expandImageViewBtn.isSelected = !expandImageViewBtn.isSelected
        if (expandImageViewBtn.isSelected)
        {
             print(" Selected")
           
            //   expandBtn.setImage(UIImage(named:"down.png"), forState: UIControl.State.Normal)
            //expandImageViewBtn.frame = CGRectMake(expandImageViewBtn.frame.origin.x, expandImageViewBtn.frame.origin.y+100, expandImageViewBtn.frame.size.width, expandImageViewBtn.frame.size.height+200)
           // imageView.frame = CGRectMake(self.imageView.frame.origin.x, self.imageView.frame.origin.y, self.imageView.frame.size.width, self.imageView.frame.size.height+200)
            print("...imageView.frame\(imageView.frame)")

            expandDetailView.frame = CGRect(x: expandDetailView.frame.origin.x, y: scrollDetailView.frame.size.height - self.expandDetailView.frame.size.height , width: self.expandDetailView.frame.size.width, height: self.expandDetailView.frame.size.height)
        }
        else
        {
            print(" Not Selected")
            //  expandBtn.setImage(UIImage(named:"up.png"), forState: UIControl.State.Normal)
           // expandImageViewBtn.frame = CGRectMake(expandImageViewBtn.frame.origin.x, expandImageViewBtn.frame.origin.y, expandImageViewBtn.frame.size.width, expandImageViewBtn.frame.size.height-200)
           // imageView.frame = CGRectMake(self.imageView.frame.origin.x, self.imageView.frame.origin.y, self.imageView.frame.size.width, self.imageView.frame.size.height-200)
            print("...imageView.frame\(imageView.frame)")

            //expandDetailView.frame = CGRectMake(expandDetailView.frame.origin.x, expandDetailView.frame.origin.y-200-10, self.expandDetailView.frame.size.width, self.expandDetailView.frame.size.height)
            
            expandDetailView.frame = CGRect(x: expandDetailView.frame.origin.x, y: scrollDetailView.frame.size.height-100, width: self.expandDetailView.frame.size.width, height: self.expandDetailView.frame.size.height)
            
        }
        
        
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        scrollDetailView.contentMode = .scaleAspectFit
        imageView.sizeToFit()
        scrollDetailView.contentSize = CGSize(width: scrollDetailView.frame.size.width, height: scrollDetailView.frame.size.height)
        
       scrollDescription.contentSize = CGSize(width: self.scrollDescription.frame.size.width, height: self.scrollDescription.frame.size.height+50)
       scrollDetailView.contentSize = CGSize(width: self.scrollDetailView.frame.size.width, height: self.scrollDetailView.frame.size.height)
        
        if let checkedUrl = URL(string: imageUrl as String) {
            appDelegate.getDataFromUrl(checkedUrl) { (data, response, error)  in
                DispatchQueue.main.async { () -> Void in
                    guard let data = data, error == nil else { return }
                    print(response?.suggestedFilename ?? "")
                    print("Download Finished")
                    self.imageView.image  = UIImage(data: data)
                    //  cell.activityLoader.stopAnimating()
                }
            }
        }
        expandDetailView.layer.borderColor = UIColor.lightGray.cgColor
        expandDetailView.layer.borderWidth = 0.5
        ImageDescriptionTextView.text  =  titleText
         // expandDetailView.frame = CGRectMake(expandDetailView.frame.origin.x,scrollDetailView.frame.origin.y + scrollDetailView.frame.size.height - 200, self.expandDetailView.frame.size.width, self.expandDetailView.frame.size.height)
        self.titleLabel.text = ""
        print("....self.titleLabel.text\(self.titleLabel.text)")
        
       
        
        // Do any additional setup after loading the view.
    }
    
    
    func DropDownAction()
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
   

}
 
