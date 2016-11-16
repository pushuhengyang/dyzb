//
//  AnchorModel.swift
//  DYZB
//
//  Created by xuwenhao on 16/11/15.
//  Copyright © 2016年 xuwenhao. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    
    var vertical_src : String = ""
    var owner_uid : String = ""
  //  var ranktype : String?
    var nickname : String = ""
    var room_src : String = ""
    var specific_status : String = ""
    var game_name : String = ""
    var avatar_small : String = ""
    var online : NSNumber?
    var avatar_mid : String = ""
    var room_name : String = ""
    var room_id : String = ""
    var child_id : String = ""
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }

    override func setValue(_ value: Any?, forKey key: String) {
            super.setValue(value, forKey: key);
      
        
    }
    
    
}
