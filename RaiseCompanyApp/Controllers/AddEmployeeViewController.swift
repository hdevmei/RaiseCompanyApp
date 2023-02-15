//
//  AddEmployeeViewController.swift
//  RaiseCompanyApp
//
//  Created by mei_yocontrolo on 05/02/2023.
//

import UIKit
import Alamofire

class AddEmployeeViewController: UIViewController {

    var id_establishment_getted: Int?
    
    @IBAction func addEmployee(_ sender: Any) {
        print("Intentando aañadir un employee")
        addEmployeeForEstablishment()
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
 
    
    func addEmployeeForEstablishment(){
        var employeeToAdd = Employee(name: "ain disimular", age: nil, mail: "ctaguna", salary: 1200, schedule: "sdkjfklsndf", work_position: "sjdfnsdf", id_establishment: id_establishment_getted!, lastnames: "esto son los apellidos", photo: nil, id_employee: nil)
            
        
            let jsonEncoder = JSONEncoder()
            jsonEncoder.outputFormatting = .prettyPrinted

            do {
                let jsonData = try jsonEncoder.encode(employeeToAdd)
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print(jsonString)
                }
            } catch {
                print(error)
            }
        
        let url = "http://127.0.0.1:5000/safari/establishments/\(id_establishment_getted!)/employees"
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
