//
//  FreeFormCell.swift
//  FreeForm
//
//  Created by Peerasak Unsakon on 11/27/16.
//  Copyright © 2016 Peerasak Unsakon. All rights reserved.
//

import UIKit

public class FreeFormCell: UITableViewCell {

    public var row: FreeFormRow!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    public func setRowData(_ row: FreeFormRow) {
        self.row = row
        debugPrint("set row: \(row.tag)")
        self.update()
    }
    
    public func update() {
        debugPrint("update row: \(self.row.tag)")
        guard let row = self.row else { return }
        guard let block = row.customCell else { return }
        block(self)
    }
    
}
