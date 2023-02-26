//
//  EmployeeDetailVC.swift
//  RaiseCompanyApp
//
//  Created by mei_yocontrolo on 21/02/2023.
//

import Foundation
import UIKit
import Alamofire

class EmployeeDetailViewController: UIViewController{
    
    //The id of the employee, will always exists because is received from employees list view controller
    var id_employee_getted: Int?
    var employee: Employee?
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var workPosition: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var mail: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var schedule: UILabel!
    
    
    @IBAction func editBtn(_ sender: UIButton) {
        print(id_employee_getted!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getEmployeeAndSetInfo()
        
        NotificationCenter.default.addObserver(self, selector: #selector(getEmployeeAndSetInfo), name: Notification.Name("employeeUpdated"), object: nil)
    }
    
    
    @objc func getEmployeeAndSetInfo(){
        //get employee
        ApiManager.shared.getEmployee(id_employee: id_employee_getted!) { employee, error in
            if let employee = employee{
                //convert the employees getted in the request to local employees
                self.employee = employee
                self.setEmployeeVisual()
                //set visual changes
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        
    }
        
        
        func setEmployeeVisual(){
            if let strBase64 = employee!.photo, let imageData = Data(base64Encoded: strBase64, options: .ignoreUnknownCharacters), let imageEmployee = UIImage(data: imageData) {
                image.image = imageEmployee
                //If image doesn't exists
            } else {
                // Set a default image with a brown background
//                image.image = UIImage(systemName: "person.fill")
            }
            
            
            if let nameValue = employee!.name{
                name.text = nameValue
            }
            if let workPositionValue = employee!.work_position{
                workPosition.text = workPositionValue
            }
            if let ageValue = employee?.age {
                age.text = String(ageValue)
            }
            if let mailvalue = employee!.mail{
                mail.text = mailvalue
            }
            if let numberValue = employee?.number{
                number.text = String(numberValue)
            }
            if let scheduleValue = employee?.schedule{
                schedule.text = scheduleValue
            }
        }
        
        
    //Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if segue.identifier == "GoToEditEmployee"{
            let editEmployeeVC = segue.destination as! EditEmployeeViewController
            editEmployeeVC.id_employee_to_update = id_employee_getted
        }
    }
        
    
    
    
}
