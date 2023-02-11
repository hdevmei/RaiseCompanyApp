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
    let benefits: Int?
    let location: String
    let losses: Int?
    let photo: String?
    let id_establishment: Int?
    let schedule: String?
    let num_employees: Int
    let avg_rating: Float?
    
    
    
    init(benefits: Int?, location: String, losses: Int?, photo: String?, id_establishment: Int?, schedule: String?, num_employees: Int, avg_rating: Float?) {
        self.benefits = benefits
        self.location = location
        self.losses = losses
        self.photo = photo
        self.id_establishment = id_establishment
        self.schedule = schedule
        self.num_employees = num_employees
        self.avg_rating = avg_rating ?? -1
    }
}
