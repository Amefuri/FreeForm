//
//  FreeFormTextFieldCell.swift
//  FreeForm
//
//  Created by Peerasak Unsakon on 11/27/16.
//  Copyright © 2016 Peerasak Unsakon. All rights reserved.
//

import UIKit

public class FreeFormTextFieldRow: FreeFormRow {
    
    override public init(tag: String, title: String, value: AnyObject?) {
        super.init(tag: tag, title: title, value: value)
        self.cellType = String(describing: FreeFormTextFieldCell.self)
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
        titleLabel.text = row.title
        guard let value = row.value as? String else {
            textField.text = ""
            return
        }
        textField.text = value
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
