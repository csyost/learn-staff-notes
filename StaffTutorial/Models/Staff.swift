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

    func generateRandomNote(accidentals: Bool = true) -> Note {
        let randBlah = Note.numSteps(from: bottomMostNote, to: topMostNote)
        print(randBlah)
        let newStep = Int(arc4random_uniform(UInt32(randBlah)))
        return Note.noteOffsetFrom(bottomMostNote, by: newStep)
    }
}

