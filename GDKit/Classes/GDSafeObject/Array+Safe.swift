//
//  Array+Safe.swift
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

import Foundation

extension Array {
    
    // 防止数组越界
    public subscript(safe index: Int) -> Element {
        get {
            if index < self.count {
                return self[index]
            } else if index - 1 < self.count {
                debugToast("数组越界\n\n\(type(of: self))")
                return self[index - 1]
            }
            debugToast("数组越界\n\n\(type(of: self))")
            return self[0]
        }
        set {
            if index < self.count {
                self[index] = newValue
            } else {
                debugToast("数组越界\n\n\(type(of: self))")
            }
        }
    }
    
    //    public subscript(safe index: Int) -> Element? {
    //        return (0..<count).contains(index) ? self[index] : nil
    //    }
    
    //    public subscript(index: Int) -> Element {
    //        if self.count > index {
    //            return self[index]
    //        }
    //        return self[self.count-1]
    //    }
    
}
