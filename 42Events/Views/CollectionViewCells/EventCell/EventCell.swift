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
        eventView.configure(imageURL: viewModel.imageURL, name: viewModel.name, startDate: viewModel.startDate, endDate: viewModel.endDate, isFreeEngraving: viewModel.isFreeEngraving, tags: viewModel.tags.map { $0.title })
    }
    
}
