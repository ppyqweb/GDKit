//
//  GDReplaceMethod.swift
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

import Foundation

class SayHello: NSObject {
    @objc func sayHello(_ name: String) {
        
    }
}

extension SayHello {
    //Argument of '#selector' refers to instance method 'swizzleSayHello' that is not exposed to Objective-C
    //Add '@objc' to expose this instance method to Objective-C
    //@objc 表示 暴露 方法给 oc 调用
    @objc private func swizzledSayHello(_ name: String) -> Void {
        var name__ = name
        name__ = name + ",nice to meet you"
        return swizzledSayHello(name__)
    }
    class func swizzledSayHello() {
        
        let originalSelctor = #selector(SayHello.sayHello(_:))
        let swizzledSelector = #selector(SayHello.swizzledSayHello(_:))
        swizzleMethod(for: SayHello.self, originalSelector: originalSelctor, swizzledSelector: swizzledSelector)
    }
}


func swizzleMethod(for aClass: AnyClass, originalSelector: Selector,swizzledSelector: Selector) {
    let originalMethod = class_getInstanceMethod(aClass, originalSelector)
    let swizzledMethod = class_getInstanceMethod(aClass, swizzledSelector)
    let didAddMethod = class_addMethod(aClass, originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))
    if didAddMethod {
        class_replaceMethod(aClass, swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
    } else {
        method_exchangeImplementations(originalMethod!, swizzledMethod!)
    }
}
