//
//  CustomCollectionViewLayout.swift
//  TouchBase
//
//  Created by Umesh on 21/12/15.
//  Copyright © 2015 Parag. All rights reserved.
//

import UIKit

class CustomCollectionViewLayoutForDetail: UICollectionViewFlowLayout {
    
    let bounds = UIScreen.main.bounds
   //  let width1 = bounds.size.width
    let itemWidth =  110
    let itemSpacing: CGFloat = 0
    var layoutInfo: [IndexPath:UICollectionViewLayoutAttributes] = [IndexPath:UICollectionViewLayoutAttributes]()
    var maxXPos: CGFloat = 0
    
   // var custcl:CustomCollectionViewCell!
    override init() {
        super.init()
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }
    
    func setup() {
        // setting up some inherited values
        //self.itemSize = CGSize(width: ((bounds.size.width/3)), height: ((bounds.size.width/3)))
        self.itemSize = CGSize(width:100, height: 100)
        self.minimumInteritemSpacing = 0
        self.minimumLineSpacing = 0
        self.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 5);
        self.scrollDirection = UICollectionView.ScrollDirection.vertical
    }
}
