//
//  HomeEventsCell.swift
//  42Events
//
//  Created by Phuc Nguyen on 01/06/2021.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeEventsCell: UITableViewCell {
    
    private weak var collectionView: UICollectionView!
    private var disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
        flowLayout.itemSize = CGSize(width: 340, height: 300)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(collectionView)
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: collectionView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor)
        ])
        self.collectionView = collectionView
        collectionView.backgroundColor = .systemBackground
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(UINib(nibName: "EventCell", bundle: nil), forCellWithReuseIdentifier: "EventCell")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    func configure(viewModel: HomeEventsCellViewModel) {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        Observable.just(viewModel.races)
            .map({ races in races.map { EventCellViewModel(race: $0, isMedal: false) } })
            .asDriver(onErrorJustReturn: [])
            .drive(collectionView.rx.items(cellIdentifier: "EventCell", cellType: EventCell.self)) { [weak self] index, item, cell in
                cell.configure(viewModel: item)
            }
            .disposed(by: disposeBag)
    }
    
}
