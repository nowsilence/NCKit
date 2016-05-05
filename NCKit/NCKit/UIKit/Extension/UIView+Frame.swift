//
//  UIView+Frame.swift
//  NCKit
//
//  Created by Nigel Chou on 16/4/20.
//  Copyright © 2016年 BeautyFuture. All rights reserved.
//

import UIKit

extension UIView {
    
    public var nck_x:CGFloat {
    
        get { return self.frame.origin.x }
        
        set { self.frame.origin.x = newValue }
    }
    
    public var nck_y:CGFloat {
        
        get { return self.frame.origin.y }
        
        set { self.frame.origin.y = newValue }
    }
    
    public var nck_origin:CGPoint {
    
        get { return self.frame.origin }
        
        set { self.frame.origin = newValue }
    }
    
    public var nck_size:CGSize {
    
        get { return self.frame.size }
        
        set { self.frame.size = newValue }
    }
    
    public var nck_maxX:CGFloat {
    
        get { return CGRectGetMaxX(self.frame) }
        
        set { self.frame.origin.x = newValue - self.frame.size.width }
    }
    
    public var nck_maxY:CGFloat {
        
        get { return CGRectGetMaxY(self.frame) }
        
        set { self.frame.origin.y = newValue - self.frame.size.height }
    }
    
    public var nck_width:CGFloat {
    
        get { return self.frame.size.width }
        
        set { self.frame.size.width = newValue }
    }
    
    public var nck_height:CGFloat {
    
        get { return self.frame.size.height }
        
        set { self.frame.size.height = newValue }
    }
    
    public var nck_anchorPoint:CGPoint {
        
        get {
        
            let anchor = self.layer.anchorPoint
            
            return CGPointMake(anchor.x * self.nck_width, anchor.y * self.nck_height)
        }
        
        set {
        
            let anchor = CGPointMake(newValue.x / self.nck_width, newValue.y / self.nck_height)
            
            let oldOrigin = self.frame.origin
            
            self.layer.anchorPoint = anchor
            
            let newOrigin = self.frame.origin
            
            let transition = CGPointMake(newOrigin.x - oldOrigin.x, newOrigin.y - oldOrigin.y)
            
            self.center = CGPointMake(self.center.x - transition.x, self.center.y - transition.y)
        }
    }
    
    public func nck_setXY(x:CGFloat, _ y:CGFloat)
    {
        self.frame.origin = CGPointMake(x, y)
    }
}