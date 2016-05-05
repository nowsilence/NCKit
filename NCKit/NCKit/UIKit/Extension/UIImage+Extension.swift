//
//  UIImage+Extension.swift
//  NCKit
//
//  Created by Nigel Chou on 16/5/2.
//  Copyright © 2016年 BeautyFuture. All rights reserved.
//

import Foundation

extension UIImage {
    
    /// 根据颜色生成一个像素大小的图片
    public class func nck_imageWithColor(color:UIColor)->UIImage
    {
        let size = CGSize(width: 1, height: 1)
        
        UIGraphicsBeginImageContext(size)
        
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(context, color.CGColor)
        
        CGContextFillRect(context, CGRect(origin: CGPointZero, size: size))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image
    }
}