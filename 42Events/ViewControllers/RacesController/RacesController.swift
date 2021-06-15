//
//  RacesController.swift
//  42Events
//
//  Created by Phuc Nguyen on 10/06/2021.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class RacesController: UITableViewController, HasViewModel {
    
    var viewModel: (RacesViewModel.Inputs) -> RacesViewModel.Outputs = { _ in fatalError("Missing view model of \(String(describing: self)).") }
    
    private let disposeBag = DisposeBag()
    private weak var dataSource: RxTableViewSectionedReloadDataSource<RacesSection>!
    
    private var closeButton: UIButton!
    
    private let switcherValueChangedTrigger = PublishSubject<Bool>()
    private let switcherValue = BehaviorSubject(value: false)
    
    deinit {
        switcherValueChangedTrigger.onCompleted()
        switcherValue.onCompleted()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        self.bindViewModel()
    }
}

private extension RacesController {
    func setupViews() {
        title = "Events"
        
        let closeButton = UIButton(type: .custom)
        closeButton.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        closeButton.tintColor = .label
        self.closeButton = closeButton
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: closeButton)
        
        self.tableView.tableFooterView = UIView()
        self.tableView.estimatedRowHeight = 100
        self.tableView.dataSource = nil
        self.tableView.delegate = nil
        
        self.tableView.register(UINib(nibName: "MenuItemCell", bundle: nil), forCellReuseIdentifier: "MenuItemCell")
        self.tableView.register(UINib(nibName: "ListedEventCell", bundle: nil), forCellReuseIdentifier: "ListedEventCell")
        self.tableView.register(UINib(nibName: "MedalEventCell", bundle: nil), forCellReuseIdentifier: "MedalEventCell")
        self.tableView.register(UINib(nibName: "RacesSectionHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "RacesSectionHeaderView")
        
        self.tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func bindViewModel() {
        let inputs = RacesViewModel.Inputs(
            close: self.closeButton.rx.tap.asObservable(),
            medalViewToggle: switcherValueChangedTrigger.asObservable()
        )
        let outputs = viewModel(inputs)
        
        let dataSource = RxTableViewSectionedReloadDataSource<RacesSection>(configureCell: { [weak self] dataSource, tableView, indexPath, item -> UITableViewCell in
            guard let self = self else { return UITableViewCell() }
            switch item {
            case .loading:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeLoadingCell", for: indexPath) as? HomeLoadingCell else {
                    fatalError("Dequeue loading cell failed.")
                }
                cell.indicatorView?.startAnimating()
                
                return cell
            case .race(let viewModel):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListedEventCell", for: indexPath) as? ListedEventCell else {
                    fatalError("Dequeue loading cell failed.")
                }
                cell.configure(viewModel: viewModel)
                
                return cell
            case .medalRace(let viewModel):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "MedalEventCell", for: indexPath) as? MedalEventCell else {
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
        
        outputs.medalViewChanged
            .subscribe(onNext: { [weak self] isOn in
                self?.switcherValue.onNext(isOn)
            })
            .disposed(by: self.disposeBag)
    }
}

extension RacesController {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionModel = dataSource.sectionModels[section]
        switch sectionModel {
        case .races(let title, _):
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "RacesSectionHeaderView") as? RacesSectionHeaderView else {
                fatalError("Unexpected table header view")
            }
            header.configure(title: title)
            header.switchView.rx.controlEvent(.valueChanged)
                .withLatestFrom(header.switchView.rx.isOn)
                .subscribe(onNext: { [weak self] isOn in
                    self?.switcherValueChangedTrigger.onNext(isOn)
                })
                .disposed(by: header.disposeBag)
            
            self.switcherValue
                .asDriver(onErrorJustReturn: false)
                .drive(header.switchView.rx.isOn)
                .disposed(by: header.disposeBag)
            
            return header
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionModel = dataSource.sectionModels[section]
        switch sectionModel {
        case .races:
            return 50
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = dataSource.sectionModels[indexPath.section].items[indexPath.row]
        switch item {
        case .loading:
            return 0
        case .race:
            return 300
        case .medalRace:
            return UITableView.automaticDimension
        }
    }
}
