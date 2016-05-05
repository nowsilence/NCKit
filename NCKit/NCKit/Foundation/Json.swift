//
//  Json.swift
//  NCKit
//
//  Created by Nigel Chou on 16/4/21.
//  Copyright © 2016年 BeautyFuture. All rights reserved.
//

import Foundation

extension String {

    public func nck_JSONObject()->AnyObject?
    {
        let data = self.dataUsingEncoding(NSUTF8StringEncoding)
        
        do {
            
            let jsonArr = try NSJSONSerialization.JSONObjectWithData(data!,options: NSJSONReadingOptions.MutableContainers)
            
            return jsonArr;
            
        } catch let error as NSError {
        
            print("Json Parse Erro:\n\(self) \nErro Rease: \(error.localizedDescription)")
        }
        
        return nil;
    }
}

extension NSDictionary {

    public func nck_JSONString()->NSString?
    {
        if (!NSJSONSerialization.isValidJSONObject(self)) {
            
            print("not a valid json object : \(self)")
            
            return nil
        }
        
        let data : NSData! = try? NSJSONSerialization.dataWithJSONObject(self, options: [])
        
        let str = NSString(data:data, encoding: NSUTF8StringEncoding)
        
        return str;
    }
    
    
    public func nck_objectForKey(key:AnyObject)->AnyObject?
    {
        if  let _ = self.objectForKey(key) as? NSNull{
            
            return nil;
        }
        
        return self.objectForKey(key);
    }
}

extension NSArray {
    
    public func nck_JSONString()->NSString?
    {
        if (!NSJSONSerialization.isValidJSONObject(self)) {
            
            print("not a valid json object : \(self)")
            
            return nil
        }
        
        let data : NSData! = try? NSJSONSerialization.dataWithJSONObject(self, options: [])
        
        let str = NSString(data:data, encoding: NSUTF8StringEncoding)
        
        return str;
    }
}