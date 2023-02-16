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



struct EstablishmentSQLView: Encodable, Decodable {
    var benefits: Int?
    var location: String
    var losses: Int?
    var photo: String?
    var id_establishment: Int?
    var schedule: String?
    var num_employees: Int
    var avg_rating: Float?
    
    var rating: Float! {
        if let avgRating = avg_rating {
            return avgRating
        } else {
            return -1
        }
    }
    
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

