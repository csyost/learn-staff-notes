//
//  Note.swift
//  StaffTutorial
//
//  Created by Casey Yost on 6/23/18.
//  Copyright © 2018 Casey Yost. All rights reserved.
//

enum NoteName {
    case a, b, c, d, e, f, g
}

enum Accidental {
    case natural, sharp, flat, doubleSharp, doubleFlat
}

struct Note {
    var noteName: NoteName
    var accidental: Accidental
    var octave: Int // TODO validate 0 through 12
}
