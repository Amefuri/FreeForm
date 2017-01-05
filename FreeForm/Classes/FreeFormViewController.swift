//
//  FreeFormViewController.swift
//  FreeForm
//
//  Created by Peerasak Unsakon on 11/28/16.
//  Copyright © 2016 Peerasak Unsakon. All rights reserved.
//

import UIKit

open class FreeFormViewController: UITableViewController {

    public var form = FreeForm()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView = UITableView(frame: self.view.bounds, style: .grouped)
        self.form.reloadData = { reloadData in
            guard reloadData == true else { return }
            self.reloadForm()
        }
        
        self.initializeForm()
        self.registerNibName()
        
        guard self.form.title != "" else { return }
        self.title = self.form.title
    }

    open func registerNibName() {
        let cellNames = ["FreeFormTextFieldCell", "FreeFormTextViewCell", "FreeFormSegmentedCell", "FreeFormButtonCell", "FreeFormStepperCell", "FreeFormTextCell", "FreeFormSwitchCell", "FreeFormDatetimeCell", "FreeFormPushCell"]
        let nibNames = self.form.getRowNibNames()
        let podBundle = Bundle(for: FreeFormViewController.self)
        let bundleURL = podBundle.url(forResource: "FreeForm", withExtension: "bundle")
        let bundle = Bundle(url: bundleURL!)
        for name in nibNames {
            if cellNames.contains(name) {
                self.tableView.register(UINib(nibName: name, bundle: bundle), forCellReuseIdentifier: name)
            }else {
                self.tableView.register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: name)
            }
        }
    }
    
    open func initializeForm() {
    
    }
    
    fileprivate func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    open func reloadForm() {
        let indexSet = IndexSet(integersIn: NSRange(location: 0, length: self.form.numOfSections).toRange() ?? 0..<0)
        self.tableView.reloadSections(indexSet, with: .automatic)
    }
    
    // MARK: - Table view data source

    override open func numberOfSections(in tableView: UITableView) -> Int {
        return self.form.numOfSections
    }

    override open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.form.numOfRows(section)
    }

    override open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.form.getRow(indexPath)
        row.formViewController = self
        let cell = tableView.dequeueReusableCell(withIdentifier: row.cellType, for: indexPath) as! FreeFormCell
        cell.setRowData(row)
        return cell
    }
    
    override open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = self.form.getRow(indexPath)
        return row.height
    }
 
    override open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.hideKeyboard()
        let row = self.form.getRow(indexPath)
        guard let block = row.didTapped else { return }
        block(row)
    }
    
    override open func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let row = self.form.getRow(indexPath)
        guard row.disable == false else { return false }
        return row.deletable
    }
    
    override open func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let row = self.form.getRow(indexPath)
            guard let block = row.didDeleted else { return }
            block(row)
        }
    }
    
}
