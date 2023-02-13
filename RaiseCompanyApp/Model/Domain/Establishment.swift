//
//  Establishment.swift
//  RaiseCompanyApp
//
//  Created by mei_yocontrolo on 01/02/2023.
//

import Foundation



struct Establishment: Codable {
    let benefits: Int?
    let id_establishment: Int?
    let location: String?
    let losses: Int?
    let photo: String?
    let schedule: String?
    
    
    init(benefits: Int?, id_establishment: Int?, location: String?, losses: Int?, photo: String?, schedule: String?) {
        self.benefits = benefits
        self.id_establishment = id_establishment
        self.location = location
        self.losses = losses
        self.photo = photo
        self.schedule = schedule
    }
}



struct EstablishmentSQLView: Codable{
    var benefits: Int?
    var location: String
    var losses: Int?
    var photo: String?
    var id_establishment: Int?
    var schedule: String?
    var num_employees: Int
    var avg_rating: Float?
    
    
    
    init(benefits: Int?, location: String, losses: Int?, photo: String?, id_establishment: Int?, schedule: String?, num_employees: Int, avg_rating: Float?) {
        self.benefits = benefits
        self.location = location
        self.losses = losses
        self.photo = photo
        self.id_establishment = id_establishment
        self.schedule = schedule
        self.num_employees = num_employees
        self.avg_rating = avg_rating
    }
    
    
}



struct Employee : Decodable{
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
