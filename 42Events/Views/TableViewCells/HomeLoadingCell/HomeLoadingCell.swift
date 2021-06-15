//
//  HomeLoadingCell.swift
//  42Events
//
//  Created by Phuc Nguyen on 01/06/2021.
//

import UIKit

final class HomeLoadingCell: UITableViewCell {
    
    var indicatorView: UIActivityIndicatorView?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            indicator.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            indicator.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16)
        ])
        self.indicatorView = indicator
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
