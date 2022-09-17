//
//  MainViewModel.swift
//  PaladorTest
//
//  Created by Yudha on 14/09/22.
//

import Foundation
import SwiftyJSON
import RxSwift
import RxCocoa

protocol MainViewModelType {
    var employeeListObs: Observable<[Employee]> { get set }
    var employeeGroupObs: Observable<[EmployeeWithTree]> { get set }
    
    func getDataFromFile()
    func doGroupEmployeeData()
}

class MainViewModel: MainViewModelType {
    lazy var employeeListObs: Observable<[Employee]> = employeeListSubject.asObservable()
    lazy var employeeGroupObs: Observable<[EmployeeWithTree]> = employeeGroupSubject.asObservable()
    
    var employeeListSubject = PublishSubject<[Employee]>()
    var employeeGroupSubject = PublishSubject<[EmployeeWithTree]>()
    
    var employeeList: [Employee] = []
    var employeeGroup: [EmployeeWithTree] = []
    
    init() {
        if UserDefaultManager.shared.loadObject(key: "employeeData") == nil {
            print("get employee data from file")
            getDataFromFile()
        } else {
            print("get employee data from user defaults")
            guard let employeeData = UserDefaultManager.shared.loadDataObject(key: "employeeData") else { return }
            
            do {
                employeeList = try JSONDecoder().decode([Employee].self, from: employeeData)
                self.employeeListSubject.onNext(employeeList)
                
                for employee in employeeList {
                    employeeGroup.append(EmployeeWithTree(employeeId: employee.employeeId, name: employee.name, managerId: employee.managerId))
                }
            } catch {
                print(error)
            }
        }
    }
    
    func getDataFromFile() {
        guard let jsonData = Helper.shared.readLocalFile(forName: "organization-tree") else { return }
        
        guard let data = Helper.shared.parse(model: [Employee].self, jsonData: jsonData) else { return }
        
        employeeList = data
        employeeListSubject.onNext(data)
        
        for employee in employeeList {
            employeeGroup.append(EmployeeWithTree(employeeId: employee.employeeId, name: employee.name, managerId: employee.managerId))
        }
        
        if let encodedData = try? JSONEncoder().encode(data) {
            UserDefaultManager.shared.saveObject(encodedData, key: "employeeData")
        }
    }
    
    func doGroupEmployeeData() {
        for i in 0..<employeeList.count {
            for item in employeeGroup {
                if let managerId = item.managerId, let employeeId = employeeGroup[i].employeeId, managerId == employeeId {
                    employeeGroup[i].downline.append(item)
                }
            }
        }
        
        employeeGroupSubject.onNext(filteredGroup)
    }
}
