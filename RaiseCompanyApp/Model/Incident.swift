//
//  Incident.swift
//  RaiseCompanyApp
//
//  Created by mei_yocontrolo on 27/02/2023.
//

import Foundation


struct Incident: Codable{
    var id_incident: Int?
    var gravity: String?
    var description: String?
    var state: String?
    var date: String?
    var id_user_employee: Int?
    var tittle: String?
    var photo: String?
    var id_establishment: Int?
    
    
    init(id_incident: Int?, gravity: String?, description: String?, state: String?, date: String?, id_user_employee: Int?, tittle: String?, photo: String?, id_establishment: Int?) {
        self.id_incident = id_incident
        self.gravity = gravity
        self.description = description
        self.state = state
        self.date = date
        self.id_user_employee = id_user_employee
        self.tittle = tittle
        self.photo = photo
        self.id_establishment = id_establishment
    }
}
