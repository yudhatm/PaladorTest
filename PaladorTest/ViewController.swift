//
//  ViewController.swift
//  PaladorTest
//
//  Created by Yudha on 14/09/22.
//

import UIKit
import SwiftyJSON
import RxSwift

class ViewController: UIViewController {
    var viewModel: MainViewModelType = MainViewModel()
    
    @IBOutlet weak var mainStackView: UIStackView!
    
    var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView()
        setupRx()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.doGroupEmployeeData()
    }
    
    func setupRx() {
        viewModel.employeeListObs
            .observe(on: MainScheduler.instance)
            .subscribe { employeeList in
                
            }.disposed(by: bag)
        
        viewModel.employeeGroupObs
            .observe(on: MainScheduler.instance)
            .subscribe { employeeGroup in
                self.setupStackView(list: employeeGroup)
            }.disposed(by: bag)
    }
    
    func setupStackView(list: [EmployeeWithTree]) {
        for subview in mainStackView.arrangedSubviews {
            mainStackView.removeArrangedSubview(subview)
        }
        
        for item in list {
            let view: ExpandableListView = UIView.fromNib()
            view.nameLabel.text = "\(item.name ?? "") (\(item.downline.count))"
            view.haveChildView = !item.downline.isEmpty
            
            for downline in item.downline {
                let nestedView: ExpandableListView = UIView.fromNib()
                nestedView.haveChildView = !downline.downline.isEmpty
                nestedView.adjustNestedConstraint(nestedLevel: 2)
                nestedView.nameLabel.text = "\(downline.name ?? "") (\(downline.downline.count))"
                
                view.stackView.addArrangedSubview(nestedView)
            }
            
            mainStackView.addArrangedSubview(view)
        }
    }
    
    func setupView() {
//        let expandableView: ExpandableListView = UIView.fromNib()
//        let expandableView2: ExpandableListView = UIView.fromNib()
//        let expandableView3: ExpandableListView = UIView.fromNib()
//
//        let nestedView: ExpandableListView = UIView.fromNib()
//
//        expandableView.stackView.addArrangedSubview(nestedView)
//
//        mainStackView.addArrangedSubview(expandableView)
//        mainStackView.addArrangedSubview(expandableView2)
//        mainStackView.addArrangedSubview(expandableView3)
//
//        expandableView.nameLabel.text = "Test 1"
//        expandableView2.nameLabel.text = "Test 2"
//        expandableView3.nameLabel.text = "Test 3"
//
//        nestedView.nameLabel.text = "Nested 1"
//        nestedView.adjustNestedConstraint(nestedLevel: 2)
//
//        expandableView.haveChildView = true
//        expandableView2.haveChildView = false
//        expandableView3.haveChildView = false
//        nestedView.haveChildView = false
    }
}
