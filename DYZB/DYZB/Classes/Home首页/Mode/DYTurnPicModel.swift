//
//  DYTurnPicModel.swift
//  DYZB
//
//  Created by xuwenhao on 16/11/16.
//  Copyright © 2016年 xuwenhao. All rights reserved.
// 轮播图model

import UIKit

class DYTurnPicModel: NSObject {

    var title : String = ""
    var pic_url : String = ""
    var anchor : AnchorModel?
    
    var room : [String : NSObject]?{
        didSet(dict){
            
            
            guard dict != nil else {
                return
            }

            anchor = AnchorModel()
            anchor?.setValuesForKeys(dict!);

        }
    }
    
    
    init(dict : [String : NSObject]) {
        super.init();
        setValuesForKeys(dict);
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
