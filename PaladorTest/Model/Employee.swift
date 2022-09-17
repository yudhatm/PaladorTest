//
//  Employee.swift
//  PaladorTest
//
//  Created by Yudha on 14/09/22.
//

import Foundation

struct Employee: Codable {
    var employeeId: Int?
    var name: String?
    var managerId: Int?
    
    init(employeeId: Int, name: String, managerId: Int) {
        self.employeeId = employeeId
        self.name = name
        self.managerId = managerId
    }
}
