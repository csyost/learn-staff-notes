//
//  StaffView.swift
//  StaffTutorial
//
//  Created by Casey Yost on 6/23/18.
//  Copyright © 2018 Casey Yost. All rights reserved.
//

import UIKit

public enum Clef {
    case treble, bass
    
    var firstLineIndexToDraw: Int {
        switch self {
        case .treble:
            return 2
        case .bass:
            return 1
        }
    }
    
    var topMostNote: Note {
        switch self {
        case .treble:
            return Note(noteName: NoteName.c, octave: 6)
        case .bass:
            return Note(noteName: NoteName.c, octave: 6)
        }
    }
}

public class StaffView: UIView {
    
    let numberOfLinesToDraw = 5
    let numberOfSpaces = 9
    
    public var lineWidth: CGFloat = 5 {
        didSet{ self.setNeedsDisplay() }
    }
    public var note: Note? {
        didSet{ self.setNeedsDisplay() }
    }
    
    public var cleff = Clef.treble {
        didSet{ self.setNeedsDisplay() }
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        let sectionHeight: CGFloat = rect.height / CGFloat(numberOfSpaces)
        let halfStepHeight: CGFloat = sectionHeight / 2.0
        var staffLinePoints = [CGPoint]()
        var yOffset = sectionHeight * CGFloat(cleff.firstLineIndexToDraw + 1)
        
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
            let halfStepsToDraw = Note.numHalfSteps(from: cleff.topMostNote, to: noteToDraw) + 1
            let noteWidth = sectionHeight * 1.2
            
            yOffset = halfStepHeight + halfStepHeight * CGFloat(halfStepsToDraw)
            let noteRect = CGRect(x: rect.midX - noteWidth / 2.0, y: yOffset - sectionHeight / 2.0, width: sectionHeight * 1.2, height: sectionHeight)
            
            context.strokeEllipse(in: noteRect)
            
            print("total height: \(rect.height)\nsection Height: \(sectionHeight)\nhalf steps: \(halfStepsToDraw)\nyOffset: \(yOffset)")
            
            if(halfStepsToDraw % 2 == 1) {
                context.strokeLineSegments(between: [CGPoint(x: noteRect.minX - 10, y: noteRect.midY),
                                                     CGPoint(x: noteRect.maxX + 10, y: noteRect.midY)])
            }
        }
        
        context.setStrokeColor(UIColor.red.cgColor)
        context.stroke(rect)
    }
}
