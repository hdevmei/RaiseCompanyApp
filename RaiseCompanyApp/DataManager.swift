//
//  DataManager.swift
//  RaiseCompanyApp
//
//  Created by mei_yocontrolo on 16/01/2023.
//

import Foundation


class DataManager {
    static var establishments: [Establishment] =
    [Establishment(location: "Av. Premios Nobel, 3, 28850 Torrejón de Ardoz, Madrid", image: "oasiz", rating: 1.5, benefits: 232452, losses: 25456 , nEmployees: 6), Establishment (location: "P.º Imperial, 4, 28005 Madrid", image: "paseoImperial", rating: 2, benefits: 634563, losses: 234 , nEmployees: 7) , Establishment (location: "Paseo Extremadura 32, 28011 Madrid", image: "paseoExtremadura", rating: 4, benefits: 34525, losses: 12343 , nEmployees: 14), Establishment(location: "Gaztambide 65, Madrid, 28064", image: "gaztambide", rating: 3.5, benefits: 56423, losses: 456745, nEmployees: 6)
    ]
    
    
    static var selectedEstablishment: Int?
    
    
    static var filteredEstablishments: [Establishment]!

}
