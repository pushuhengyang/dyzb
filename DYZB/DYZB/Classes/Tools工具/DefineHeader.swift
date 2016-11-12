//
//  DefineHeader.swift
//  DYZB
//
//  Created by xuwenhao on 16/11/12.
//  Copyright © 2016年 xuwenhao. All rights reserved.
//

import UIKit

let SCR_W = UIScreen.main.bounds.size.width
let SCR_H = UIScreen.main.bounds.size.height

func RGBCOLOR(red:Float,green:Float,blue:Float) -> UIColor {
    return UIColor.init(colorLiteralRed: red/255, green: green/255, blue: blue/255, alpha: 1);
    
}

func IMGname(name:String)->UIImage{
    return UIImage.init(named: name)!;
    
}


func ColorWithString(color:String)->UIColor{
    return UIColor.colorWithString(color: color);
}
