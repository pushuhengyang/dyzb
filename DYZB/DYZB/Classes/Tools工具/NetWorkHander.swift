//
//  NetWorkHander.swift
//  DYZB
//
//  Created by xuwenhao on 16/11/15.
//  Copyright © 2016年 xuwenhao. All rights reserved.
//   封装网络请求

import UIKit
import Alamofire

enum MethodType {
    case GET
    case Post
}




class NetWorkHander: NSObject {
   
}

extension NetWorkHander {
    
   

    class func requestData (type: MethodType , urlString : String , parment : [String : AnyObject] , finishedCallBack : @escaping (_ result : AnyObject) ->()){
      
    
        
        let meod = type == .GET ? HTTPMethod.get : HTTPMethod.post
        
   
        
  Alamofire.request(urlString, method: meod, parameters: parment, encoding: JSONEncoding.default, headers: nil).responseJSON { response in

    guard let reques = response.result.value else{ return
    
      print(response.result);
        
    }
    
        finishedCallBack(reques as AnyObject);
        
       }
  
    
    
    
    }
    
    
    
}





