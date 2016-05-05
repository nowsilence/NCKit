//
//  UIButton+Align.swift
//  Snippet
//
//  Created by Nigel Chou on 16/5/1.
//  Copyright © 2016年 BeautyFuture. All rights reserved.
//

import UIKit

extension UIButton {
    
    /// 水平布局，设置图片和文字之间的距离
    public func nck_hAlign(spacing: CGFloat)
    {
        let insetAmount:CGFloat = spacing / 2.0
        
        self.imageEdgeInsets = UIEdgeInsetsMake(0, -insetAmount, 0, insetAmount)
        
        self.titleEdgeInsets = UIEdgeInsetsMake(0, insetAmount, 0, -insetAmount)
    }

    /// 垂直布局，设置图片和文字之间的距离
    public func nck_vAlign(spacing mGap: CGFloat, topSpacing tGap: CGFloat)
    {
        guard let _ = self.imageView?.image else { return }
        
        let imageSize = self.imageView!.image!.size
        
        self.titleEdgeInsets = UIEdgeInsetsMake(tGap,
                                                -imageSize.width,
                                                -(imageSize.height + mGap + tGap),
                                                0)
        var titleSize:CGSize
        
        if Float(UIDevice.currentDevice().systemVersion) >= 8 {
            
            let title:NSString = self.titleForState(self.state)!
            
            titleSize = title .sizeWithAttributes([NSFontAttributeName: self.titleLabel!.font])
        }
        else {
            
            titleSize = self.titleLabel!.frame.size
        }
        
        self.imageEdgeInsets = UIEdgeInsetsMake(tGap - (titleSize.height + mGap), 0, -tGap, -titleSize.width);
    }
}