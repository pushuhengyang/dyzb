//
//  PageContentView.swift
//  DYZB
//
//  Created by xuwenhao on 16/11/13.
//  Copyright © 2016年 xuwenhao. All rights reserved.
//   滚动视图

import UIKit

protocol PageContentDelegate :class {
    
    func contentViewScro(contentView :PageContentView , soutIndex : Int, tarIndex : Int , progress : CGFloat ) ;
}



class PageContentView: UIView ,UICollectionViewDelegate,UICollectionViewDataSource,PageTitleDelegate {
   
    var childVcs : [UIViewController]
    let presentViewController :UIViewController
    

    
    
    init(frame: CGRect ,childVcs : [UIViewController] ,presentViewController : UIViewController) {
        self.childVcs = childVcs;
        self.presentViewController = presentViewController;
        
        super.init(frame: frame);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var collecnView : UICollectionView = {
    
        let layout = UICollectionViewFlowLayout();
        layout.itemSize = self.bounds.size;
        layout.minimumLineSpacing = 0.0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = .horizontal;
        
        let collecnView = UICollectionView.init(frame: self.bounds, collectionViewLayout: layout)
        collecnView.showsHorizontalScrollIndicator = false;
        collecnView.bounces = false;
        collecnView.isPagingEnabled = true;
        
        collecnView.scrollsToTop = false;
        collecnView.delegate = self;
        collecnView.dataSource = self;
        
        collecnView.register(UICollectionViewCell.self, forCellWithReuseIdentifier:"cellid");
        
        
        return collecnView;
        
    }()
    
     func setUpUi(){
    
        for childVC in childVcs {
            presentViewController.addChildViewController(childVC);
            
        }
        
        addSubview(collecnView);
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath)
        
        
        for subView in cell.contentView.subviews {
            subView.removeFromSuperview();
            
        }
        
        let childVC = childVcs[indexPath.row];
        
        childVC.view.frame = cell.contentView.bounds;
        cell.contentView.addSubview(childVC.view);
        
        return cell;
    }
    
    
    func scroToIndex(index:Int)  {
        collecnView .scrollToItem(at: NSIndexPath.init(item: index, section: 0) as IndexPath, at:UICollectionViewScrollPosition.left , animated: false);
        
    }
    
  
    var starOffsetX : CGFloat = 0;
    
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        starOffsetX = scrollView.contentOffset.x;
        print(starOffsetX)
    }
    
    
    
    
    weak var delegate : PageContentDelegate?
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
      
        var sourcIndex  = 0;
        var  targetIndex = 0;
        var progress : CGFloat = 0
        
        //获取进度
        
        let offsetX = scrollView.contentOffset.x;
        let ratio = offsetX / scrollView.bounds.width;
        progress = ratio - floor(ratio)
        
        if offsetX > starOffsetX {//左滑动
            sourcIndex = Int(offsetX / scrollView.bounds.width)
            targetIndex = sourcIndex+1;
            if targetIndex >= childVcs.count {
                
                
                
                targetIndex = childVcs.count-1
            }
            
            if offsetX - starOffsetX == scrollView.bounds.width {
                progress = 1.0
                targetIndex = sourcIndex;
            }
            
            
            
        }else{
           
            targetIndex = Int(offsetX / scrollView.bounds.width)
            sourcIndex = targetIndex + 1
            if sourcIndex >= childVcs.count {
                sourcIndex = childVcs.count-1
            }
            progress = 1 - progress;
            
        }
        
        delegate?.contentViewScro(contentView: self, soutIndex: sourcIndex, tarIndex: targetIndex, progress: progress);
        
    }
    
    
    func pageTitleView(pagetitleView: PageTitleView, didselectIndex: NSInteger) {
        
        scroToIndex(index: didselectIndex);
    }
    
    

}
