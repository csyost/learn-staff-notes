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
    
    var nextNoteToGuess: Note = Note()
    let clef = Clef.treble
    var numGuesses = 0;
    var numCorrect = 0;
    
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
        nextNoteToGuess = clef.generateRandomNote()
        staffView.note = nextNoteToGuess
        print("next note: \(nextNoteToGuess)")
    }
    
    private func updateScore() {
        scoreLabel.text = String(format: "score: %d/%d (%.2f)", numCorrect, numGuesses, numGuesses == 0 ? 0 : Float(numCorrect) / Float(numGuesses))
    }

    @IBAction func noteClicked(_ clickedButton: UIButton) {
        guard let guessedNoteNameIndex = stackView.subviews.index(of: clickedButton) else {
            return
        }

        numGuesses += 1
        
        let guessedNoteName = NoteName(rawValue: guessedNoteNameIndex)

        if(guessedNoteName == nextNoteToGuess.noteName) {
            generateNewNote()
            statusLabel.text = "YAY!"
            statusLabel.textColor = UIColor.green
            numCorrect += 1
        } else {
            statusLabel.text = "BOO!"
            statusLabel.textColor = UIColor.red
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

