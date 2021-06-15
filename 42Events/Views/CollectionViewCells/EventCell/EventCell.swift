//
//  EventCell.swift
//  42Events
//
//  Created by Phuc Nguyen on 05/06/2021.
//

import UIKit
import Kingfisher
import TagListView

final class EventCell: UICollectionViewCell {
    private weak var eventView: EventView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let eventView = UINib(nibName: "EventView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! EventView
        contentView.addSubview(eventView)
        eventView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: eventView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: eventView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: eventView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: eventView.bottomAnchor)
        ])
        self.eventView = eventView
    }
    
    func configure(viewModel: EventCellViewModel) {
        let startDateFormatter = DateFormatter()
        startDateFormatter.dateFormat = "dd MMM yyyy (HH:mm)"
        let endDateFormatter = DateFormatter()
        endDateFormatter.dateFormat = "dd MMM yyyy (HH:mm) O"
        eventView.imageView.kf.setImage(with: viewModel.imageURL(isMedal: false),
                                        placeholder: nil,
                                        options: [.transition(ImageTransition.fade(0.5))],
                                        progressBlock: nil,
                                        completionHandler: { (result) in })
        eventView.nameLabel.text = viewModel.race.name
        eventView.timeRangeLabel.text = "\(startDateFormatter.string(from: viewModel.startDate)) - \(endDateFormatter.string(from: viewModel.endDate))"
        eventView.freeMedalView.isHidden = !viewModel.race.isFreeEngraving
        eventView.tagListView.removeAllTags()
        eventView.tagListView.addTags(viewModel.tags.map { $0.title })
    }
    
}
