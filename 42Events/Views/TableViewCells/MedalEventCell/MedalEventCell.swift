//
//  MedalEventCell.swift
//  42Events
//
//  Created by Phuc Nguyen on 05/06/2021.
//

import UIKit
import TagListView
import Kingfisher

final class MedalEventCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var tagListView: TagListView!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
        thumbnailImageView.contentMode = .scaleAspectFit
        thumbnailImageView.layer.cornerRadius = 12.0
        thumbnailImageView.layer.masksToBounds = true
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        subtitleLabel.font = .systemFont(ofSize: 12, weight: .thin)
        tagListView.textFont = .systemFont(ofSize: 14, weight: .light)
        tagListView.textColor = .label
        tagListView.borderColor = .systemGray
        tagListView.borderWidth = 0.5
        tagListView.tagBackgroundColor = .clear
        tagListView.cornerRadius = 8.0
        tagListView.marginX = 4.0
        tagListView.marginY = 4.0
        tagListView.paddingX = 8.0
        tagListView.paddingY = 4.0
    }
    
    func configure(viewModel: EventCellViewModel) {
        let startDateFormatter = DateFormatter()
        startDateFormatter.dateFormat = "dd MMM yyyy (HH:mm)"
        let endDateFormatter = DateFormatter()
        endDateFormatter.dateFormat = "dd MMM yyyy (HH:mm) O"
        thumbnailImageView.kf.setImage(with: viewModel.imageURL(isMedal: true),
                                        placeholder: nil,
                                        options: [.transition(ImageTransition.fade(0.5))],
                                        progressBlock: nil,
                                        completionHandler: { (result) in })
        titleLabel.text = viewModel.race.name
        subtitleLabel.text = "\(startDateFormatter.string(from: viewModel.startDate)) - \(endDateFormatter.string(from: viewModel.endDate))"
        tagListView.removeAllTags()
        tagListView.addTags(viewModel.tags.map { $0.title })
    }
    
}
