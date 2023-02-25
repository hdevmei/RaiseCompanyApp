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
    
    //Get ALL establishments
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
    
    
    //Get ONE establishment
    func getEstablishment(id_establishment: Int, completion: @escaping (EstablishmentSQLView?, Error?) -> Void) {
        let url = "http://127.0.0.1:5000/safari/establishments/\(id_establishment)"
        AF.request(url).responseDecodable(of: EstablishmentSQLView.self) { response in
            switch response.result {
            case .success(let establishment):
                completion(establishment, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    
    
    //add new establishment
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
    
    //delete establishment
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
    
    //update establishment
    func updateEstabloshment(newEstablishmentValues: Establishment, id_establishment: Int){
        let url = "http://127.0.0.1:5000/safari/establishments/\(id_establishment)"
        AF.request(url, method: .put, parameters: newEstablishmentValues, encoder: JSONParameterEncoder.default)
            .validate(statusCode: 200..<300)
            .response { response in
                switch response.result {
                case .success:
                    print("Establishment Updated")
                    NotificationCenter.default.post(name: Notification.Name("establishmentEdited"), object: nil)
                case .failure(let error):
                    print(error)
                    print(response)
                }
            }
    }
    
    
    
    
    
    
    //    EMPLOYEES ////////////////////////////////////////////////////////////////////////////////////
    
    func getEmployees(id_establishment: Int, completion: @escaping ([Employee]?, Error?) -> Void) {
        let url = "http://127.0.0.1:5000/safari/establishments/\(id_establishment)/employees"
        AF.request(url).responseDecodable(of: [Employee].self) { response in
            switch response.result {
            case .success(let employees):
                completion(employees, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    
    func getEmployee(id_employee: Int, completion: @escaping (Employee?, Error?) -> Void) {
        let url = "http://127.0.0.1:5000/safari/establishments/0/employees/\(id_employee)"
        AF.request(url, method: .get).responseDecodable(of: Employee.self) { response in
            switch response.result {
            case .success(let employee):
                completion(employee, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    
    

    func addEmployee(id_establishment: Int, employeeToAdd: Employee){
        let url = "http://127.0.0.1:5000/safari/establishments/\(id_establishment)/employees"
        AF.request(url, method: .post, parameters: employeeToAdd, encoder: JSONParameterEncoder.default)
            .validate(statusCode: 200..<300)
            .response { response in
                switch response.result {
                case .success:
                    print("Employee Added")
                    NotificationCenter.default.post(name: Notification.Name("employeeAddedToEstablishment"), object: nil)
                case .failure(let error):
                    print(error)
                    print(response)
                }
            }
    }
    
    
    
    
    
    
    
}
