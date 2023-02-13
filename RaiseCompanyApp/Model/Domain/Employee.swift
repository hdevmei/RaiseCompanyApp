//
//  Employee.swift
//  RaiseCompanyApp
//
//  Created by mei_yocontrolo on 13/02/2023.
//

import UIKit

struct Employee : Encodable, Decodable{
    var employee_user_name: String?
    var password: String?
    var name: String?
    var age: Int?
    var mail: String?
    var salary: Int
    var schedule: String?
    var work_position: String?
    var id_establishment: Int?
    var rol: String?
    var lastnames: String?
    var photo: String?
    
    init(employee_user_name: String? = nil, password: String? = nil, name: String? = nil, age: Int? = nil, mail: String? = nil, salary: Int, schedule: String? = nil, work_position: String? = nil, id_establishment: Int? = nil, rol: String? = nil, lastnames: String? = nil, photo: String? = nil) {
        self.employee_user_name = employee_user_name
        self.password = password
        self.name = name
        self.age = age
        self.mail = mail
        self.salary = salary
        self.schedule = schedule
        self.work_position = work_position
        self.id_establishment = id_establishment
        self.rol = rol
        self.lastnames = lastnames
        self.photo = photo
    }
    
    
    
}
