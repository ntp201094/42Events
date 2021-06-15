//
//  HomeCarouselCell.swift
//  42Events
//
//  Created by Phuc Nguyen on 29/05/2021.
//

import UIKit
import ImageSlideshow
import Kingfisher

final class HomeCarouselCell: UITableViewCell {

    @IBOutlet weak var imageSlideShow: ImageSlideshow!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageSlideShow.slideshowInterval = 5.0
        imageSlideShow.contentScaleMode = .scaleAspectFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(viewModel: HomeCarouselCellViewModel) {
        imageSlideShow.setImageInputs(viewModel.imageURLs.map({ KingfisherSource(url: $0, placeholder: nil, options: [.transition(ImageTransition.fade(0.5))]) }))
    }
    
}
