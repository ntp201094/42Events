//
//  MenuItemCell.swift
//  42Events
//
//  Created by Phuc Nguyen on 10/06/2021.
//

import UIKit

final class MenuItemCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = .systemFont(ofSize: 12, weight: .medium)
        subtitleLabel.font = .systemFont(ofSize: 12, weight: .light)
    }
    
    func configure(viewModel: MenuItemViewModel) {
        iconImageView.image = UIImage(named: viewModel.item.imageName)?.withRenderingMode(.alwaysTemplate)
        iconImageView.tintColor = UIColor.label
        titleLabel.text = viewModel.item.title
        subtitleLabel.text = viewModel.item.subtitle
    }
    
}
