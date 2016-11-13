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

//点击协议
protocol PageTitleDelegate :class{
    func pageTitleView(pagetitleView : PageTitleView ,didselectIndex : NSInteger)    ;
    
}







private let kNormalRGB : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectRGB : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)
private let kDeltaRGB = (kSelectRGB.0 - kNormalRGB.0, kSelectRGB.1 - kNormalRGB.1, kSelectRGB.2 - kNormalRGB.2)
private let kNormalTitleColor = UIColor(red: 85/255.0, green: 85/255.0, blue: 85/255.0, alpha: 1.0)
private let kSelectTitleColor = UIColor(red: 255.0/255.0, green: 128/255.0, blue: 0/255.0, alpha: 1.0)





class PageTitleView: UIView,PageContentDelegate {

    var  isScroEnable :Bool
    var  titleArry  : [String]
    let bottomLineHight :CGFloat =  2;
    var titleLableArry = [UILabel]()
    var titleLong = [CGFloat]();
    var cureIndex  : Int = 0;

    
    
    init(frame :CGRect, isScroEnable : Bool ,titles : [String]){
        self.isScroEnable = isScroEnable;
        self.titleArry = titles;
        titleLableArry = [UILabel]();
        
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
        setupBottomLine();
       
        
    }
    
    private func setUpTitleLable(){
    
        let titleY :CGFloat = 0;
        let titleH = bounds.height - bottomLineHight;
        let  count = titleArry.count;
        cureIndex = 0;
        
        for (index,titile) in titleArry.enumerated() {
            let lable = UILabel();
            lable.text = titile;
            lable.tag = index+100;
            lable.textAlignment = .center;
            lable.font = UIFont.systemFont(ofSize: 16);
            
            titleLableArry
                .append(lable);
            var titleW :CGFloat = 0;
            var titleX :CGFloat = 0;
            


            if !isScroEnable {
                titleW = bounds.width / CGFloat(count);
                titleX = CGFloat(index) * titleW;
                
            }else{
                let size = (titile as NSString).boundingRect(with: CGSize.init(width: Double(MAXFLOAT), height: 0.0), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName : lable.font], context: nil).size;
                titleW = size.width;
                if (index != 0) {
                    titleX = (titleLableArry[index-1].frame.maxX);
                    
                }
                
            }
            
            
           lable.frame = CGRect.init(x:titleX , y: titleY, width: titleW, height: titleH)
            
                scroView.addSubview(lable);
                
                lable.isUserInteractionEnabled = true;
                
                let tapGe = UITapGestureRecognizer.init(target: self
                    , action: #selector(self.tapGes(tap:)))
                lable.addGestureRecognizer(tapGe)
            
    }

}


    private func setupBottomLine(){
        let bottomLine = UIView();
        bottomLine.frame = CGRect.init(x: 0, y: bounds.height-bottomLineHight, width: bounds.width, height: bottomLineHight);
        bottomLine.backgroundColor = UIColor.clear;
        addSubview(bottomLine);
        
        //添加滑块
        addSubview(scroLine);
        guard let firstLabel = titleLableArry.first else {
            return
        }
        
        let lineX = firstLabel.frame.origin.x;
        let lineY = bounds.height - bottomLineHight;
        let lineW = firstLabel.frame.width;
        let lineH = bottomLineHight;
        scroLine.frame = CGRect.init(x: lineX, y: lineY, width: lineW, height: lineH);
        scroLine.backgroundColor = kSelectTitleColor;
        firstLabel.textColor = kSelectTitleColor;
        
    }

    weak  var delegate : PageTitleDelegate?
    
    
    func tapGes (tap :UITapGestureRecognizer ){
        
        guard let view = tap.view else {
            return
        }
        
        let index = view.tag-100
    
        scrollToIndex(index: index);
        
        delegate?.pageTitleView(pagetitleView: self, didselectIndex: index)
  
     }
    
    
    
    
    private func scrollToIndex(index: Int){
        let newLable = titleLableArry[index];
        let  oldLable  = titleLableArry[cureIndex]
        newLable.textColor = kSelectTitleColor;
        oldLable.textColor = kNormalTitleColor;
        let scroLineEndX = newLable.frame.minX;
        let scroLindW = newLable.frame.width;
        UIView.animate(withDuration: 0.2, animations: {
            self.scroLine.frame.origin.x = scroLineEndX;
            self.scroLine.frame.size.width = scroLindW;
        })
        
        cureIndex = index;
    
    }
    

    func contentViewScro(contentView: PageContentView, soutIndex: Int, tarIndex: Int, progress: CGFloat) {
        
        let sourLable = titleLableArry[soutIndex];
        let targeLable = titleLableArry[tarIndex];
        let moveMargin = targeLable.frame.origin.x - sourLable.frame.origin.x;
        var newPross = progress;
        
        scroLine.frame.origin.x = sourLable.frame.origin.x + moveMargin * progress;
     
        
        if(soutIndex == tarIndex){
            newPross = 1.0;
        }else{
            sourLable.textColor = UIColor.init(red: (kSelectRGB.0 - kDeltaRGB.0 * newPross) / 255.0, green: (kSelectRGB.1 - kDeltaRGB.1 * newPross) / 255.0, blue: (kSelectRGB.2 - kDeltaRGB.2 * newPross) / 255.0, alpha: 1.0)
            
            
        
        }
        
        
        targeLable.textColor = UIColor.init(red: (kNormalRGB.0 + kDeltaRGB.0 * newPross)/255.0, green: (kNormalRGB.1 + kDeltaRGB.1 * newPross)/255.0, blue: (kNormalRGB.2 + kDeltaRGB.2 * newPross)/255.0, alpha: 1.0)
        
        
   
        
  
     
        
        
        
        
        
        
    }
}
