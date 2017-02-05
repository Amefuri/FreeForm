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

    @IBOutlet weak var subtractButtonTrailingConstraint: NSLayoutConstraint!
    @IBOutlet public weak var addButton: UIButton!
    @IBOutlet public weak var subtractButton: UIButton!
    @IBOutlet public weak var titleLabel: UILabel!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.addButton.layer.cornerRadius = 17
        self.subtractButton.layer.cornerRadius = 17 * 0.65
        self.subtractButton.isHidden = true
    }
    
    override public func update() {
        super.update()
        self.titleLabel.text = row.title
        
        guard let value = self.row.value as? Int else { return }
        guard let row = self.row as? FreeFormStepperRow else { return }
        if value == row.minimumValue {
            self.hideSubTractButton()
        }else {
            self.showSubtractButton()
        }
        
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
    
    private func showSubtractButton() {
        guard self.subtractButtonTrailingConstraint.constant == 10 else { return }
        self.addButton.isEnabled = false
        self.subtractButton.isHidden = false
        self.subtractButton.alpha = 0
        UIView.animate(withDuration: 0.17, delay: 0, options: .curveEaseIn, animations: {
            self.subtractButton.alpha = 1
            self.subtractButtonTrailingConstraint.constant = 44
            self.layoutIfNeeded()
        }) { (completed) in
            self.addButton.isEnabled = true
        }
    }
    
    private func hideSubTractButton() {
        guard self.subtractButtonTrailingConstraint.constant == 44 else { return }
        self.addButton.isEnabled = false
        self.subtractButton.alpha = 1
        UIView.animate(withDuration: 0.17, delay: 0, options: .curveEaseOut, animations: {
            self.subtractButton.alpha = 0
            self.subtractButtonTrailingConstraint.constant = 10
            self.layoutIfNeeded()
        }) { (completed) in
            self.subtractButton.isHidden = true
            self.addButton.isEnabled = true
        }
    }
    
}
