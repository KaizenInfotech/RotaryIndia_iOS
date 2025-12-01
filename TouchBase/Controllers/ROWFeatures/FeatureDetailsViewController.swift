//
//  FeatureDetailsViewController.swift
//  TouchBase
//
//  Created by Harshada on 04/03/20.
//  Copyright © 2020 Parag. All rights reserved.
//

import UIKit

class FeatureDetailsViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var scrollButtonView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var btnPrevious: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    var index:Int=0
    var moduleName:String=""
    var clubImgArray:[Images]=[.CW11,.CW12,.CW13,.CW21,.CW22,.CW23]
    let districtImgArray:[Images]=[.DW1,.DW2]

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 4.0
        scrollView.zoomScale = 1.0
        scrollView.delegate = self as? UIScrollViewDelegate
        functionForSetLeftNavigation()
        showImage()
        scrollButtonView.layer.borderWidth=1.0
        scrollButtonView.layer.borderColor=UIColor(red: 0/255, green: 174/255, blue: 239/255, alpha: 1).cgColor
    }
    
    func functionForSetLeftNavigation()
    {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = "ROW Features" as String
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]
        self.navigationController!.navigationBar.titleTextAttributes = attributes
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.white
         let buttonleft = UIButton(type: UIButton.ButtonType.custom)
        buttonleft.frame = CGRect(x: 0, y: 0, width: 30, height:30)
        buttonleft.setImage(UIImage(named:"back_btn_blue"), for: UIControl.State.normal)
        buttonleft.addTarget(self, action: #selector(backClicked), for: UIControl.Event.touchUpInside)
        let leftButton: UIBarButtonItem = UIBarButtonItem(customView: buttonleft)
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
     @objc func backClicked()
    {
      self.navigationController?.popViewController(animated: true)
    }
    
    func showImage()
    {
        switch moduleName {
        case "Club_Public":
                imageView.image=UIImage(named: Images.cPublic.rawValue)
            break
        case "Club_Comm":
                imageView.image=UIImage(named: Images.cComm.rawValue)
                break
        case "Club_Gov":
                imageView.image=UIImage(named: Images.cGov.rawValue)
                break

        case "District_Public":
                imageView.image=UIImage(named: Images.dPublic.rawValue)
                break
        case "District_Comm":
                imageView.image=UIImage(named: Images.dComm.rawValue)
                break
        case "District_Gov":
                imageView.image=UIImage(named: Images.dGov.rawValue)
                break

        case "DirectLink":
                imageView.image=UIImage(named: Images.DL.rawValue)
                break

        case "Roweb_Club":
            setImageSlides()
                break
        case "Roweb_District":
              setImageSlides()
            break
        default:
            break
        }
    }

    enum Images:String
    {
        case DL="DirectLink.jpg"
        case DW1="DistrictWeb1.png"
        case DW2="Districtweb2.png"
        case CW11="ClubWeb11.png"
        case CW12="ClubWeb12.png"
        case CW13="ClubWeb13.png"
        case CW21="ClubWeb21.png"
        case CW22="ClubWeb22.png"
        case CW23="ClubWeb23.png"
        case cPublic="Public.png"
        case cComm="Communication.jpg"
        case cGov="E-GOVERNANCE.jpg"
        case dPublic="Dist_public.png"
        case dComm="Dis_comm.jpg"
        case dGov="Dis_gov.jpg"
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func setImageSlides()
    {
        scrollButtonView.isHidden=false
        if moduleName=="Roweb_Club"
        {
            imageView.image=UIImage(named: clubImgArray[index].rawValue)
        }
        else if moduleName=="Roweb_District"
        {
            imageView.image=UIImage(named: districtImgArray[index].rawValue)
        }
        if index==0
        {
            btnPrevious.setTitleColor(UIColor.gray, for: .normal)
        }
        else
        {
            btnPrevious.setTitleColor(UIColor(red: 0/255, green: 174/255, blue: 239/255, alpha: 1), for: .normal)
        }

    }

    //MARK:- Click action
    
    @IBAction func previousClickEvent(_ sender: Any) {
        if index > 0
        {
            index=index-1
            setImageSlides()
            btnNext.setTitleColor(UIColor(red: 0/255, green: 174/255, blue: 239/255, alpha: 1), for: .normal)
        }
        
        if index==0
        {
            btnPrevious.setTitleColor(UIColor.gray, for: .normal)
        }
        else
        {
            btnPrevious.setTitleColor(UIColor(red: 0/255, green: 174/255, blue: 239/255, alpha: 1), for: .normal)
        }

    }
    
    @IBAction func nextClickEvent(_ sender: Any) {
        if moduleName=="Roweb_Club"
        {
            if index < clubImgArray.count-1{
            index=index+1
            setImageSlides()
            }
            if index==clubImgArray.count-1
            {
                btnNext.setTitleColor(UIColor.gray, for: .normal)
            }
            else
            {
                btnNext.setTitleColor(UIColor(red: 0/255, green: 174/255, blue: 239/255, alpha: 1), for: .normal)
            }
        }
        else if moduleName=="Roweb_District"
        {
            if index < districtImgArray.count-1{
            index=index+1
            setImageSlides()
            }
            
            if index==districtImgArray.count-1
            {
                btnNext.setTitleColor(UIColor.gray, for: .normal)
            }
            else
            {
                btnNext.setTitleColor(UIColor(red: 0/255, green: 174/255, blue: 239/255, alpha: 1), for: .normal)
            }

        }
        
        if index==0
        {
            btnPrevious.setTitleColor(UIColor.gray, for: .normal)
        }
        else
        {
            btnPrevious.setTitleColor(UIColor(red: 0/255, green: 174/255, blue: 239/255, alpha: 1), for: .normal)
        }

    }
    
}
