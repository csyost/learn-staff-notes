//
//  MainMenuViewController.swift
//  StaffTutorial
//
//  Created by Casey Yost on 7/28/18.
//  Copyright © 2018 Casey Yost. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var clefPickerView: UIPickerView!
    @IBOutlet weak var bottomNotePickerView: UIPickerView!
    @IBOutlet weak var topNotePickerView: UIPickerView!
    
    private var selectedClef: Clef = Clef.treble
    
    public override func viewDidLoad() {
        updateSelectedClef()
        bottomNotePickerView.selectRow(bottomNotePickerView.numberOfRows(inComponent: 0) - 1, inComponent: 0, animated: false)
    }
    
    private func noteForPickerIndex(picker: UIPickerView, index: Int) -> Note {
        if(picker == bottomNotePickerView) {
            return Note.noteOffsetFrom(selectedClef.topMostNote, by: -index - 1)
        } else {
            return Note.noteOffsetFrom(selectedClef.topMostNote, by: -index)
        }
    }
    
    private func updateSelectedClef() {
        selectedClef = Clef(rawValue: clefPickerView.selectedRow(inComponent: 0))!
    }
    
    // MARK: UIPickerViewDataSource
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView == clefPickerView) {
            return 2
        }
        return Note.numSteps(from: selectedClef.bottomMostNote, to: selectedClef.topMostNote)
    }

    // MARK: UIPickerViewDelegate
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView == clefPickerView) {
            return Clef(rawValue: row)?.stringValue
        }
        
        return noteForPickerIndex(picker: pickerView, index: row).stringValue
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView == clefPickerView) {
            updateSelectedClef()
            bottomNotePickerView.reloadAllComponents()
            topNotePickerView.reloadAllComponents()
        } else if(pickerView == bottomNotePickerView && topNotePickerView.selectedRow(inComponent: 0) > row) {
            topNotePickerView.selectRow(row, inComponent: 0, animated: true)
        } else if(pickerView == topNotePickerView && bottomNotePickerView.selectedRow(inComponent: 0) < row) {
            bottomNotePickerView.selectRow(row, inComponent: 0, animated: true)
        }
    }
    
    override public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let staffController = segue.destination as? StaffExerciseViewController {
            staffController.minNote = noteForPickerIndex(picker: bottomNotePickerView, index: bottomNotePickerView.selectedRow(inComponent: 0))
            staffController.maxNote = noteForPickerIndex(picker: topNotePickerView, index: topNotePickerView.selectedRow(inComponent: 0))
            staffController.clef = selectedClef
            
            playSound("start_game")
        }
    }
    
    @IBAction func unwindToMainMenu(segue:UIStoryboardSegue) { }
}
