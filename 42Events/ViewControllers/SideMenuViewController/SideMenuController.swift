//
//  SideMenuController.swift
//  42Events
//
//  Created by Phuc Nguyen on 10/06/2021.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class SideMenuController: UITableViewController, HasViewModel {
    var viewModel: (SideMenuViewModel.Inputs) -> SideMenuViewModel.Outputs = { _ in fatalError("Missing view model of \(String(describing: self)).") }
    
    private let disposeBag = DisposeBag()
    
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

private extension SideMenuController {
    func setupViews() {
        self.tableView.tableFooterView = UIView()
        self.tableView.rowHeight = 60
        self.tableView.dataSource = nil
        self.tableView.delegate = nil
        self.tableView.register(UINib(nibName: "MenuItemCell", bundle: nil), forCellReuseIdentifier: "MenuItemCell")
        self.tableView.register(UINib(nibName: "MenuSwitchItemCell", bundle: nil), forCellReuseIdentifier: "MenuSwitchItemCell")
        
        self.tableView.rx.itemSelected
            .asDriver()
            .drive(onNext: { [weak self] indexPath in
                self?.tableView.deselectRow(at: indexPath, animated: true)
            })
            .disposed(by: self.disposeBag)
    }
    
    func bindViewModel() {
        let inputs = SideMenuViewModel.Inputs(changeMode: switcherValueChangedTrigger.asObservable())
        let outputs = viewModel(inputs)
        
        let dataSource = RxTableViewSectionedReloadDataSource<SideMenuSection> { [weak self] dataSource, tableView, indexPath, item in
            guard let self = self else { return UITableViewCell() }
            switch item {
            case .text(let viewModel):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemCell", for: indexPath) as? MenuItemCell else {
                    fatalError("Dequeue loading cell failed.")
                }
                cell.configure(viewModel: viewModel)
                
                return cell
            case .switcher(let viewModel):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuSwitchItemCell", for: indexPath) as? MenuSwitchItemCell else {
                    fatalError("Dequeue loading cell failed.")
                }
                cell.configure(viewModel: viewModel)
                cell.switchView.rx.controlEvent(.valueChanged)
                    .withLatestFrom(cell.switchView.rx.isOn)
                    .subscribe(onNext: { [weak self] isOn in
                        self?.switcherValueChangedTrigger.onNext(isOn)
                    })
                    .disposed(by: cell.disposeBag)
                
                self.switcherValue
                    .asDriver(onErrorJustReturn: false)
                    .drive(cell.switchView.rx.isOn)
                    .disposed(by: cell.disposeBag)
                
                return cell
            }
        }
        
        outputs.sections
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        outputs.modeChanged
            .subscribe(onNext: { [weak self] isOn in
                self?.switcherValue.onNext(isOn)
            })
            .disposed(by: self.disposeBag)
    }
}
