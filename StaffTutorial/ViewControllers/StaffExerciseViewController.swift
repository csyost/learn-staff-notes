//
//  ViewController.swift
//  StaffTutorial
//
//  Created by Casey Yost on 6/23/18.
//  Copyright © 2018 Casey Yost. All rights reserved.
//

import UIKit

class StaffExerciseViewController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var staffView: StaffView!
    
    var nextNoteToGuess: Note = Note()
    let clef = Clef.treble
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nextNoteToGuess = clef.generateRandomNote()
        
        for subview in stackView.subviews {
            (subview as! UIButton).addTarget(self, action: #selector(noteClicked(_:)), for: UIControlEvents.touchUpInside)
        }
        
        staffView.clef = clef
        staffView.note = nextNoteToGuess
        print("next note: \(nextNoteToGuess)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func noteClicked(_ clickedButton: UIButton) {
        guard let guessedNoteNameIndex = stackView.subviews.index(of: clickedButton) else {
            return
        }

        let guessedNoteName = NoteName(rawValue: guessedNoteNameIndex)

        if(guessedNoteName == nextNoteToGuess.noteName) {
            print("YAY!")
        } else {
            print("BOO!")
        }
        
        nextNoteToGuess = clef.generateRandomNote()
        staffView.note = nextNoteToGuess
        print("next note: \(nextNoteToGuess)")

    }
    
}

