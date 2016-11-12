//
//  PageTitleView.swift
//  DYZB
//
//  Created by xuwenhao on 16/11/12.
//  Copyright © 2016年 xuwenhao. All rights reserved.
//

/*
 1 标题颜色渐变 滑块可滑动
 2 点击 移动
 3 接口传出来
 
 */

import UIKit

private let kNormalRGB : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectRGB : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)
private let kDeltaRGB = (kSelectRGB.0 - kNormalRGB.0, kSelectRGB.1 - kNormalRGB.1, kSelectRGB.2 - kNormalRGB.2)
private let kNormalTitleColor = UIColor(red: 85/255.0, green: 85/255.0, blue: 85/255.0, alpha: 1.0)
private let kSelectTitleColor = UIColor(red: 255.0/255.0, green: 128/255.0, blue: 0/255.0, alpha: 1.0)





class PageTitleView: UIView {

    var  isScroEnable :Bool
    var  titleArry  : [String]
    
    
    
    
    init(frame :CGRect, isScroEnable : Bool ,titles : [String]){
        self.isScroEnable = isScroEnable;
        self.titleArry = titles;
        super.init(frame: frame);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var scroView : UIScrollView = {
        let  scroV = UIScrollView.init(frame: self.bounds);
        scroV.showsHorizontalScrollIndicator = false;
        scroV.bounces = false;
        scroV.scrollsToTop = false;
        return scroV;
    }();
    
    private lazy var scroLine : UIView = {
        let scroLine = UIView();
        
        scroLine.backgroundColor = kNormalTitleColor;

        return scroLine;
    }()
    
    func setUpUI()  {
        addSubview(scroView);
      
        setUpTitleLable();
        
       
        
    }
    
    private func setUpTitleLable(){
    
        let titleY :CGFloat = 0;
        let titleH = bounds.height - 2;
        let maxNum = 5;
        
        let  count = titleArry.count;
        
        
        for (index,titile) in titleArry.enumerated() {
            let lable = UILabel();
            
            var titleW :CGFloat = 0;

            titleW = SCR_W / CGFloat (count);

            if self.isScroEnable {
                if count > maxNum {
                    titleW = SCR_W / CGFloat(maxNum);
                    
                
            }
            
            
           lable.frame = CGRect.init(x:CGFloat(index) * titleW, y: titleY, width: titleW, height: titleH)
            
                scroView.addSubview(lable);
                
                lable.isUserInteractionEnabled = true;
                
                let tapGe = UITapGestureRecognizer.init(target: self
                    , action: #selector(self.tapGes(tap:)))
                lable.addGestureRecognizer(tapGe)
            
                lable.text = titile;
                
        }

    }
    
  
}




    func tapGes (tap :UITapGestureRecognizer ){
        
        
     }
    
    
    
    
    

}
