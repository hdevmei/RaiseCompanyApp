//
//  requests.swift
//  RaiseCompanyApp
//
//  Created by mei_yocontrolo on 14/02/2023.
//

import Foundation
import Alamofire

class ApiManager {
    static let shared = ApiManager()
    
    //   ESTABLISHMENT LIST
    
    func getEstablishments(completion: @escaping ([EstablishmentSQLView]?, Error?) -> Void) {
        let url = "http://127.0.0.1:5000/safari/establishments"
        AF.request(url).responseDecodable(of: [EstablishmentSQLView].self) { response in
            switch response.result {
            case .success(let establishments):
//                print(establishments)
                completion(establishments, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func postEstablishment(establishmentToAdd : EstablishmentSQLView?){
        let url = "http://127.0.0.1:5000/safari/establishments"
        AF.request(url, method: .post, parameters: establishmentToAdd, encoder: JSONParameterEncoder.default)
            .validate(statusCode: 200..<300)
            .response { response in
                switch response.result {
                case .success:
                    print("POST request establishment added")
                    NotificationCenter.default.post(name: Notification.Name("establishmentAdded"), object: nil)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    
//    Establishment detail

    
}
