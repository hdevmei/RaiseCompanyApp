//
//  manager.swift
//  RaiseCompanyApp
//
//  Created by mei_yocontrolo on 09/03/2023.
//

import Foundation

struct Manager: Codable {
    var age: Int?
    var lastnames: String?
    var mail: String?
    var manager_user_name: String?
    var name: String?
    var password: String?
    var photo: String?
 
    init(age: Int?, lastnames: String?, mail: String?, manager_user_name: String?, name: String?, password: String?, photo: String?) {
        self.age = age
        self.lastnames = lastnames
        self.mail = mail
        self.mail = mail
        self.manager_user_name = manager_user_name
        self.name = name
        self.password = password
        self.photo = photo
        
    }
}
