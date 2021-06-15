//
//  HomeViewController.swift
//  42Events
//
//  Created by Phuc Nguyen on 29/05/2021.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Kingfisher

final class HomeViewController: UITableViewController, HasViewModel {
    var viewModel: (HomeViewModel.Inputs) -> HomeViewModel.Outputs = { _ in fatalError("Missing view model of \(String(describing: self)).") }
    
    private var menuButton: UIButton!
    
    private let disposeBag = DisposeBag()
    private weak var dataSource: RxTableViewSectionedReloadDataSource<HomeSection>!
    
    private let categoryItemSelectedTrigger = PublishSubject<CategoryCellViewModel>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        self.bindViewModel()
        
    }
    
}

// MARK: - Private Methods
private extension HomeViewController {
    func setupViews() {
        title = "42Race"
        
        let menuButton = UIButton(type: .custom)
        menuButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        menuButton.setImage(UIImage(named: "menu")?.withRenderingMode(.alwaysTemplate), for: .normal)
        menuButton.tintColor = UIColor.label
        self.menuButton = menuButton
        
        let menuBarItem = UIBarButtonItem(customView: menuButton)
        let currWidth = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 24)
        currWidth?.isActive = true
        let currHeight = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 24)
        currHeight?.isActive = true
        self.navigationItem.leftBarButtonItem = menuBarItem
        
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = .none
        self.tableView.rowHeight = 280
        self.tableView.dataSource = nil
        self.tableView.delegate = nil
        self.tableView.register(UINib(nibName: "HomeLoadingCell", bundle: nil), forCellReuseIdentifier: "HomeLoadingCell")
        self.tableView.register(UINib(nibName: "HomeCarouselCell", bundle: nil), forCellReuseIdentifier: "HomeCarouselCell")
        self.tableView.register(UINib(nibName: "HomeCategoriesCell", bundle: nil), forCellReuseIdentifier: "HomeCategoriesCell")
        self.tableView.register(UINib(nibName: "HomeEventsCell", bundle: nil), forCellReuseIdentifier: "HomeEventsCell")
        self.tableView.register(UINib(nibName: "HomeCategoriesHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "HomeCategoriesHeaderView")
        self.tableView.register(UINib(nibName: "HomeEventsHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "HomeEventsHeaderView")
        
        self.tableView.rx.itemSelected
            .asDriver()
            .drive(onNext: { [weak self] indexPath in
                self?.tableView.deselectRow(at: indexPath, animated: true)
            })
            .disposed(by: self.disposeBag)
        
        self.tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func bindViewModel() {
        let inputs = HomeViewModel.Inputs(
            menuButtonPressed: menuButton.rx.tap.asObservable(),
            categoryItemSelected: categoryItemSelectedTrigger.asObservable()
        )
        let outputs = viewModel(inputs)
        
        let dataSource = RxTableViewSectionedReloadDataSource<HomeSection>(configureCell: { [weak self] dataSource, tableView, indexPath, item -> UITableViewCell in
            guard let self = self else { return UITableViewCell() }
            switch item {
            case .loading:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeLoadingCell", for: indexPath) as? HomeLoadingCell else {
                    fatalError("Dequeue loading cell failed.")
                }
                cell.indicatorView?.startAnimating()
                
                return cell
            case .carousel(let viewModel):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCarouselCell", for: indexPath) as? HomeCarouselCell else {
                    fatalError("Dequeue loading cell failed.")
                }
                cell.configure(viewModel: viewModel)
                
                return cell
            case .categories(let viewModel):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCategoriesCell", for: indexPath) as? HomeCategoriesCell else {
                    fatalError("Dequeue loading cell failed.")
                }
                cell.configure(viewModel: viewModel)
                cell.collectionView.rx.modelSelected(CategoryCellViewModel.self)
                    .bind(onNext: { [weak self] viewModel in
                        guard let self = self else { return }
                        self.categoryItemSelectedTrigger.onNext(viewModel)
                    })
                    .disposed(by: cell.disposeBag)
                
                return cell
            case .events(let viewModel):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeEventsCell", for: indexPath) as? HomeEventsCell else {
                    fatalError("Dequeue loading cell failed.")
                }
                cell.configure(viewModel: viewModel)
                
                return cell
            }
        })
        self.dataSource = dataSource
        
        outputs.sections
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

extension HomeViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = dataSource.sectionModels[indexPath.section].items[indexPath.row]
        switch item {
        case .carousel:
            return 170
        case .categories:
            return 165
        case .events:
            return 320
        case .loading:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionModel = dataSource.sectionModels[section]
        switch sectionModel {
        case .categories:
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HomeCategoriesHeaderView") as? HomeCategoriesHeaderView else {
                fatalError("Unexpected table header view")
            }
            
            return header
        case let .events(title, _):
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HomeEventsHeaderView") as? HomeEventsHeaderView else {
                fatalError("Unexpected table header view")
            }
            header.configure(title: title)
            return header
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionModel = dataSource.sectionModels[section]
        switch sectionModel {
        case .categories:
            return 44
        case .events:
            return 36
        default:
            return 0
        }
    }
}
