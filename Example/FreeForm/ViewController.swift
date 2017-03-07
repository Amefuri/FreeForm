//
//  ViewController.swift
//  FreeForm
//
//  Created by Peerasak Unsakon on 01/03/2017.
//  Copyright (c) 2017 Peerasak Unsakon. All rights reserved.
//

import UIKit
import FreeForm

class FreeTestRow: FreeFormRow {
    override init(tag: String, title: String, value: AnyObject?) {
        super.init(tag: tag, title: title, value: value)
    }
}

class ViewController: FreeFormViewController {

    var section1 = FreeFormSection(tag: "Demo1", title: "")
    var section2 = FreeFormSection(tag: "Demo2", title: "Demo2")
    var section3 = FreeFormSection(tag: "Demo3", title: "")
    
    let pushOptions = FreeFormPushRow(tag: "Push", title: "Seletect Somethings", value: "Hello", options: ["Hello", "Bye!"])
    let firstname = FreeFormTextFieldRow(tag: "FirstName", title: "FirstName", value: nil)
    let lastname = FreeFormTextFieldRow(tag: "LastName", title: "LastName", value: nil)
    let email = FreeFormTextFieldRow(tag: "Email", title: "Email", value: nil)
    let text = FreeFormTextRow(tag: "Text", title: "Fullname", value: nil)
    let datetime = FreeFormDatetimeRow(tag: "Datetime", title: "Date", selectedDate: Date(),
                                       min: Calendar.current.date(byAdding: .day, value: -10, to: Date()),
                                       max: Calendar.current.date(byAdding: .day, value: 10, to: Date()))
    
    let textView = FreeFormTextViewRow(tag: "TextView", title: "Detail", value: nil)
    let segmented = FreeFormSegmentedRow(tag: "Segmented", title: "Segmented", value: "Hello", options: ["Hello", "Bye!"])
    let button = FreeFormButtonRow(tag: "Button", title: "Tap Me!!")
    let stepper = FreeFormStepperRow(tag: "Stepper", title: "Stepper", max: 10, min: 0, value: 0)
    let switchRow = FreeFormSwitchRow(tag: "Switch", title: "Show or Hide", value: true as AnyObject?)
    
    override func initializeForm() {
        
        self.form.title = "FreeForm Example"
        
        self.section1 = {
            let section = self.section1
            section.addRow(self.pushOptions)
            section.addRow(self.firstname)
            section.addRow(self.lastname)
            section.addRow(self.email)
            section.addRow(self.text)
            section.addRow(self.datetime)
            section.addRow(self.button)
            
            section.customHeader = { titleView in
                titleView.backgroundColor = UIColor.red
                
            }
            section.headerHeight =  40
            
            return section
        }()
        
        self.section2 = {
            let section = self.section2
            section.addRow(self.textView)
            section.addRow(segmented)
            return section
        }()
        
        self.section3 = {
            let section = self.section3
            section.addRow(self.switchRow)
            section.addRow(self.stepper)
            return section
        }()
        
        self.form.addSection(self.section1)
        self.form.addSection(self.section2)
        self.form.addSection(self.section3)
        
        self.firstname.customCell = { cell in
            guard let textfieldCell = cell as? FreeFormTextFieldCell else { return }
            textfieldCell.titleLabel.textColor = UIColor.red
            textfieldCell.textField.borderStyle = .none
            textfieldCell.textField.textColor = UIColor.green
        }
        
        self.lastname.customCell = { cell in
            guard let textfieldCell = cell as? FreeFormTextFieldCell else { return }
            textfieldCell.titleLabel.textColor = UIColor.blue
            textfieldCell.textField.borderStyle = .roundedRect
            textfieldCell.textField.textColor = UIColor.green
        }
        
        self.textView.customCell = { cell in
            guard let textViewCell = cell as? FreeFormTextViewCell else { return }
            textViewCell.titleLabel.textColor = UIColor.blue
            textViewCell.textView.backgroundColor = UIColor.yellow
        }
        
        self.segmented.customCell = { cell in
            guard let segmentedCell = cell as? FreeFormSegmentedCell else { return }
            segmentedCell.segmentedControl.tintColor = UIColor.red
        }
        
        self.segmented.didChanged = { value, row in
            guard let text = value as? String else { return }
            if text == "Bye!" {
                self.lastname.hidden = true
                self.textView.height = 200
            }else {
                self.lastname.hidden = false
                self.textView.height = 110
            }
            self.form.reloadForm(true)
        }
        
        self.button.customCell = { cell in
            guard let buttonCell = cell as? FreeFormButtonCell else { return }
            buttonCell.backgroundColor = UIColor.cyan
        }
        
        self.button.didTapped = { row in
            guard let buttonCell = row.cell as? FreeFormButtonCell else { return }
            if buttonCell.button.titleLabel?.text == "Tap Me!!" {
                buttonCell.button.setTitle("Yes", for: .normal)
            }else {
                buttonCell.button.setTitle("Tap Me!!", for: .normal)
            }
        }
        
        self.switchRow.didChanged = { value, row in
            guard let isOn = value as? Bool else {
                return
            }
            self.button.hidden = !isOn
            self.form.reloadForm(true)
        }
        
        self.firstname.value = "Peerasak" as AnyObject?
        self.lastname.value = "Unsakon" as AnyObject?
        self.text.value = "\(self.firstname.value!) \(self.lastname.value!)" as AnyObject?
    }
}


extension NSError {
    
    static func create(_ message: String) -> NSError {
        let userInfo = [
            NSLocalizedDescriptionKey: NSLocalizedString(message,  comment: ""),
            NSLocalizedFailureReasonErrorKey: NSLocalizedString(message, comment: ""),
            NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(message, comment: "")
        ]
        let error = NSError(domain: "com.fireoneone.hms", code: 999, userInfo: userInfo)
        return error
    }
    
    static func create(_ errorCode: Int, message: String) -> NSError {
        let userInfo = [
            NSLocalizedDescriptionKey: NSLocalizedString(message,  comment: ""),
            NSLocalizedFailureReasonErrorKey: NSLocalizedString(message, comment: ""),
            NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(message, comment: "")
        ]
        let error = NSError(domain: "com.fireoneone.hms", code: errorCode, userInfo: userInfo)
        return error
    }
    
}
