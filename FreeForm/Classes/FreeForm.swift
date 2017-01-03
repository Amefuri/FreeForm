//
//  FreeForm.swift
//  FreeForm
//
//  Created by Peerasak Unsakon on 11/27/16.
//  Copyright © 2016 Peerasak Unsakon. All rights reserved.
//

import UIKit

public typealias FreeFormReloadBlock = (_ reloadData: Bool) -> Void
public typealias FreeFormRowBlock = (_ row: FreeFormRow) -> Void
public typealias FreeFormCellBlock = (_ cell: FreeFormCell) -> Void
public typealias FreeFormValueRowBlock = (_ value: AnyObject, _ row: FreeFormRow) -> Void

open class FreeForm: NSObject {
    public var sections = FreeFormSections(array: [])
    public var title: String = ""
    public var reloadData: FreeFormReloadBlock?
    
    public var numOfSections: Int {
        return self.sections.getShowingSection().count
    }
    
    open func numOfRows(_ section: Int) -> Int {
        return self.sections.getShowingSection()[section].rows.numOfRows
    }
    
    open func addSection(_ section: FreeFormSection) {
        self.sections.appendSection(section)
    }
    
    open func getRow(_ indexPath: IndexPath) -> FreeFormRow {
        return self.sections.getShowingSection()[indexPath.section].rows.getShowingRow()[indexPath.row]
    }
    
    open func getRowNibNames() -> [String] {
        var nibNames = [String]()
        for section in self.sections.array {
            for row in section.rows.array {
                nibNames.append(row.cellType)
            }
        }
        let set = NSSet(array: nibNames)
        return set.allObjects as! [String]
    }
    
    open func hideSection(_ section: FreeFormSection) {
        section.hidden = true
        self.reloadForm(true)
    }
    
    open func showSection(_ section: FreeFormSection) {
        section.hidden = false
        self.reloadForm(true)
    }
    
    open func hideRow(_ row: FreeFormRow) {
        row.hidden = true
        self.reloadForm(true)
    }
    
    open func showRow(_ row: FreeFormRow) {
        row.hidden = false
        self.reloadForm(true)
    }
    
    open func setHeight(_ row: FreeFormRow, height: CGFloat) {
        row.height = height
        self.reloadForm(true)
    }
    
    open func reloadForm(_ reloadTableView: Bool) {
        guard let block = self.reloadData else { return }
        block(reloadTableView)
    }
}

open class FreeFormRow: NSObject {
    public var cellType: String = ""
    public var tag: String = ""
    public var title: String = ""
    public var value: AnyObject?
    public var hidden: Bool = false
    public var disable: Bool = false
    public var deletable: Bool = false
    
    public var height: CGFloat = 55
    public var tintColor: UIColor = UIColor.blue
    public var titleColor: UIColor = UIColor.black
    
    public var customCell: FreeFormCellBlock?
    public var didTapped: FreeFormRowBlock?
    public var didChanged: FreeFormValueRowBlock?
    public var didDeleted: FreeFormRowBlock?
    
    public var cell: FreeFormCell?
    
    init(tag: String, title: String, value: AnyObject?) {
        self.tag = tag
        self.title = title
        self.value = value
    }
    
}

open class FreeFormRows: NSObject {
    fileprivate var array: [FreeFormRow] = [FreeFormRow]()
    
    public subscript(index: Int) -> FreeFormRow {
        return array[index]
    }
    
    public var numOfRows: Int {
        return self.getShowingRow().count
    }
    
    public init(array: [FreeFormRow]) {
        self.array = array
    }
    
    open func getShowingRow() -> [FreeFormRow] {
        
        let array = self.array.filter { row in
            return row.hidden == false
        }
        
        return array
    }
    
    open func appendRows(_ row: FreeFormRow) {
        self.array.append(row)
    }
    
}

open class FreeFormSection: NSObject {
    
    public var tag: String = ""
    public var title: String = ""
    public var footerTitle: String = ""
    
    public var hidden: Bool = false
    
    public var rows = FreeFormRows(array: [])
    
    public init(tag: String, title: String) {
        self.tag = tag
        self.title = title
    }
    
    open func addRow(_ row: FreeFormRow) {
        self.rows.appendRows(row)
    }
}

open class FreeFormSections: NSObject {
    fileprivate var array: [FreeFormSection] = [FreeFormSection]()
    
    subscript(index: Int) -> FreeFormSection {
        return array[index]
    }
    
    public init(array: [FreeFormSection]) {
        self.array = array
    }
    
    open func appendSection(_ section: FreeFormSection) {
        self.array.append(section)
    }
    
    open func getShowingSection() -> [FreeFormSection] {
    
        let array = self.array.filter { section in
            return section.hidden == false
        }
        
        return array
    }
}
