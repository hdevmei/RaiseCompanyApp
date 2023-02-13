//
//  AddEmployeeViewController.swift
//  RaiseCompanyApp
//
//  Created by mei_yocontrolo on 05/02/2023.
//

import UIKit
import Alamofire

class AddEmployeeViewController: UIViewController {

    var id_getted: Int?
    
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
        var employeeToAdd = Employee(employee_user_name: "Prueba", password: "1234", name: "Juan Carlos" , age: 20, mail: "juanki@gmail.com", salary: 1300, schedule: "Este es el horario de juanqui", work_position: "Profe de lengua", id_establishment: id_getted!, rol: "employee", lastnames: "gomez", photo: nil)
            
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
        
        
        let url = "http://127.0.0.1:5000/safari/establishments/\(id_getted!)/employees"
        AF.request(url, method: .post, parameters: employeeToAdd, encoder: JSONParameterEncoder.default)
            .validate(statusCode: 200..<300)
            .response { response in
                switch response.result {
                case .success:
                    print("POST request successful")
                case .failure(let error):
                    print(error)
                }
            }

    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
