
    import UIKit
    
    class ShowCaseAlbumListTVC: UITableViewCell {
        
        
        //   @IBOutlet var imageAlbum: UIImageView!
        @IBOutlet var labelTitle: UILabel!
        //   @IBOutlet var viewMain: UIView!
        @IBOutlet weak var lblDetails: UILabel!
        // @IBOutlet var buttonDelete: UIButton!
        
        @IBOutlet weak var didSelectBtnnnnn: UIButton!
        @IBOutlet weak var selectProjBtnnnn: UIButton!
        @IBOutlet weak var lblDate: UILabel!
        @IBOutlet weak var btnDelete: UIButton!
        // @IBOutlet var textviewDescription: UITextView!
        @IBAction func selectProjTypeBtn(_ sender: Any) {
        }
        override func awakeFromNib()
        {
            super.awakeFromNib()
            //        textviewDescription.isScrollEnabled=false
            //        textviewDescription.isUserInteractionEnabled=false
            //        textviewDescription.isEditable=false
            //        textviewDescription.contentInset = UIEdgeInsetsMake(-7.0,-5.0,0,0.0);
            //
            //        imageAlbum.contentMode = .scaleAspectFit
            
            
        }

        
        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
            
            // Configure the view for the selected state
        }
        
}



