//
//  NCGridView.swift
//  NCKit
//
//  Created by Nigel Chou on 16/4/30.
//  Copyright © 2016年 BeautyFuture. All rights reserved.
//

import UIKit


public class NCKGridItem : NSObject {
    
    public var name:String = ""
    
    public var icon:String?
    
    public var userInfo:AnyObject?
    
    public override init(){}
}

public class NCKGridView: UIView {

    public var _delegate:NCKGridViewDelegate?
    
    /// 分割线的颜色，同时也是选中颜色
    public var _lineColor = UIColor(red: 0.883, green: 0.883, blue: 0.883, alpha: 1)
    {
        didSet{
            
            for item  in _buttonArray {
                
                let button = item as! UIButton
                
                button.setBackgroundImage(UIImage.nck_imageWithColor(_lineColor), forState: .Highlighted)
            }
            
            self.setNeedsDisplay()
        }
    }
    
    /// 分割线的宽
    public var _lineWith = 0.5
    {
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    /// 文字字体大小
    public var _font = UIFont.systemFontOfSize(12)
    {
        didSet{
            
            for item  in _buttonArray {
                
                let button = item as! UIButton
                
                button.titleLabel?.font = _font
            }
        }
    }
    
    var _items:Array<NCKGridItem>?
    
    var _colNum = 0
    
    var _rowNum = 0
    
    private var _buttonArray:NSMutableArray
    
    override public var frame:CGRect{

        get{
        
            return super.frame;
        }
        
        set{
        
            super.frame = newValue
            
            self.layoutButtons()
        }
    }
    
    
    public init(items:Array<NCKGridItem>, col:Int) {
        
        _buttonArray = NSMutableArray()
        
        super.init(frame: CGRect.zero)
        
        self.backgroundColor = UIColor.whiteColor()
        
        _items = items
        
        _colNum = col
        
        _rowNum = Int(ceil(Double(_items!.count) / Double(col)))
        
        var i = 0
        
        for item in items {
            
            let button = UIButton(type: .Custom)
            
            button.titleLabel?.font = _font
            
            button.setTitle(item.name, forState: .Normal)
            
            button.setTitleColor(UIColor.blackColor(), forState: .Normal)
            
            button.setBackgroundImage(UIImage.nck_imageWithColor(_lineColor), forState: .Highlighted)
            
            button.addTarget(self,
                             action: #selector(self.buttonClicked(_:)),
                             forControlEvents: .TouchUpInside)
            
            if let icon = item.icon {
                
                button.setImage(UIImage(named: icon), forState: .Normal)
            }
            
            _buttonArray.addObject(button)
            
            button.tag = i
            
            self.addSubview(button)
            
            i += 1
        }
    }
    
    func buttonClicked(button:UIButton) {
        
        if let delegate = _delegate {
            
            delegate.gridViewDidSelected?(_items![button.tag], index: button.tag)
        }
    }
    
    func layoutButtons() {
        
        var i = 0
        
        let width = self.frame.width / CGFloat(_colNum)
        
        let height = self.frame.height / CGFloat(_rowNum)
        
        for button  in _buttonArray {
            
            let row = floor(CGFloat(i / _colNum))
            
            let col = i % _colNum
            
            let b:UIButton = button as! UIButton
            
            b.frame = CGRectMake(CGFloat(col) * width, row * height, width, height)
            
            i += 1
            
            if let _ = _items?[button.tag] {
               
                b.nck_vAlign(spacing: 5, topSpacing: 0)
            }
            
        }
        
        self.setNeedsDisplay()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override public func drawRect(rect: CGRect)
    {
        guard let _ = _items else { return }
        
        let context = UIGraphicsGetCurrentContext();
        
        let width = self.frame.size.width / CGFloat(_colNum)
        
        let height = self.frame.size.height / CGFloat(_rowNum)
        
        CGContextSetStrokeColorWithColor(context, _lineColor.CGColor)
        
        CGContextSetLineWidth(context, CGFloat(_lineWith))
        
        CGContextMoveToPoint(context, 0, 0)
        
        for i in 0..._colNum {
            
            var x = width * CGFloat(i)
            
            if i == 0 {
                
                x += CGFloat(_lineWith) / 2.0
            }
            else if i == (_colNum - 1){
                x -= CGFloat(_lineWith) / 2.0
            }
            
            CGContextMoveToPoint(context, x, 0)

            CGContextAddLineToPoint(context, x, self.frame.size.height)
        }
        
        for i in 0..._rowNum {
            
            var y = height * CGFloat(i)
            
            if i == 0 {
                
                y += CGFloat(_lineWith) / 2.0
            }
            else if i == (_colNum - 1){
                y -= CGFloat(_lineWith) / 2.0
            }
            
            CGContextMoveToPoint(context, 0, y)
            
            CGContextAddLineToPoint(context, self.frame.size.width, y)
        }
        
        CGContextStrokePath(context)
    }
}

@objc public protocol NCKGridViewDelegate {
    
    /// GridView点击回调
    /// gridItem 被选中的Item
    /// index 被选中Item的索引号
    optional func gridViewDidSelected(gridItem:NCKGridItem, index: Int);
}
