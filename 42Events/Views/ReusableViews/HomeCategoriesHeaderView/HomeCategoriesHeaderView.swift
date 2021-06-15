//
//  HomeCategoriesHeaderView.swift
//  42Events
//
//  Created by Phuc Nguyen on 12/06/2021.
//

import UIKit

final class HomeCategoriesHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.text = "Events"
        contentView.backgroundColor = .systemBackground
    }

}
