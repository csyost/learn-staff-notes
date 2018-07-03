//
//  StaffView.swift
//  StaffTutorial
//
//  Created by Casey Yost on 6/23/18.
//  Copyright © 2018 Casey Yost. All rights reserved.
//

import UIKit

public class StaffView: UIView {

    let numberOfLinesToDraw = 5
    let numberOfSpaces = 9
    
    public var lineWidth: CGFloat = 5 {
        didSet{ self.setNeedsDisplay() }
    }
    public var note: Note? {
        didSet{ self.setNeedsDisplay() }
    }
    
    public var clef = Clef.treble {
        didSet{ self.setNeedsDisplay() }
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        let sectionHeight: CGFloat = rect.height / CGFloat(numberOfSpaces)
        let stepHeight: CGFloat = sectionHeight / 2.0
        var staffLinePoints = [CGPoint]()
        var yOffset = sectionHeight * CGFloat(clef.firstLineIndexToDraw + 1)

        context.setLineWidth(lineWidth)
        context.setStrokeColor(UIColor.black.cgColor)

        for _ in 0 ..< numberOfLinesToDraw {
            staffLinePoints.append(CGPoint(x: 0, y: yOffset))
            staffLinePoints.append(CGPoint(x: rect.size.width, y: yOffset))
            yOffset += sectionHeight
        }

        context.strokeLineSegments(between: staffLinePoints)

        if let noteToDraw = note {
            // +1 to account for space above first "lined note"
            let stepsToDraw = Note.numSteps(from: clef.topMostNote, to: noteToDraw) + 1
            let noteWidth = sectionHeight * 1.2
            
            yOffset = stepHeight + stepHeight * CGFloat(stepsToDraw)
            let noteRect = CGRect(x: rect.midX - noteWidth / 2.0, y: yOffset - sectionHeight / 2.0, width: sectionHeight * 1.2, height: sectionHeight)
            
            context.strokeEllipse(in: noteRect)
            
            print("total height: \(rect.height)\nsection Height: \(sectionHeight)\nhalf steps: \(stepsToDraw)\nyOffset: \(yOffset)")
            
            // I could optimize and skip if it lands on a line already drawn, but I'm not trying to
            // win any architecture awards here.
            if(stepsToDraw % 2 == 1) {
                context.strokeLineSegments(between: [CGPoint(x: noteRect.minX - 10, y: noteRect.midY),
                                                     CGPoint(x: noteRect.maxX + 10, y: noteRect.midY)])
            }
        }

        context.setStrokeColor(UIColor.red.cgColor)
        context.stroke(rect)
    }
}
