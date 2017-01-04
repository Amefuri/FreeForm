//
//  FreeFormTextCell.swift
//  Pods
//
//  Created by Peerasak Unsakon on 1/4/17.
//
//

import UIKit

public class FreeFormTextRow: FreeFormRow {
    override public init(tag: String, title: String, value: AnyObject?) {
        super.init(tag: tag, title: title, value: value)
        self.cellType = String(describing: FreeFormTextCell.self)
    }
}

public class FreeFormTextCell: FreeFormCell {

    @IBOutlet public weak var titleLabel: UILabel!
    @IBOutlet public weak var valueLabel: UILabel!
    
    override public func update() {
        guard let row = self.row as? FreeFormTextRow else {
            self.titleLabel.text = ""
            return
        }
        
        self.titleLabel.text = row.title
        
        guard let value = row.value as? String else {
            self.valueLabel.text = ""
            return
        }
        
        self.valueLabel.text = value
    }
}
