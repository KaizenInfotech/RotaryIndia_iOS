//
//  ModuleCollectionViewLayout.swift
//  TouchBase
//
//  Created by Umesh on 24/12/15.
//  Copyright © 2015 Parag. All rights reserved.
//

import UIKit

class ModuleCollectionViewLayout: UICollectionViewFlowLayout {
    let bounds = UIScreen.main.bounds
    //  let width1 = bounds.size.width
    let itemWidth =  110
    let itemSpacing: CGFloat = 10
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
        self.itemSize = CGSize(width: ((bounds.size.width/2)-10), height: ((bounds.size.width/2)-10))
        self.minimumInteritemSpacing = 5
        self.minimumLineSpacing = itemSpacing
        self.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5);
        self.scrollDirection = UICollectionView.ScrollDirection.vertical
        
    }
    override func prepare() {
        //        layoutInfo = [NSIndexPath:UICollectionViewLayoutAttributes]()
        //        for var i = 0; i < self.collectionView?.numberOfItemsInSection(0); i++ {
        //            let indexPath = NSIndexPath(forRow: i, inSection: 0)
        //            let itemAttributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        //            itemAttributes.frame = frameForItemAtIndexPath(indexPath)
        //            if itemAttributes.frame.origin.x > maxXPos {
        //                maxXPos = itemAttributes.frame.origin.x
        //            }
        //            layoutInfo[indexPath] = itemAttributes
        //        }
    }

}
