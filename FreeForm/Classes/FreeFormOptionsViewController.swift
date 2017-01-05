//
//  FreeFormOptionsViewController.swift
//  Pods
//
//  Created by Peerasak Unsakon on 1/5/17.
//
//

import UIKit

public typealias FreeFormOptionSelectedBlock = (_ option: String) -> ()

public class FreeFormOptionsViewController: UITableViewController {
    
    public var didSelectedBlock: FreeFormOptionSelectedBlock?
    public var options: [String] = [String]()
    public var filteredOptions: [String] = [String]()
    let searchController = UISearchController(searchResultsController: nil)
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.registerNib()
        self.setupSearchBar()
    }

    private func registerNib() {
        let podBundle = Bundle(for: FreeFormOptionsViewController.self)
        let bundleURL = podBundle.url(forResource: "FreeForm", withExtension: "bundle")
        let bundle = Bundle(url: bundleURL!)
        self.tableView.register(UINib(nibName: "FreeFormOptionCell", bundle: bundle), forCellReuseIdentifier: "FreeFormOptionCell")
    }
    
    private func setupSearchBar() {
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        self.definesPresentationContext = true
        self.tableView.tableHeaderView = self.searchController.searchBar
        self.extendedLayoutIncludesOpaqueBars = true
        
        self.searchController.searchBar.barTintColor = self.tableView.backgroundColor
        self.searchController.searchBar.tintColor = UIColor.red
        self.searchController.searchBar.searchBarStyle = .minimal
        self.searchController.searchBar.barStyle = .default
    }
    
    // MARK: - Table view data source
    override public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isSearching() {
            return filteredOptions.count
        }
        return options.count
    }

    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FreeFormOptionCell", for: indexPath)
        
        var option: String = ""
        if self.isSearching() {
            option = self.filteredOptions[indexPath.row]
        } else {
            option = self.options[indexPath.row]
        }
        cell.textLabel?.text = option
        return cell
    }
    
    override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let block = self.didSelectedBlock {
            if self.isSearching() {
                block(self.filteredOptions[indexPath.row])
            } else {
                block(self.options[indexPath.row])
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
}

extension FreeFormOptionsViewController: UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating {
    
    public func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        self.filterContentForSearchText(searchText: text)
    }
    
    func isSearching() -> Bool {
        return self.searchController.isActive && self.searchController.searchBar.text != ""
    }
    
    private func filterContentForSearchText(searchText: String) {
        self.filteredOptions = self.options.filter { option in
            return option.lowercased().contains(searchText.lowercased())
        }
        self.tableView.reloadData()
    }
}
