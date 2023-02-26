//
//  Employee.swift
//  RaiseCompanyApp
//
//  Created by mei_yocontrolo on 13/02/2023.
//

import UIKit

struct Employee : Decodable, Encodable{
    var name: String?
    var age: Int?
    var mail: String?
    var salary: Int?
    var schedule: String?
    var work_position: String?
    var id_establishment: Int?
    var lastnames: String?
    var photo: String?
    var id_employee: Int?
    var number: Int?
    
    init(name: String?, age: Int?, mail: String?, salary: Int?, schedule: String?, work_position: String?, id_establishment: Int?, lastnames: String?, photo: String?, id_employee: Int?, number: Int?) {
        self.name = name
        self.age = age
        self.mail = mail
        self.salary = salary
        self.schedule = schedule
        self.work_position = work_position
        self.id_establishment = id_establishment
        self.lastnames = lastnames
        self.photo = photo
        self.id_employee = id_employee
        self.number = number
    }

    
}
