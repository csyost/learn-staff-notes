//
//  StaffView.swift
//  StaffTutorial
//
//  Created by Casey Yost on 6/23/18.
//  Copyright © 2018 Casey Yost. All rights reserved.
//

import UIKit

enum Clef {
    case treble, bass
}

class StaffView: UIView {

    let totalNumberOfLines = 8 // Leave room for middle C and High C or Low C
    let numberOfLinesToDraw = 5
    
    var lineWidthPct: CGFloat = 0.03 {
        didSet{ self.setNeedsDisplay() }
    }
    var note: Note? {
        didSet{ self.setNeedsDisplay() }
    }
    
    var cleff = Clef.treble {
        didSet{ self.setNeedsDisplay() }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        let lineWidth = rect.height * lineWidthPct
        let numLinesAsFloat = CGFloat(totalNumberOfLines)
        // Leave space on either side (top and bottom)
        let spaceHeight = (rect.height - lineWidth * numLinesAsFloat) / (numLinesAsFloat + 1)
        var firstIndexToDraw = 0
        var staffLinePoints = [CGPoint]()
        
        switch cleff {
        case .bass:
            firstIndexToDraw = 1
        case .treble:
            firstIndexToDraw = 2
        }
        
        var yOffset = spaceHeight * CGFloat(firstIndexToDraw + 1) + lineWidth * CGFloat(firstIndexToDraw)

        context.setLineWidth(lineWidth)
        context.setStrokeColor(UIColor.black.cgColor)

        for _ in 0 ..< numberOfLinesToDraw {
            staffLinePoints.append(CGPoint(x: 0, y: yOffset))
            staffLinePoints.append(CGPoint(x: rect.size.width, y: yOffset))
            yOffset += lineWidth + spaceHeight
        }
        context.strokeLineSegments(between: staffLinePoints)
        context.setStrokeColor(UIColor.red.cgColor)
        context.stroke(rect)
    }
}
