//
//  DY_Color.swift
//  DYZB
//
//  Created by xuwenhao on 16/11/12.
//  Copyright © 2016年 xuwenhao. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static func colorWithString(color:String)->UIColor{
        return UIColor.colorWithString(color: color, alpa: 1);
    }
    static func colorWithString(color:String , alpa : CGFloat)->UIColor{
        
        let colorString : String? = color.hasPrefix("#") ? color.substring(from: color.index(after: color.startIndex)) : color;
        
        if colorString == nil {
            return white;
            
        }
        
        let red = colorString?.substring(to: (colorString?.index((colorString?.startIndex)!, offsetBy: 2))!);
            
        let green = colorString?.substring(with: Range((colorString?.index((colorString?.startIndex)!, offsetBy: 2))!..<(colorString?.index((colorString?.startIndex)!, offsetBy: 4))!));
        
        let blue = colorString?.substring(to: (colorString?.index((colorString?.endIndex)!, offsetBy: -2))!);
        
        
        var r :CUnsignedInt = 0 , g :CUnsignedInt = 0 , b : CUnsignedInt = 0
        
        Scanner.init(string: red!).scanHexInt32(&r);
        Scanner.init(string: green!).scanHexInt32(&g)
        Scanner.init(string: blue!).scanHexInt32(&b)
        
        
        return UIColor.init(red: (CGFloat)(r)/0xff, green: (CGFloat)(g)/0xff, blue: (CGFloat)(b)/0xff, alpha: (alpa >= 0 && alpa <= 1) ? alpa : 1);
        
    }
}
