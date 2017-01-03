//
//  FreeFormButtonCell.swift
//  Pods
//
//  Created by Peerasak Unsakon on 1/3/17.
//
//

import UIKit

public class FreeFormButtonRow: FreeFormRow {
    public init(tag: String, title: String) {
        super.init(tag: tag, title: title, value: nil)
        self.cellType = String(describing: FreeFormButtonCell.self)
    }
}

public class FreeFormButtonCell: FreeFormCell {

    @IBOutlet public weak var button: UIButton!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override public func update() {
        super.update()
        guard let row = self.row as? FreeFormButtonRow else { return }
        self.button.setTitle(row.title, for: .normal)
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        guard let block = self.row.didTapped else { return }
        block(row)
    }
}
