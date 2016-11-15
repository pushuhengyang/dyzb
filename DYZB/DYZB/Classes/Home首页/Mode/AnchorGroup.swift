//
//  AnchorGroup.swift
//  DYZB
//
//  Created by xuwenhao on 16/11/15.
//  Copyr ight © 2016年 xuwenhao. All rights reserved.
//   数据model


import UIKit

class AnchorGroup: NSObject {
    var tag_name : String?
    var icon_name : String?
    
  lazy  var archArry = [AnchorModel]()
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    override func  setValue(_ value: Any?, forKey key: String) {
        
        super.setValue(value, forKey: key);
        
        if key  == "room_list" {
            let arry = value as? Array<Any>;
            for dict in arry!{
                let model = AnchorModel()
                model.setValuesForKeys(dict as! [String : Any]);
              self.archArry.append(model)
            }
            
        }
    }
    
}
