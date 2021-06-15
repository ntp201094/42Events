//
//  HomeSectionHeaderView.swift
//  42Events
//
//  Created by Phuc Nguyen on 08/06/2021.
//

import UIKit

final class HomeEventsHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var trailingLabel: UILabel!
    @IBOutlet weak var trailingImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        lineView.backgroundColor = .systemGray2
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = .label
        trailingLabel.font = .systemFont(ofSize: 12, weight: .medium)
        trailingLabel.textColor = .label
        trailingLabel.text = "View all"
        trailingImageView.tintColor = .label
        contentView.backgroundColor = .systemBackground
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }

}
