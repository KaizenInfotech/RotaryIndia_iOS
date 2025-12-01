//
//  RootDashNewCVCell.swift
//  TouchBase
//
//  Created by IOS 2 on 21/09/23.
//  Copyright © 2023 Parag. All rights reserved.
//

import UIKit

protocol DidselectDelegate: AnyObject {
    func didselect(index: Int)
    func tapBanner()
    func nudgeHeight(hgt: CGFloat)
}

class RootDashNewCVCell: UICollectionViewCell {
    
//    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nudgeView: UIView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profilePhotoImgView: UIImageView!
    @IBOutlet weak var profileNameLbl: UILabel!
    @IBOutlet weak var editProfile: UIButton!
    @IBOutlet weak var imgCV: UICollectionView!
    
    @IBOutlet weak var imgBgView: UIView!
    @IBOutlet weak var imgBgViewHeight: NSLayoutConstraint!
    @IBOutlet weak var userProfileEdit: UIButton!
    @IBOutlet weak var collViewHeight: NSLayoutConstraint!
    @IBOutlet weak var collectView: UICollectionView!
    @IBOutlet weak var nudgeViewHeight: NSLayoutConstraint!
    
    var sections = [Section1]()
    var didselectDelegate: DidselectDelegate?
    var nudgeViewHgt: CGFloat?
    var listSyncOnline: Resultus?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        register()
        viewCornerRadius()
    }
    
    func collectionViewHeight() {
        if((listSyncOnline?.groupList?.newGroupList?.count ?? 0) == 0) {
            self.collViewHeight.constant = 0
            self.nudgeViewHeight.constant = 170
            self.imgBgViewHeight.constant = self.nudgeViewHeight.constant - 93
        } else {
            if(((listSyncOnline?.groupList?.newGroupList?.count ?? 0) == 2) || ((listSyncOnline?.groupList?.newGroupList?.count ?? 0) == 1)) {
                self.collViewHeight.constant = 50
                self.nudgeViewHeight.constant = 170 + self.collViewHeight.constant
                self.imgBgViewHeight.constant = self.nudgeViewHeight.constant - 93
            } else if((listSyncOnline?.groupList?.newGroupList?.count ?? 0) > 2) {
                if (((listSyncOnline?.groupList?.newGroupList?.count ?? 0) % 2) == 0) {
                    self.collViewHeight.constant = CGFloat(((listSyncOnline?.groupList?.newGroupList?.count ?? 0) / 2) * 60)
                    self.nudgeViewHeight.constant = 170 + collViewHeight.constant
                    self.imgBgViewHeight.constant = self.nudgeViewHeight.constant - 93
                } else if (((listSyncOnline?.groupList?.newGroupList?.count ?? 0) % 2) != 0) {
                    self.collViewHeight.constant = CGFloat(((listSyncOnline?.groupList?.newGroupList?.count ?? 0) / 2) * 60) + 65
                    self.nudgeViewHeight.constant = 170 + collViewHeight.constant
                    self.imgBgViewHeight.constant = self.nudgeViewHeight.constant - 93
                }
            }
        }
        collectView.reloadData()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        didselectDelegate?.nudgeHeight(hgt: self.nudgeViewHeight.constant)
        print("layoutSubviews--------------------------\(self.nudgeViewHeight)")
    }
    func register() {
        collectView.delegate = self
        collectView.dataSource = self
        imgCV.delegate = self
        imgCV.dataSource = self
        collectView.register(UINib(nibName: "RotaryClubCVCell", bundle: nil), forCellWithReuseIdentifier: "RotaryClubCVCell")
        imgCV.register(UINib(nibName: "BannerImgCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BannerImgCollectionViewCell")
    }
    
    func viewCornerRadius() {
        self.nudgeView.roundCorners([.bottomLeft, .bottomRight], radius: 30)
        self.profileView.layer.cornerRadius = 8
        //        self.imgView.layer.cornerRadius = 16
        self.imgBgView.layer.cornerRadius = 8
        self.profilePhotoImgView.layer.cornerRadius = self.profilePhotoImgView.layer.frame.width / 2
        self.imgBgView.layer.masksToBounds = true
        //        self.imgView.layer.masksToBounds = true
    }
    
    @IBAction func profileBtnAction(_ sender: Any) {
        
    }
    
}

extension RootDashNewCVCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == collectView {
            print("total module-------,\(listSyncOnline?.groupList?.newGroupList?.count ?? 0)")
            return listSyncOnline?.groupList?.newGroupList?.count ?? 0
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RotaryClubCVCell", for: indexPath) as? RotaryClubCVCell
            else { return UICollectionViewCell() }
            if indexPath.section == 0
            {
                UserDefaults.standard.setValue("yes", forKey: "isitFirstTimeForDismissHUD")
                if (listSyncOnline?.groupList?.newGroupList?.count ?? 0)>=0
                {
                    let onlineData = listSyncOnline?.groupList?.newGroupList
                    let imageGroupPicUrl = onlineData?[indexPath.row].grpImg
                    if(imageGroupPicUrl == "")
                    {
                        cell.culbsImgView.image = UIImage(named: "rt_dash_logo")
                    }
                    else
                    {
                        if let checkedUrl = URL(string: imageGroupPicUrl ?? "") {
                            print("image path",checkedUrl)
                            //print("module name", sections[indexPath.section].items?[indexPath.row] ?? "")
                            cell.culbsImgView.sd_setImage(with: checkedUrl, placeholderImage: UIImage(named: "rt_dash_logo"))
                        }
                    }
                    cell.clubsNameLbl.text = onlineData?[indexPath.row].grpName
                }else{
                    cell.culbsImgView.image = UIImage(named: "rt_dash_logo")
                    cell.clubsNameLbl.text = "Sample Data"
                }
                
            }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerImgCollectionViewCell", for: indexPath) as? BannerImgCollectionViewCell
            else { return UICollectionViewCell() }
            cell.imgView.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.moveToBanner))
            cell.imgView.addGestureRecognizer(tap)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectView {
            return CGSize(width: (UIScreen.main.bounds.size.width / 2) - 26, height: 50)
        } else {
            return CGSize(width: UIScreen.main.bounds.size.width - 32, height: 160)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectView {
            if indexPath.section == 0
            {
                didselectDelegate?.didselect(index: indexPath.row)
            }
        }
    }
}

extension RootDashNewCVCell {
    
    @objc func moveToBanner() {
        self.didselectDelegate?.tapBanner()
    }
}

extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11, *) {
            var cornerMask = CACornerMask()
            if(corners.contains(.topLeft)){
                cornerMask.insert(.layerMinXMinYCorner)
            }
            if(corners.contains(.topRight)){
                cornerMask.insert(.layerMaxXMinYCorner)
            }
            if(corners.contains(.bottomLeft)){
                cornerMask.insert(.layerMinXMaxYCorner)
            }
            if(corners.contains(.bottomRight)){
                cornerMask.insert(.layerMaxXMaxYCorner)
            }
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = cornerMask
            
        } else {
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
}
