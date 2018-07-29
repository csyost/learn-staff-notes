//
//  Staff.swift
//  StaffTutorial
//
//  Created by Casey Yost on 7/2/18.
//  Copyright © 2018 Casey Yost. All rights reserved.
//

import Foundation

public enum Clef: Int {
    case treble, bass
    
    var topNoteToDraw: Note {
        switch self {
        case .treble:
            return Note(noteName: NoteName.f, octave: 5)
        case .bass:
            return Note(noteName: NoteName.a, octave: 4)
        }
    }

    var bottomNoteToDraw: Note {
        switch self {
        case .treble:
            return Note(noteName: NoteName.e, octave: 4)
        case .bass:
            return Note(noteName: NoteName.g, octave: 2)
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
    
    var stringValue: String {
        switch self {
        case .treble:
            return "treble"
        case .bass:
            return "bass"
        }
    }

    func generateRandomNote(accidentals: Bool = true) -> Note {
        return self.generateRandomNote(minNote: bottomMostNote, maxNote: topMostNote, accidentals: accidentals)
    }
    
    func generateRandomNote(minNote: Note, maxNote: Note, accidentals: Bool = true) -> Note {
        let maxValue = Note.numSteps(from: minNote, to: maxNote)
        let newStep = Int(arc4random_uniform(UInt32(maxValue + 1)))
        return Note.noteOffsetFrom(minNote, by: newStep)
    }
}

