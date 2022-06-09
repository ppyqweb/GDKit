//
//  GDPhotoDrawingView.swift
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

import UIKit

class GDPhotoDrawingView: UIView {

    public var selectedColor: UIColor?
    private var viewImage: UIImage?
    private var previousPoint = CGPoint.zero
    private var currentPoint = CGPoint.zero
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        self.viewImage?.draw(in: self.bounds)
    }
    
    func drawLineNew() {
        UIGraphicsBeginImageContext(bounds.size)
        self.viewImage?.draw(in: self.bounds)
        
        UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
        UIGraphicsGetCurrentContext()?.setStrokeColor(selectedColor?.cgColor ?? UIColor().cgColor)
        UIGraphicsGetCurrentContext()?.setLineWidth(5)
        UIGraphicsGetCurrentContext()?.beginPath()
        UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: previousPoint.x, y: previousPoint.y))
        UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: currentPoint.x, y: currentPoint.y))
        
        UIGraphicsGetCurrentContext()?.strokePath()
        self.viewImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        previousPoint = currentPoint
        setNeedsDisplay()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let p: CGPoint = touches.first?.location(in: self) {
            previousPoint = p
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let point = (touches.first?.location(in: self)) {
            currentPoint = point
        }
        drawLineNew()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let point = (touches.first?.location(in: self)) {
            currentPoint = point
        }
        drawLineNew()
    }

}
