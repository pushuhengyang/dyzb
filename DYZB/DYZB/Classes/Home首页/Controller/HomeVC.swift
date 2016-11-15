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

    var contextView : PageContentView?
    var titleView : PageTitleView?
    
    

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
        
        titleView = PageTitleView.init(frame: CGRect.init(x: 0, y: 64, width: SCR_W, height: 40), isScroEnable: false, titles: ["推荐","游戏","娱乐","手游","趣玩"]);
        titleView?.setUpUI();
        self.view.addSubview(titleView!);
        
        var childsArry = [UIViewController]();
        for _ in 0..<5 {
            let vc = HomeContextViewController();
            //vc.view.backgroundColor = UIColor.clear
            
            childsArry.append(vc);
            
        }
        
        
        
        
        contextView = PageContentView.init(frame: CGRect.init(x: 0, y: (titleView?.frame.maxY)!, width: SCR_W, height: SCR_H-(titleView?.frame.maxY)!), childVcs: childsArry, presentViewController: self);
        contextView?.setUpUi();
        self.view.addSubview(contextView!);
        titleView?.delegate = contextView;
        contextView?.delegate = titleView;
        
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
