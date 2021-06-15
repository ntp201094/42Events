//
//  EventView.swift
//  42Events
//
//  Created by Phuc Nguyen on 05/06/2021.
//

import UIKit
import TagListView
import Kingfisher

final class EventView: UIView {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var freeMedalView: UIView!
    @IBOutlet weak var freeMedalLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeRangeLabel: UILabel!
    @IBOutlet weak var tagListView: TagListView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12.0
        imageView.layer.masksToBounds = true
        freeMedalView.layer.cornerRadius = 12.0
        freeMedalView.layer.masksToBounds = true
        freeMedalView.backgroundColor = .systemRed
        freeMedalLabel.font = .systemFont(ofSize: 14, weight: .medium)
        freeMedalLabel.textColor = .white
        freeMedalLabel.text = "FREE MEDAL ENGRAVING"
        nameLabel.font = .systemFont(ofSize: 16, weight: .bold)
        timeRangeLabel.font = .systemFont(ofSize: 12, weight: .thin)
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
    
    func configure(imageURL: URL?, name: String, startDate: String, endDate: String, isFreeEngraving: Bool, tags: [String]) {
        imageView.kf.setImage(with: imageURL,
                              placeholder: nil,
                              options: [.transition(ImageTransition.fade(0.5))],
                              progressBlock: nil,
                              completionHandler: { (result) in })
        nameLabel.text = name
        timeRangeLabel.text = "\(startDate) - \(endDate)"
        freeMedalView.isHidden = !isFreeEngraving
        tagListView.removeAllTags()
        tagListView.addTags(tags)
    }
    
}
