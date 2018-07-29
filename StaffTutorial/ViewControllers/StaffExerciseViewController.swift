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
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    let totalNotesToGuess = 20
    
    var clef = Clef.treble
    var minNote = Clef.treble.bottomMostNote
    var maxNote = Clef.treble.topMostNote

    private var nextNoteToGuess: Note = Note()
    private var totalGuesses = 0;
    private var numCorrect = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for subview in stackView.subviews {
            subview.layer.borderColor = UIColor.black.cgColor
            subview.layer.borderWidth = 1
            (subview as! UIButton).addTarget(self, action: #selector(noteClicked(_:)), for: UIControlEvents.touchUpInside)
        }
        
        statusLabel.alpha = 0.0
        staffView.clef = clef
        
        generateNewNote()
        updateScore()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func generateNewNote() {
        // Generate a random note, but not if it's the same as the old one.
        let oldNote = nextNoteToGuess
        repeat {
            nextNoteToGuess = clef.generateRandomNote(minNote: minNote, maxNote: maxNote)
        } while (oldNote == nextNoteToGuess)
        
        staffView.note = nextNoteToGuess
        answerLabel.isHidden = true
    }
    
    private func updateScore() {
        scoreLabel.text = "\(numCorrect)/\(totalGuesses)"
    }

    @IBAction func noteClicked(_ clickedButton: UIButton) {
        guard let guessedNoteNameIndex = stackView.subviews.index(of: clickedButton) else {
            return
        }

        let guessedNoteName = NoteName(rawValue: stackView.subviews.endIndex - guessedNoteNameIndex - 1)

        if(guessedNoteName == nextNoteToGuess.noteName) {
            
            if(answerLabel.isHidden) {
                numCorrect += 1
            }
            
            totalGuesses += 1
            generateNewNote()
            statusLabel.text = "YAY!"
            statusLabel.textColor = UIColor.green
        } else {
            statusLabel.text = "BOO!"
            statusLabel.textColor = UIColor.red
            answerLabel.text = "Answer: " + nextNoteToGuess.noteName.stringValue
            answerLabel.isHidden = false
        }

        updateScore()

        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       options: UIViewAnimationOptions.beginFromCurrentState,
                       animations: {
                        self.statusLabel.alpha = 1.0
        }, completion: { (completed: Bool) in
            if(completed) {
                UIView.animate(withDuration: 1.0,
                               delay: 0,
                               options: UIViewAnimationOptions.beginFromCurrentState,
                               animations: {
                                self.statusLabel.alpha = 0.0
                }, completion: nil)

            }
        })
    }
}

