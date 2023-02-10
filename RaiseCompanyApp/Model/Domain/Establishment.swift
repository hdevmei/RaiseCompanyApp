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
}
