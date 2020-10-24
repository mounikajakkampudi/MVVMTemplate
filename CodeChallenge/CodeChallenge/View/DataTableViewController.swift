//
//  DataTableViewController.swift
//  CodeChallenge
//
//  Created by Mounika Jakkampudi on 10/10/20.
//  Copyright © 2020 MVVM. All rights reserved.
//

import UIKit

class DataTableViewController: UITableViewController {

    var dataViewModel = DataViewModel()
    var isDataLoaded = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.showProgressHUD(progressLabel: "Loading...")
        self.fetchChildrensList()
    }
    // Set tableview properties and register cell
    func setupTableView() {
        self.tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: customTableCellResuseId)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 150
        self.tableView.separatorStyle = .none
    }
    // Do fetch call to DataViewModel
    func fetchChildrensList() {
        self.dataViewModel.fetchChildrensList { (result) in
            DispatchQueue.main.async {
                self.dismissHUD(isAnimated: true)
                   switch result {
                   case .failure(let error) :
                    self.showErrorAlert(title: appName, message: error.localizedDescription)
                   case .success(let success) :
                       if success {
                            self.isDataLoaded = true
                            self.tableView.reloadData()
                       } else {
                        self.showErrorAlert(title: appName, message: commonErrorMessage)
                       }
                    }
                   }
               }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.dataViewModel.getChildrenObjectCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: customTableCellResuseId, for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell(style: .default, reuseIdentifier: customTableCellResuseId)
        }
        cell.childrenDataObject = self.dataViewModel.getChildrenObjectAtIndex(index: indexPath.row)
        return cell
    }
    // Load feed data before reaching bottom
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // UITableView only moves in one direction, y axis
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height

        // Change 400.0 to adjust the distance from bottom
        if maximumOffset - currentOffset <= 400.0 {
               if !self.dataViewModel.afterLink.isEmpty {
                self.fetchChildrensList()
                self.tableView.tableFooterView = loadSpinnnnerView()
                self.tableView.tableFooterView?.isHidden = !self.isDataLoaded
            }
        }
    }
    // Load spinner at tableview footer while pagination of load more feed data
    func loadSpinnnnerView() -> UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView()

        if #available(iOS 13.0, *) {
            spinner.style = .medium
        } else {
            spinner.style = .gray
        }
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        return spinner
    }
}
