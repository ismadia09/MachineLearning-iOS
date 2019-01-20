//
//  Canvas.swift
//  MachineLearning
//
//  Created by Isma Dia on 20/01/2019.
//  Copyright © 2019 Isma Dia. All rights reserved.
//

import UIKit

class Canvas: UIView {

    //var line = [CGPoint]()
    var lines = [[CGPoint]]()
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        context.setStrokeColor(UIColor.red.cgColor)
        context.setLineWidth(8)
        context.setLineCap(.butt)
        
        
        lines.forEach { (line) in
            for (i, p) in line.enumerated(){
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
        }
        
        
        context.strokePath()
    }
    
    func clearCanvas(){
        lines.removeAll()
        setNeedsDisplay()
    }
    
    func undo(){
        _ = lines.popLast()
        setNeedsDisplay()
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append([CGPoint]())
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else {
            return
        }
        guard var lastLine = lines.popLast() else {
            return
        }
        lastLine.append(point)
        lines.append(lastLine)
        setNeedsDisplay()
    }

}
