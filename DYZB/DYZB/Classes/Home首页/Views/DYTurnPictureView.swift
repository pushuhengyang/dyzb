//
//  DYTurnPictureView.swift
//  DYZB
//
//  Created by xuwenhao on 16/11/16.
//  Copyright © 2016年 xuwenhao. All rights reserved.
//

import UIKit

class DYTurnPictureView: UIView {


    @IBOutlet weak var collV: UICollectionView!

    @IBOutlet weak var pageV: UIPageControl!
    
    var turnModes = [DYTurnPicModel]()

    var timer : Timer?
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib();
        
        autoresizingMask = UIViewAutoresizing.init(rawValue: 0);
        
        collV.register(UINib.init(nibName: "DYPageTurnCell", bundle: nil), forCellWithReuseIdentifier: "DYPageTurnCell")
        collV.isPagingEnabled = true
    
    }
    
    override func layoutSubviews() {
        let layout = collV.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = self.bounds.size;
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
    }
    
    
    func reReshLoadData(dataArry : [DYTurnPicModel])  {
        self.turnModes = dataArry;
        collV.reloadData();
        pageV.hidesForSinglePage = true
        pageV.numberOfPages = dataArry.count;
        pageV.currentPage=0
        pageV.currentPageIndicatorTintColor = UIColor.orange;
        pageV.pageIndicatorTintColor = UIColor.white.withAlphaComponent(0.3)
        collV.scrollToItem(at: IndexPath.init(item: 0, section: 60), at: .left, animated: false)
        addCycTimer()
//        DispatchQueue.main.sync {
//            collV.scrollToItem(at: IndexPath.init(item: 0, section: 60), at: .left, animated: false)
//        }
        
    }
    
    class func dyTurnView() -> DYTurnPictureView {
        
        return Bundle.main.loadNibNamed("DYTurnPictureView", owner: nil, options: nil)!.first as! DYTurnPictureView
        
    }
    
    
}

extension DYTurnPictureView : UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.turnModes.count == 0 ? 0 :1000;
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (turnModes.count);
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DYPageTurnCell", for: indexPath) as! DYPageTurnCell
        
        let  model = turnModes[indexPath.item]
        cell.imageV.kf.setImage(with: URL.init(string: (model.pic_url)), placeholder: UIImage.init(named: "live_cell_default_phone"), options: nil, progressBlock: nil, completionHandler: nil);
        
        
        
        return cell;
    }

}

extension DYTurnPictureView :UICollectionViewDelegate { //这个继承自scroview
    

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let  off_x = scrollView.contentOffset.x
        pageV.currentPage = Int((off_x/SCR_W + 0.5).truncatingRemainder(dividingBy: 6.0))
      
    }
    
    
}

extension DYTurnPictureView {
     func addCycTimer(){
        if timer != nil{
            removeTime();
        }
        
        timer = Timer.init(timeInterval: 3, target: self, selector: #selector(self.turnNext), userInfo: nil, repeats: true)
    RunLoop.main.add(timer!, forMode: .defaultRunLoopMode)
        
        
    }
    
    
    private func removeTime(){
        if timer !=  nil{
            timer?.invalidate();
            timer = nil
        }
    }
    
      @objc  private func turnNext(){
        
        let off_x = collV.contentOffset.x + self.bounds.width/2
        let index = Int(off_x/self.bounds.width)
        
        if (index + 10 > numberOfSections(in: collV) * collectionView(collV, numberOfItemsInSection: 0)) || index < 10  {
            collV.scrollToItem(at: IndexPath.init(item: 0, section: 60), at: .left, animated: false)
            pageV.currentPage = 0
            return
        }
        
    
    collV.scrollRectToVisible(CGRect.init(x: (CGFloat)(index+1) * self.bounds.width, y: 0, width: self.bounds.width, height: self.bounds.height), animated: true)
        
    
   
    }
    
    
}








