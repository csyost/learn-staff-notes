//
//  Note.swift
//  StaffTutorial
//
//  Created by Casey Yost on 6/23/18.
//  Copyright © 2018 Casey Yost. All rights reserved.
//

public enum NoteName: Int {
    case a, b, c, d, e, f, g
}

public enum Accidental {
    case natural, sharp, flat, doubleSharp, doubleFlat
}

public struct Note {
    var noteName: NoteName
    var accidental: Accidental
    var octave: Int // TODO validate 0 through 12

    public init() {
        self.noteName = NoteName.c
        self.accidental = Accidental.natural
        self.octave = 4
    }
    
    public init(noteName: NoteName, octave: Int) {
        self.init()
        
        self.noteName = noteName
        self.octave = octave
        self.accidental = Accidental.natural
    }
    
    static public func numSteps(from: Note, to: Note) -> Int {
        return ((from.octave - to.octave) * 7) + (from.noteName.rawValue - to.noteName.rawValue)
    }
    
    static public func noteOffsetFrom(_ startNote: Note, by offsetInSteps: Int) -> Note {
        var newNote = Note()
        let octaveDiff = offsetInSteps / 7
        newNote.octave = startNote.octave + octaveDiff
        newNote.noteName = NoteName(rawValue: offsetInSteps - octaveDiff * 7) ?? NoteName.c
        newNote.accidental = startNote.accidental
        return newNote
    }
}
