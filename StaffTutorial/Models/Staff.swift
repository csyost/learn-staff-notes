//
//  Staff.swift
//  StaffTutorial
//
//  Created by Casey Yost on 7/2/18.
//  Copyright © 2018 Casey Yost. All rights reserved.
//

import Foundation

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
            return Note(noteName: NoteName.c, octave: 4)
        }
    }

    var bottomMostNote: Note {
        switch self {
        case .treble:
            return Note(noteName: NoteName.c, octave: 4)
        case .bass:
            return Note(noteName: NoteName.c, octave: 2)
        }
    }

    func generateRandomNote(accidentals: Bool = true) -> Note {
        let randBlah = Note.numSteps(from: topMostNote, to: bottomMostNote)
        print(randBlah)
        let newStep = Int(arc4random_uniform(UInt32(randBlah)))
        return Note.noteOffsetFrom(topMostNote, by: newStep)
    }
}

