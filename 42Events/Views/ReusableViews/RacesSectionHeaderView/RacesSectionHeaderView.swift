//
//  RacesSectionHeaderView.swift
//  42Events
//
//  Created by Phuc Nguyen on 12/06/2021.
//

import UIKit
import RxSwift
import RxCocoa

final class RacesSectionHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var switchView: UISwitch!
    
    var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        subtitleLabel.font = .systemFont(ofSize: 12, weight: .regular)
        subtitleLabel.text = "Medal view"
        switchView.onTintColor = .systemRed
        contentView.backgroundColor = .systemBackground
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
}
