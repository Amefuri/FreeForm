//
//  FreeFormCell.swift
//  FreeForm
//
//  Created by Peerasak Unsakon on 11/27/16.
//  Copyright © 2016 Peerasak Unsakon. All rights reserved.
//

import UIKit

open class FreeFormCell: UITableViewCell {

    public var row: FreeFormRow!
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    public func setRowData(_ row: FreeFormRow) {
        self.row = row
        row.cell = self
        self.update()
    }
    
    open func update() {
        guard let row = self.row else { return }
        guard let block = row.customCell else { return }
        block(self)
    }
    
}
