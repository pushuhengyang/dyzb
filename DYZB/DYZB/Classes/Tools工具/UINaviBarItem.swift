//
//  UINaviBarItem.swift
//  DYZB
//
//  Created by xuwenhao on 16/11/12.
//  Copyright © 2016年 xuwenhao. All rights reserved.
//

import UIKit


extension UIBarButtonItem {
   
    convenience init(imageName : String, heightImageName: String = "", size :CGSize = CGSize.zero , target : AnyObject? = nil ,action : Selector? = nil){
    
        let btn = UIButton.init(type: UIButtonType.custom);
        btn.setImage(UIImage.init(named: imageName), for: UIControlState.normal);
        
        if (heightImageName != "") {
            btn.setImage(UIImage.init(named: heightImageName), for: .highlighted
            );
        }
        
        if (size != CGSize.zero) {
            btn.frame = CGRect.init(origin: CGPoint.zero, size: size);
            
        }
        
        btn.addTarget(target, action: action!, for: .touchUpInside);
        
         self.init(customView: btn);
    }
    
    
    
}
