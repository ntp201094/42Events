//
//  CategoryCell.swift
//  42Events
//
//  Created by Phuc Nguyen on 01/06/2021.
//

import UIKit

final class CategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = .systemFont(ofSize: 16, weight: .heavy)
        titleLabel.textColor = .white
        backgroundImageView.contentMode = .right
        layer.cornerRadius = 12.0
        layer.masksToBounds = true
    }
    
    func configure(viewModel: CategoryCellViewModel) {
        titleLabel.text = viewModel.category.displayName
        backgroundImageView.image = viewModel.category.image
        contentView.backgroundColor = viewModel.category.backgroundColor
    }

}
