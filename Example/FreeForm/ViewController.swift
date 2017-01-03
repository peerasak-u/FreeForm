//
//  ViewController.swift
//  FreeForm
//
//  Created by Peerasak Unsakon on 01/03/2017.
//  Copyright (c) 2017 Peerasak Unsakon. All rights reserved.
//

import UIKit
import FreeForm

class ViewController: FreeFormViewController {
    
    var section1 = FreeFormSection(tag: "Demo1", title: "Demo1")
    var section2 = FreeFormSection(tag: "Demo2", title: "Demo2")
    var section3 = FreeFormSection(tag: "Demo3", title: "Demo3")
    
    let firstname = FreeFormTextFieldRow(tag: "FirstName", title: "FirstName", value: nil)
    let lastname = FreeFormTextFieldRow(tag: "LastName", title: "LastName", value: nil)
    let textView = FreeFormTextViewRow(tag: "TextView", title: "Detail", value: nil)
    let segmented = FreeFormSegmentedRow(tag: "Segmented", title: "Segmented", value: "Hello", options: ["Hello", "Bye!"])
    let button = FreeFormButtonRow(tag: "Button", title: "Tap Me!!")
    
    override func initializeForm() {
        
        self.form.title = "FreeForm Example"
        
        self.section1 = {
            let section = self.section1
            section.addRow(self.firstname)
            section.addRow(self.lastname)
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
            section.addRow(self.button)
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
            self.button.title = (self.button.title == "Tap Me!!" ? "Yes! One more time" : "Tap Me!!")
            self.form.reloadForm(true)
        }
        
        self.firstname.value = "Peerasak" as AnyObject?
        self.lastname.value = "Unsakon" as AnyObject?
        
    }
}
