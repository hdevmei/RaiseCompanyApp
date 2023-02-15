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
    var canSave: Bool = true
    
    
    @IBOutlet weak var nameEmployeeTF: UITextField!
    
    @IBOutlet weak var lastNamesTF: UITextField!
    
    @IBOutlet weak var ageTF: UITextField!
    
    @IBOutlet weak var mailTF: UITextField!
    
    @IBOutlet weak var workPositionTF: UITextField!
    
    @IBOutlet weak var salaryTF: UITextField!
    
    @IBOutlet weak var scheduleTF: UITextField!
    
    
    
    @IBAction func addEmployee(_ sender: Any) {
        if canSave == true {
            addEmployeeForEstablishment()
            self.dismiss(animated: true)
        }else{
            let alert = UIAlertController(title: "Error", message: "Faltan campos o están incorrectos", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
      
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
 
    
    func addEmployeeForEstablishment(){
        guard let name = nameEmployeeTF.text, !name.isEmpty,
               let lastNames = lastNamesTF.text, !lastNames.isEmpty,
               let workPosition = workPositionTF.text, !workPosition.isEmpty
         else {
             let alert = UIAlertController(title: "Error", message: "The fields of name, surname and job position are required", preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
             present(alert, animated: true, completion: nil)
             return
         }
         
         // Comprobamos que los campos de edad y salario puedan ser convertidos a Int
         if let age = Int(ageTF.text ?? ""), let salary = Int(salaryTF.text ?? "") {
             // Creamos un objeto Employee con los datos ingresados por el usuario
             let employeeToAdd = Employee(name: name, age: age, mail: mailTF.text, salary: salary, schedule: scheduleTF.text, work_position: workPosition, id_establishment: id_establishment_getted!, lastnames: lastNames, photo: nil, id_employee: nil)

             // Convertimos el objeto Employee a JSON y lo imprimimos por consola
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
            
        } else {
            let alert = UIAlertController(title: "Error", message: "Age and salary must be numbers", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }

        
        
      
    }
    
    

}
