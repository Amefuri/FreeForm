//
//  FreeFormPushCell.swift
//  Pods
//
//  Created by Peerasak Unsakon on 1/5/17.
//
//

import UIKit

public class FreeFormPushRow: FreeFormRow {
    
    public var options = [String]()
    
    public init(tag: String, title: String, value: String, options: [String]) {
        super.init(tag: tag, title: title, value: value as AnyObject?)
        self.cellType = String(describing: FreeFormPushCell.self)
        self.options = options
    }
    
}

public class FreeFormPushCell: FreeFormCell {

    @IBOutlet public weak var titleLabel: UILabel!
    @IBOutlet public weak var valueLabel: UILabel!
    
    override public func update() {
        super.update()
        
        guard let row = self.row as? FreeFormPushRow else { return }
        
        self.titleLabel.text = row.title
        
        row.didTapped = { cell in
            self.pushOptionViewController(row: row)
        }
        
        guard let value = row.value as? String else {
            self.valueLabel.text = ""
            return
        }
        
        self.valueLabel.text = value
    }
    
    private func pushOptionViewController(row: FreeFormPushRow) {
        let optionViewController = FreeFormOptionsViewController()
        optionViewController.title = row.title
        optionViewController.options = row.options
        optionViewController.didSelectedBlock = { option in
            self.optionDidSelected(option: option, row: row)
        }
        row.formViewController.navigationController?.pushViewController(optionViewController, animated: true)
    }
    
    private func optionDidSelected(option: String, row: FreeFormPushRow) {
        row.value = option as AnyObject?
        self.update()
    }
    
    
}
