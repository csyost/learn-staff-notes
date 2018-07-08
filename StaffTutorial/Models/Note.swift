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
    
    public init(globalScalar: Int) {
        self.init(noteName: NoteName(rawValue: globalScalar % 7) ?? NoteName.c, octave: globalScalar / 7)
    }
    
    public func globalScalar() -> Int {
        return self.octave * 7 + self.noteName.rawValue
    }
    
    static public func numSteps(from: Note, to: Note) -> Int {
        return to.globalScalar() - from.globalScalar()
    }
    
    static public func noteOffsetFrom(_ startNote: Note, by offsetInSteps: Int) -> Note {
        let globalScalar = startNote.globalScalar() + offsetInSteps
        return Note(globalScalar: globalScalar)
    }
}
