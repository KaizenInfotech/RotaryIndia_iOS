//
//  MediaPhotoViewController.swift
//  TouchBase
//
//  Created by Harshada on 24/04/20.
//  Copyright © 2020 Parag. All rights reserved.
//

import UIKit

class MediaPhotoViewController: UIViewController {


    @IBOutlet weak var mediaFullImageView: UIImageView!
//    @IBOutlet weak var lblDesc: UILabel!
      @IBOutlet weak var textViewDesc: UITextView!
      @IBOutlet weak var descView: UIView!
    
    var mediaPhotoPath:String=""
    var mediaDesc:String=""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden=true
        self.navigationItem.setHidesBackButton(true, animated: false)
        if let ImageProfilePic:String = mediaPhotoPath as? String{
            let checkedUrl = URL(string: ImageProfilePic)
            mediaFullImageView.sd_setImage(with: checkedUrl)
            textViewDesc.text=mediaDesc
            if mediaDesc.count<40
            {
                textViewDesc.textAlignment = .center
            }
            else
            {
                textViewDesc.textAlignment = .justified
            }
        }
    }

    @IBAction func btnDoneClickAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnShareClickAction(_ sender: Any) {
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [mediaFullImageView.image], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView=self.view
        self.present(activityViewController, animated: true, completion: nil)

    }

    @IBAction func btnImageToggleClick(_ sender: Any) {
     self.descView.isHidden = !self.descView.isHidden
    }

}
