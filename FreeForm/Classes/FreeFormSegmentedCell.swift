//
//  FreeFormSegmentedCell.swift
//  FreeForm
//
//  Created by Peerasak Unsakon on 11/29/16.
//  Copyright © 2016 Peerasak Unsakon. All rights reserved.
//

import UIKit

public class FreeFormSegmentedRow: FreeFormRow {
    
    public var options = [String]()
    
    public init(tag: String, title: String, value: String, options: [String]) {
        super.init(tag: tag, title: title, value: value as AnyObject?)
        self.cellType = String(describing: FreeFormSegmentedCell.self)
        self.options = options
    }
}

public class FreeFormSegmentedCell: FreeFormCell {

    @IBOutlet weak public var titleLabel: UILabel!
    @IBOutlet weak public var segmentedControl: UISegmentedControl!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override public func update() {
        super.update()
        guard let row = self.row as? FreeFormSegmentedRow else { return }
        self.titleLabel.text = row.title
        self.segmentedControl.removeAllSegments()
        for (index, option) in row.options.enumerated() {
            let name = option
            self.segmentedControl.insertSegment(withTitle: name, at: index, animated: false)
        }
        self.segmentedControl.selectedSegmentIndex = row.options.index(where: {$0 == row.value as! String})!
        self.segmentedControl.isEnabled = !row.disable
    }
    
    @IBAction public func segmentedValueChanged(_ sender: AnyObject) {
        guard
            let segmentedControl = sender as? UISegmentedControl,
            let row = self.row as? FreeFormSegmentedRow
        else {
            return
        }
        let value = row.options[segmentedControl.selectedSegmentIndex]
        row.value = value as AnyObject?
        guard let block = row.didChanged else { return }
        block(value as AnyObject, row)
    }
    
}
