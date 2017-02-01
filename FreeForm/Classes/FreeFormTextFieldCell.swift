//
//  FreeFormTextFieldCell.swift
//  FreeForm
//
//  Created by Peerasak Unsakon on 11/27/16.
//  Copyright © 2016 Peerasak Unsakon. All rights reserved.
//

import UIKit
import Validator

public class FreeFormTextFieldRow: FreeFormRow {
    
    public var validationRuleSet: ValidationRuleSet<String>? = ValidationRuleSet<String>()
    public var validationErrors: [String]?
    
    override public init(tag: String, title: String, value: AnyObject?) {
        super.init(tag: tag, title: title, value: value)
        self.cellType = String(describing: FreeFormTextFieldCell.self)
    }
    
    public func updateValidationState(result: ValidationResult) -> Bool {
        
        guard let value = self.value as? String, value != "" else {
            return self.isOptional
        }
        
        switch result {
        case .invalid(let failures):
            self.validated = false
            self.validationErrors = failures.map { $0.localizedDescription }
            return false
        case .valid:
            self.validated = true
            self.validationErrors?.removeAll()
            return true
        }
    }
}

public class FreeFormTextFieldCell: FreeFormCell {

    @IBOutlet weak public var textField: UITextField!
    @IBOutlet weak public var titleLabel: UILabel!
    @IBOutlet weak public var errorLabel: UILabel!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.textField.delegate = self
    }
    
    override public func update() {
        super.update()
        guard let textfieldRow = self.row as? FreeFormTextFieldRow else { return }
        
        titleLabel.text = textfieldRow.title
        guard let value = textfieldRow.value as? String else {
            textField.text = ""
            return
        }
        
        self.textField.validationRules = textfieldRow.validationRuleSet
        self.textField.validateOnInputChange(enabled: true)
        self.textField.validationHandler = { result in
            if textfieldRow.updateValidationState(result: result) {
                self.clearError()
            }else {
                if let message = textfieldRow.validationErrors?.joined(separator: "/") {
                    self.showError(message: message)
                }
            }
        }
        
        textField.text = value
    }
    
    public func showError(message: String) {
        self.errorLabel.text = message
    }
    
    public func clearError() {
        self.errorLabel.text = ""
        guard let textfieldRow = self.row as? FreeFormTextFieldRow else { return }
        textfieldRow.validationErrors?.removeAll()
    }
}

extension FreeFormTextFieldCell: UITextFieldDelegate {
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        row.value = textField.text as AnyObject?
        if let changeBlock = row.didChanged {
            changeBlock(textField.text! as AnyObject, row)
        }
    }
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        guard row.disable == false else { return false }
        
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
