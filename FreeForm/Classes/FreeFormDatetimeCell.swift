//
//  FreeFormDatetimeCell.swift
//  Pods
//
//  Created by Peerasak Unsakon on 1/4/17.
//
//

import UIKit

private extension Date {
    func toString(dateFormat : String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        return dateFormatter.string(from: self)
    }
}

public class FreeFormDatetimeRow: FreeFormRow {
    
    public var maximumDate: Date?
    public var minimumDate: Date?
    public var isExtended: Bool = false
    
    public init(tag: String, title: String, selectedDate: Date?, min: Date?, max: Date?) {
        super.init(tag: tag, title: title, value: selectedDate as AnyObject?)
        self.maximumDate = max
        self.minimumDate = min
        self.cellType = String(describing: FreeFormDatetimeCell.self)
    }

}

public class FreeFormDatetimeCell: FreeFormCell {

    @IBOutlet public weak var titleLabel: UILabel!
    @IBOutlet public weak var datetimeLabel: UILabel!
    @IBOutlet public weak var datePicker: UIDatePicker!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override public func update() {
        guard let row = self.row as? FreeFormDatetimeRow else { return }
        
        row.didTapped = { row in
            if row.disable == false {
                self.stretchCell()
            }
        }
        
        self.titleLabel.text = row.title
        guard let date = row.value as? Date else { return }
        self.datePicker.date = date
        self.setDateLabel(date: date)
    }
    
    private func stretchCell() {
        guard let row = self.row as? FreeFormDatetimeRow else { return }
        
        if row.isExtended == true {
            row.height = 50
            row.isExtended = false
        }else {
            row.height = 50 + 216
            row.isExtended = true
        }
        
        row.formViewController.reloadForm()
    }
    
    @IBAction func datePickerValueChanged(_ sender: Any) {
        guard let row = self.row as? FreeFormDatetimeRow else { return }
        var date = self.datePicker.date
       
        if let max = row.maximumDate {
            if date > max {
                date = max
            }
        }
        
        if let min = row.minimumDate {
            if date < min {
                date = min
            }
        }
        
        row.value = date as AnyObject?
        self.datePicker.setDate(date, animated: true)
        self.setDateLabel(date: date)
        
        guard let block = row.didChanged else { return }
        block(row.value as AnyObject, row)
    }
    
    private func setDateLabel(date: Date) {
        self.datetimeLabel.text = date.toString(dateFormat: "dd MMM yyyy")
    }
    
}
