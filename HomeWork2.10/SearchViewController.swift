//
//  SearchViewController.swift
//  HomeWork2.10
//
//  Created by Alex Sander on 01.03.2020.
//  Copyright © 2020 Alex Sander. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingLabel: UILabel!
    
    private var apiResponse: ApiResponse?

    @IBAction func searchAction() {
        guard let searchText = textField.text, !searchText.isEmpty else { return }
        
        loadingLabel.isHidden = false
        
        NetworkManager.shared.fetchData(from: "https://api.github.com/search/repositories?q=\(searchText)",
            with: { response in
                DispatchQueue.main.async {
                    self.apiResponse = response
                    self.tableView.reloadData()
                    self.loadingLabel.isHidden = true
                }
        })
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiResponse?.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RepositoryTableViewCell
        
        guard let repo = apiResponse?.items?[indexPath.row] else { return cell }
        cell.configure(with: repo)
        
        return cell
    }
}

