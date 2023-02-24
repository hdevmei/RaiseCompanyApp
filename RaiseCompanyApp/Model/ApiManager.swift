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
    
    //  ESTABLISHMENTS METHODS /////////////////////////////////////////////////////////////////
    
    
    func getEstablishments(completion: @escaping ([EstablishmentSQLView]?, Error?) -> Void) {
        let url = "http://127.0.0.1:5000/safari/establishments"
        AF.request(url).responseDecodable(of: [EstablishmentSQLView].self) { response in
            switch response.result {
            case .success(let establishments):
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
    
    
    func deleteEstablishment(indexEstablishmentToDelete: Int){
        //take the id of establishment to delete from the indexEstablioshmentToDelete
        let id_establishment_to_delete = EstablishmentListViewController.filteredEstablishments[indexEstablishmentToDelete].id_establishment!
        
        //Send the delete request
        let url = "http://127.0.0.1:5000/safari/establishments/\(id_establishment_to_delete)"
        AF.request(url, method: .delete).response { response in
            switch response.result {
            case .success:
                print("Establishment deleted")
            case .failure(let error):
                print("Failed to delete establishment: \(error)")
            }
        }
    }
    
    
    
    
//    EMPLOYEES ////////////////////////////////////////////////////////////////////////////////////
    func addEmployee(id_establishment: Int, employeeToAdd: Employee){
        let url = "http://127.0.0.1:5000/safari/establishments/\(id_establishment)/employees"
        AF.request(url, method: .post, parameters: employeeToAdd, encoder: JSONParameterEncoder.default)
            .validate(statusCode: 200..<300)
            .response { response in
                switch response.result {
                case .success:
                    print("POST request successful")
                    NotificationCenter.default.post(name: Notification.Name("employeeAddedToEstablishment"), object: nil)
                case .failure(let error):
                    print(error)
                    print(response)
                }
            }
    }
    
    

    
}
