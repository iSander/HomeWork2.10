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
        guard let url = URL(string: "https://api.github.com/search/repositories?q=\(searchText)") else { return }
        
        loadingLabel.isHidden = false
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error { print(error); return }
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                self.apiResponse = try decoder.decode(ApiResponse.self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.loadingLabel.isHidden = true
                }
            } catch let error {
                print(error)
            }
        }.resume()
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

