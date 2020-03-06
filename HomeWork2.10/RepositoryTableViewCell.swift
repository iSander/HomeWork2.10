//
//  RepositoryTableViewCell.swift
//  HomeWork2.10
//
//  Created by Alex Sander on 01.03.2020.
//  Copyright © 2020 Alex Sander. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var ownerImageView: ImageView!

    func configure(with repository: Repository) {
        nameLabel.text = repository.name
        ownerNameLabel.text = repository.owner?.login
        descriptionLabel.text = repository.description
        urlLabel.text = repository.htmlUrl
        starsLabel.text = "★\(repository.stargazersCount ?? 0)"
        
        ownerImageView.fetchImage(from: repository.owner?.avatarUrl)
    }
}
