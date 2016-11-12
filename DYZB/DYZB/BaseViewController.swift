//
//  BaseViewController.swift
//  DYZB
//
//  Created by xuwenhao on 16/11/11.
//  Copyright © 2016年 xuwenhao. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var naviView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCR_W, height: 64));

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.navigationController != nil) {
            self.navigationController?.navigationBar.isHidden = true;
            self.view .addSubview(naviView);
            naviView.backgroundColor = UIColor.orange;
        }

    
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
    
        
        
    }
    
    
    
    
    



}
