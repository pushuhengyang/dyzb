//
//  HomeContextViewController.swift
//  DYZB
//
//  Created by xuwenhao on 16/11/15.
//  Copyright © 2016年 xuwenhao. All rights reserved.
//   滚动的view

import UIKit
import Kingfisher




class HomeContextViewController: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegate {

    let kItemMargin : CGFloat = 10;
    let kItemW : CGFloat = (SCR_W - 3 * 10) / 2
    let kTrunH : CGFloat = 150
    private lazy var collectionV : UICollectionView = { [unowned self] in
    
        let layout = UICollectionViewFlowLayout.init();
        layout.itemSize = CGSize.init(width: self.kItemW, height: self.kItemW*3/4)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 10
        layout.headerReferenceSize = CGSize.init(width: SCR_W, height: 50);
        layout.sectionInset=UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
        
    
        let collectionV = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: SCR_W, height: SCR_H - 64  - 40), collectionViewLayout: layout)
      
        collectionV.addSubview(self.turnPicView)
        collectionV.contentInset = UIEdgeInsets.init(top: self.kTrunH, left: 0, bottom: 49, right: 0)
        collectionV.register(UINib.init(nibName: "HomeCollectItem", bundle: nil), forCellWithReuseIdentifier: "HomeCollectItem")
        
        collectionV.register(UINib.init(nibName: "CollectHeadView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CollectHeadView")
        collectionV.backgroundColor = UIColor.white

        collectionV.delegate = self;
        collectionV.dataSource = self;
        
        return collectionV;
    
    
    }()
    
    private lazy var turnPicView : DYTurnPictureView = {
        let turnPicView = DYTurnPictureView.dyTurnView();
        turnPicView.frame = CGRect.init(x: 0, y: -self.kTrunH, width: SCR_W, height: self.kTrunH)
        
        
        return turnPicView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(collectionV);
        //获取数据
        
        self.getData();
    
        
    }
    
    let recom = RecomendModel();

    
    func getData(){
    
        recom.requestData {
            
            self.collectionV.reloadData();
            
        }
        
        recom.getTurnData {
            
            self.turnPicView.reReshLoadData(dataArry: self.recom.turnModels);
            
        }

    }
    
    
    

    
    
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recom.anchorGroups.count == 0 ? 0 :  2+recom.anchorGroups.count ;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
         return   recom.hotAnchorGroup.archArry.count
        case 1:
            return   4

        case 2...recom.anchorGroups.count+1 :
            
            
                let grop :AnchorGroup =  recom.anchorGroups[section-2]
                return grop.archArry.count;
            
            
            
            
        default:
            return 0
        }
    }
    
  
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind==UICollectionElementKindSectionHeader{
            let headV = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectHeadView", for: indexPath) as! CollectHeadView;
            
            var grop : AnchorGroup;
            var imgName : String;
            
            if indexPath.section==0{
                grop = recom.hotAnchorGroup;
                imgName = "home_header_hot"
            }else if indexPath.section == 1{
                grop = recom.prettyAnchorGroup
                imgName = "home_header_phone"
            }else{
                grop = recom.anchorGroups[indexPath.section-2]
                imgName = "home_header_normal"
            }
            
            headV.titileV.text = grop.tag_name;
            
            headV.imageV.image = UIImage.init(named: imgName);
            
            return headV;
        }
    
        return UIView.init() as! UICollectionReusableView;
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectItem", for: indexPath) as! HomeCollectItem
        
        var grop : AnchorGroup;
        if indexPath.section==0{
            grop = recom.hotAnchorGroup;
        }else if indexPath.section == 1{
            grop = recom.prettyAnchorGroup
        }else{
            grop = recom.anchorGroups[indexPath.section-2]
        }
        
        let model : AnchorModel = grop.archArry[indexPath.item]
        
        cell.imageV.kf.setImage(with:URL.init(string: model.room_src) , placeholder: UIImage.init(named: "live_cell_default_phone"), options: nil, progressBlock: nil, completionHandler: nil);
        cell.countLb.text = "\(model.online!.intValue)"
        cell.titleLb.text = "\(model.room_name)"
        return cell;
   
    }


}
