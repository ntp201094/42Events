//
//  ListedEventCell.swift
//  42Events
//
//  Created by Phuc Nguyen on 12/06/2021.
//

import UIKit
import TagListView
import Kingfisher

final class ListedEventCell: UITableViewCell {
    
    private weak var eventView: EventView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
        let eventView = UINib(nibName: "EventView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! EventView
        contentView.addSubview(eventView)
        eventView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: eventView.leadingAnchor, constant: -16),
            contentView.topAnchor.constraint(equalTo: eventView.topAnchor, constant: -10),
            contentView.trailingAnchor.constraint(equalTo: eventView.trailingAnchor, constant: 16),
            contentView.bottomAnchor.constraint(equalTo: eventView.bottomAnchor)
        ])
        self.eventView = eventView
        
        eventView.imageView.layer.cornerRadius = 0
    }
    
    func configure(viewModel: EventCellViewModel) {
        eventView.configure(imageURL: viewModel.imageURL, name: viewModel.name, startDate: viewModel.startDate, endDate: viewModel.endDate, isFreeEngraving: viewModel.isFreeEngraving, tags: viewModel.tags.map { $0.title })
    }
    
}
