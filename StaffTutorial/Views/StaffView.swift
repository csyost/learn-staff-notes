//
//  StaffView.swift
//  StaffTutorial
//
//  Created by Casey Yost on 6/23/18.
//  Copyright © 2018 Casey Yost. All rights reserved.
//

import UIKit

public class StaffView: UIView {

    public var lineWidth: CGFloat = 5 {
        didSet{ self.setNeedsDisplay() }
    }
    public var note: Note? {
        didSet{ self.setNeedsDisplay() }
    }
    
    public var clef = Clef.treble {
        didSet{ self.setNeedsDisplay() }
    }
    
    private func yOffsetFromScalar(_ scalar: Int, noteHeight: CGFloat) -> CGFloat {
        return CGFloat((0.5 + (CGFloat(scalar) / 2.0)) * noteHeight)
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        // add an extra step each way to leave space for rendering the height of the notes.
        let rangeOfSteps = (topScalar: clef.topMostNote.globalScalar(), bottomScalar: clef.bottomMostNote.globalScalar(), scalarRange: clef.topMostNote.globalScalar() - clef.bottomMostNote.globalScalar())
        let noteHeight = rect.height / (CGFloat(rangeOfSteps.scalarRange + 2) * 0.5)
        var staffLinePoints = [CGPoint]()

        context.setLineWidth(lineWidth)
        context.setStrokeColor(UIColor.black.cgColor)
        
        let rangeOfLines = (topScalar: clef.topMostNote.globalScalar() - clef.topNoteToDraw.globalScalar(), bottomScalar: clef.topMostNote.globalScalar() - clef.bottomNoteToDraw.globalScalar())

        for i in stride(from: rangeOfLines.topScalar, through: rangeOfLines.bottomScalar, by: 2) {
            let yOffset = yOffsetFromScalar(i, noteHeight: noteHeight)
            staffLinePoints.append(CGPoint(x: 0, y: yOffset))
            staffLinePoints.append(CGPoint(x: rect.size.width, y: yOffset))
        }

        context.strokeLineSegments(between: staffLinePoints)

        if let noteToDraw = note {
            // Negate to convert to a positive y offset
            let noteWidth = noteHeight * 1.2
            let relativeNoteScalar = rangeOfSteps.topScalar - noteToDraw.globalScalar()
            let yOffset = yOffsetFromScalar(relativeNoteScalar, noteHeight: noteHeight)
            let noteRect = CGRect(x: rect.midX - noteWidth / 2.0, y: yOffset - noteHeight / 2.0, width: noteWidth, height: noteHeight)
            
            context.strokeEllipse(in: noteRect)

            if relativeNoteScalar < rangeOfLines.topScalar {
                for i in stride(from: rangeOfLines.topScalar, through: relativeNoteScalar, by: -2) {
                    let yOffset = yOffsetFromScalar(i, noteHeight: noteHeight)
                    context.strokeLineSegments(between: [CGPoint(x: noteRect.minX - 10, y: yOffset),
                                                         CGPoint(x: noteRect.maxX + 10, y: yOffset)])
                }
            } else if relativeNoteScalar > rangeOfLines.bottomScalar {
                for i in stride(from: rangeOfLines.bottomScalar, through: relativeNoteScalar, by: 2) {
                    let yOffset = yOffsetFromScalar(i, noteHeight: noteHeight)
                    context.strokeLineSegments(between: [CGPoint(x: noteRect.minX - 10, y: yOffset),
                                                         CGPoint(x: noteRect.maxX + 10, y: yOffset)])
                }
            }
        }

        context.setStrokeColor(UIColor.red.cgColor)
        context.stroke(rect)
    }
}
