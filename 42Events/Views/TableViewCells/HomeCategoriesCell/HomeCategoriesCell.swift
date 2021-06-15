//
//  HomeCategoriesCell.swift
//  42Events
//
//  Created by Phuc Nguyen on 01/06/2021.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeCategoriesCell: UITableViewCell {
    
    weak var collectionView: UICollectionView!
    var disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let contentWidth = UIScreen.main.bounds.width - 8 - 8
        let itemWidth = (contentWidth - CGFloat(Category.allCases.count - 1) * 10) / CGFloat(Category.allCases.count)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
        flowLayout.itemSize = CGSize(width: itemWidth, height: 145)
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
        collectionView.dataSource = nil
        collectionView.delegate = nil
        collectionView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    func configure(viewModel: HomeCategoriesCellViewModel) {
        Observable.just(viewModel.categories)
            .map({ $0.map { CategoryCellViewModel(category: $0) } })
            .asDriver(onErrorJustReturn: [])
            .drive(collectionView.rx.items(cellIdentifier: "CategoryCell", cellType: CategoryCell.self)) { [weak self] index, item, cell in
                cell.configure(viewModel: item)
            }
            .disposed(by: disposeBag)
    }
    
}
