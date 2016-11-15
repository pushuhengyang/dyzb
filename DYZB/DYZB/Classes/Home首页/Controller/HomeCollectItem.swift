//
//  HomeCollectItem.swift
//  DYZB
//
//  Created by xuwenhao on 16/11/15.
//  Copyright © 2016年 xuwenhao. All rights reserved.
//

import UIKit

class HomeCollectItem: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()

        imageV.layer.cornerRadius = 3;
        imageV.clipsToBounds = true;
    
    
    }
    
    
    
    @IBOutlet weak var countLb: UILabel!
    @IBOutlet weak var imageV: UIImageView!
        
    @IBOutlet weak var titleLb: UILabel!
    

}
