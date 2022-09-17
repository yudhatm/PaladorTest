//
//  EmployeeWithTree.swift
//  PaladorTest
//
//  Created by Yudha on 16/09/22.
//

import Foundation

struct EmployeeWithTree: Codable {
    var employeeId: Int?
    var name: String?
    var managerId: Int?
    var downline: [EmployeeWithTree] = []
    
    init(employeeId: Int?, name: String?, managerId: Int?, downline: [EmployeeWithTree] = []) {
        self.employeeId = employeeId
        self.name = name
        self.managerId = managerId
        self.downline = downline
    }
}
