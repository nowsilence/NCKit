//
//  String+MD5.swift
//  NCKit
//
//  Created by Nigel Chou on 16/4/20.
//  Copyright © 2016年 BeautyFuture. All rights reserved.
//

import Foundation
import CommonCrypto

extension String {
    
    public var nck_md5: String! {

        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
        
        let strLen = CC_LONG(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
        
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        
        for i in 0..<digestLen {
          
            hash.appendFormat("%02x", result[i])
        }
        
        result.dealloc(digestLen)
        
        return String(format: hash as String)
    }
    
    
}