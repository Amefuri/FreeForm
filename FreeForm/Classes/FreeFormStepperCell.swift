//
//  FreeFormStepperCell.swift
//  Pods
//
//  Created by Peerasak Unsakon on 1/3/17.
//
//

import UIKit

public class FreeFormStepperRow: FreeFormRow {
    
    public var minimumValue = 0
    public var maximumValue = 100
    
    public init(tag: String, title: String, max: Int, min: Int, value: Int) {
        super.init(tag: tag, title: title, value: value as AnyObject?)
        self.cellType = String(describing: FreeFormStepperCell.self)
        self.maximumValue = max
        self.minimumValue = min
    }
}

public class FreeFormStepperCell: FreeFormCell {

    @IBOutlet public weak var addButton: UIButton!
    @IBOutlet public weak var subtractButton: UIButton!
    @IBOutlet public weak var titleLabel: UILabel!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.addButton.layer.cornerRadius = 17
        self.subtractButton.layer.cornerRadius = 17 * 0.65
    }
    
    override public func update() {
        super.update()
        self.titleLabel.text = row.title
        
        guard let value = self.row.value as? Int else { return }
        guard let row = self.row as? FreeFormStepperRow else { return }
        self.subtractButton.isHidden = value == row.minimumValue
        
        if value == row.minimumValue {
            self.addButton.setTitle("+", for: .normal)
        }else {
            self.addButton.setTitle(String(value), for: .normal)
        }
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        guard let row = self.row as? FreeFormStepperRow else { return }
        guard let value = row.value as? Int else { return }
        guard value < row.maximumValue else {
            row.value = row.maximumValue as AnyObject?
            self.update()
            return
        }
        
        row.value = ((row.value as! Int) + 1) as AnyObject?
        self.update()
        
        guard let block = row.didChanged else { return }
        block(row.value as AnyObject, row)
    }
    
    @IBAction func subtractButtonTapped(_ sender: Any) {
        guard let row = self.row as? FreeFormStepperRow else { return }
        guard let value = row.value as? Int else { return }
        guard value > row.minimumValue else {
            row.value = row.minimumValue as AnyObject?
            self.update()
            return
        }
        row.value = ((row.value as! Int) - 1) as AnyObject?
        self.update()
        
        guard let block = row.didChanged else { return }
        block(row.value as AnyObject, row)
    }
    
}
