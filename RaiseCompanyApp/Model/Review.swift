//
//  Review.swift
//  RaiseCompanyApp
//
//  Created by mei_yocontrolo on 02/02/2023.
//

import Foundation
import UIKit


class Review : Codable {
    let id_review: Int
    let tittle: String
    let raintg: Float
    let date: String
    let description: String
    let id_establishment: Int
    let id_client: Int
}
