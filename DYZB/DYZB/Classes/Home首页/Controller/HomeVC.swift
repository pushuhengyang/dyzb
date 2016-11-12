//
//  HomeVC.swift
//  DYZB
//
//  Created by xuwenhao on 16/11/11.
//  Copyright © 2016年 xuwenhao. All rights reserved.
//

import UIKit

class HomeVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI();
        
       
        
        
    }


    func setUI()  {
        let  logoBtn = UIButton.creat(imageName: "logo", heightImageName: "", size: CGSize.init(width: 60, height: 44), target: self, action: #selector(self.logoRefsh));
        logoBtn.center = CGPoint.init(x: 40, y: 44);
        
        let historyBtn = UIButton.creat(imageName: "image_my_history", heightImageName:"Image_my_history_click" , size: CGSize.init(width: 40, height: 40), target: self, action: #selector(self.history))
        historyBtn.center = CGPoint.init(x: SCR_W-3*40, y: 45);
        
        
        let searchBtn = UIButton.creat(imageName: "btn_search", heightImageName:"btn_search_click" , size: CGSize.init(width: 40, height: 40), target: self, action: #selector(self.history))
        
        searchBtn.center = CGPoint.init(x: SCR_W - 40, y: 45);
        
        
        let codeBtn = UIButton.creat(imageName: "Image_scan", heightImageName:"Image_scan_click" , size: CGSize.init(width: 40, height: 40), target: self, action: #selector(self.codeClick))
        
        codeBtn.center = CGPoint.init(x: SCR_W - 2*40, y: 45);
        
        naviView.addSubview(logoBtn);
        naviView.addSubview(historyBtn);
        naviView.addSubview(codeBtn);
        naviView.addSubview(searchBtn);
        
        
    }
    

    
    
    
    func logoRefsh() {
        
    }
    
    func history()  {
        
    }
    
    func search()  {
        
    }
    
    func codeClick()  {
        
    }
    
    
    
}
