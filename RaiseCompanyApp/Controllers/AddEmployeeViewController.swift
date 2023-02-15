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
        var employeeToAdd = Employee(name: nameEmployeeTF.text, age: 7, mail: nil, salary: nil, schedule: nil, work_position: nil, id_establishment: id_establishment_getted!, lastnames:  nil, photo: nil, id_employee: nil)
            
        
        
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
