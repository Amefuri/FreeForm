//
//  FreeFormTextViewCell.swift
//  FreeForm
//
//  Created by Peerasak Unsakon on 11/28/16.
//  Copyright © 2016 Peerasak Unsakon. All rights reserved.
//

import UIKit
import Validator

public class FreeFormTextViewRow: FreeFormRow {
    override public init(tag: String, title: String, value: AnyObject?) {
        super.init(tag: tag, title: title, value: value)
        self.cellType = String(describing: FreeFormTextViewCell.self)
        self.height = 110
    }
}

public class FreeFormTextViewCell: FreeFormCell {

    @IBOutlet weak public var titleLabel: UILabel!
    @IBOutlet weak public var textView: UITextView!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.textView.delegate = self
    }

    override public func update() {
        super.update()
        self.titleLabel.text = row.title
        guard let value = row.value as? String else { return }
        self.textView.text = value
    }
    
}

extension FreeFormTextViewCell: UITextViewDelegate {

    public func textViewDidEndEditing(_ textView: UITextView) {
        guard let row = self.row else { return }
        row.value = textView.text as AnyObject?
        guard let block = row.didChanged else { return }
        block(textView.text as AnyObject, row)
        self.update()
    }
    
    public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        guard let row = self.row else { return false }
        return !row.disable
    }
    
}
