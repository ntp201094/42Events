//
//  MenuSwitchItemCell.swift
//  42Events
//
//  Created by Phuc Nguyen on 14/06/2021.
//

import UIKit
import RxSwift
import RxCocoa

final class MenuSwitchItemCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var switchView: UISwitch!
    
    var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = .systemFont(ofSize: 12, weight: .medium)
        switchView.onTintColor = .systemRed
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    func configure(viewModel: MenuItemViewModel) {
        thumbnailImageView.image = UIImage(systemName: viewModel.item.imageName)
        thumbnailImageView.tintColor = UIColor.label
        titleLabel.text = viewModel.item.title
    }
    
}
