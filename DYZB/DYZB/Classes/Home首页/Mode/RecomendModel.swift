//
//  RecomendModel.swift
//  DYZB
//
//  Created by xuwenhao on 16/11/15.
//  Copyright © 2016年 xuwenhao. All rights reserved.
//  暂时放这里吧 获取数据的类

import UIKit

class RecomendModel: NSObject {
    lazy var anchorGroups = [AnchorGroup]()
     lazy var hotAnchorGroup = AnchorGroup();
     lazy var prettyAnchorGroup = AnchorGroup();
     lazy var turnModels = [DYTurnPicModel]()
    
}

extension RecomendModel {
    func requestData(recomendData : @escaping ()->())  {
        
    //处理数据闭包
        func parserData(result : AnyObject) -> [[String : NSObject]]? {
            guard let resultDict = result as? [String : NSObject] else {
                return nil;
            }
            
            //取出 data 数据
            return resultDict["data"] as? [[String : NSObject]]
            
        }
    
    
        //请求热门数据
//        
        let group = DispatchGroup()
        group.enter();
        
        
            NetWorkHander.requestData(type: .Post, urlString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parment: ["time" : NSDate.getNowTimeString() as AnyObject], finishedCallBack: { [weak self] result in
                //解析字典
               guard let dicArry = parserData(result: result) else{return}
                self?.hotAnchorGroup.tag_name = "热门"
                self?.hotAnchorGroup.icon_name = "home_header_hot"
             
                var temArry = [AnchorModel]()
                for dict in dicArry{
                    
                    let mode = AnchorModel()
                    mode.setValuesForKeys(dict);
                    temArry.append(mode);
                    
                }
                self?.hotAnchorGroup.archArry = temArry;
                
                group.leave();
                
            })
        
        
        group.enter();
        
        //请求 颜值数据
            NetWorkHander .requestData(type: .Post, urlString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parment: ["limit" : "6" as AnyObject , "offset" : "0" as AnyObject , "time" : NSDate.getNowTimeString() as AnyObject], finishedCallBack: {[weak self] result in
            
                guard let dictArray = parserData(result: result) else { return }

                self?.prettyAnchorGroup.tag_name = "颜值"
                self?.prettyAnchorGroup.icon_name = "home_header_phone"
                
                var temArry = [AnchorModel]()

                for dict in dictArray{
                    let mode = AnchorModel()
                    print(dict)
                    
                    mode.setValuesForKeys(dict);
                    temArry.append(mode);
                }
                self?.prettyAnchorGroup.archArry = temArry;

                group.leave();

            })
        
        
        group.enter();
        NetWorkHander.requestData(type: .Post, urlString: "http://capi.douyucdn.cn/api/v1/getHotCate", parment: ["limit": "4" as AnyObject, "offset" : "0" as AnyObject ,"time" : NSDate.getNowTimeString() as AnyObject], finishedCallBack: { [weak self] result in
        
            guard let dicArry = parserData(result: result) else{
                return;
            }
            
            for dict in dicArry{
                let grop = AnchorGroup();
                
                
              grop.setValuesForKeys(dict);
                
                if grop.archArry.count == 0 {
                    continue
                }
                
               self?.anchorGroups.append(grop)
            }
            
            group.leave();
        
        })
        

        
        
        group.notify(queue: DispatchQueue.main, execute:
            {
            
                
                recomendData();
                
                print("haha2");
                
        })
        
      
    
    
    }
    
    
    
}

extension NSDate {
    class func getNowTimeString() -> String {
        let time = (Int)(NSDate().timeIntervalSince1970);
        return "\(time)"
    }
}


//获取轮播图数据
extension RecomendModel {
    func getTurnData(finishedCallBack : @escaping () -> ())  {
        NetWorkHander.requestData(type: .GET, urlString: "http://www.douyutv.com/api/v1/slide/6?version=2.401", parment: nil, finishedCallBack:{ [weak self] request in
            guard request is [String : AnyObject] else{return}
        
            guard let dataArry = request["data"] as? [[String : NSObject]]else{return}
            
            for dict in dataArry{
                let turnModel = DYTurnPicModel.init(dict: dict)
                 self?.turnModels.append(turnModel)
            }
    
            finishedCallBack();
            
            
        })
    
    
    }
    
    
}






