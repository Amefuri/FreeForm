//
//  FreeFormSwitchCell.swift
//  Pods
//
//  Created by Peerasak Unsakon on 1/4/17.
//
//

import UIKit

public class FreeFormSwitchRow: FreeFormRow {
    
    override public init(tag: String, title: String, value: AnyObject?) {
        super.init(tag: tag, title: title, value: value)
        self.cellType = String(describing: FreeFormSwitchCell.self)
    }
    
    public func isOn() -> Bool {
        guard let value = self.value as? Bool else { return false }
        return value
    }
    
}

public class FreeFormSwitchCell: FreeFormCell {

    @IBOutlet public weak var titleLabel: UILabel!
    
    @IBOutlet public weak var cellSwitch: UISwitch!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override public func update() {
        guard let row = self.row as? FreeFormSwitchRow else { return }
        self.titleLabel.text = row.title
        
        guard let value = row.value as? Bool else { return }
        self.cellSwitch.setOn(value, animated: true)
    }
    
    @IBAction func cellSwitchValueChanged(_ sender: Any) {
        guard let row = self.row as? FreeFormSwitchRow else { return }
        row.value = self.cellSwitch.isOn as AnyObject?
        
        guard let block = row.didChanged else { return }
        block(row.value as AnyObject, row)
    }
}
