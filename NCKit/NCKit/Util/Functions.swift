//
//  Functions.swift
//  NCKit
//
//  Created by Nigel Chou on 16/4/20.
//  Copyright © 2016年 BeautyFuture. All rights reserved.
//

import Foundation

//MARK: - CGRrect相关
public func nck_r(x:CGFloat, _ y:CGFloat, _ w:CGFloat, _ h:CGFloat)->CGRect
{
    return CGRectMake(x, y, w, h)
}

public func nck_r(x:CGFloat, _ y:CGFloat, _ size:CGSize)->CGRect
{
    return CGRectMake(x, y, size.width, size.height)
}

public func nck_r(origin:CGPoint, _ size:CGSize)->CGRect
{
    return CGRectMake(origin.x, origin.y, size.width, size.height)
}

public func nck_p(x:CGFloat, _ y:CGFloat)->CGPoint
{
    return CGPointMake(x, y);
}

//MARK: - RGB颜色
public func nck_rgb(rgb:Int)->UIColor
{
    let r = (CGFloat((rgb & 0xFF0000) >> 16)) / 255
    
    let g = (CGFloat((rgb & 0xFF00) >> 8)) / 255
    
    let b = (CGFloat(rgb & 0xFF)) / 255
    
    return UIColor.init(red: r, green: g, blue: b, alpha: 1)
}

