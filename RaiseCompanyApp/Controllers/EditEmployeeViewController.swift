//
//  EditEmployeeViewController.swift
//  RaiseCompanyApp
//
//  Created by mei_yocontrolo on 25/02/2023.
//

import Foundation
import UIKit

class EditEmployeeViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    //The id of the employee to edit will always exists because is received from employees list view
    var id_employee_to_update: Int?
    var currentEmployee: Employee?
    var id_establishment_of_employee: Int?
    
        //Instantiate a employee without values, the it will be filled with the current establishment values
    var employeeNewValues: Employee = Employee(name: nil, age: nil, mail: nil, salary: nil, schedule: nil, work_position: nil, id_establishment: nil, lastnames: nil, photo: nil, id_employee: nil, number: nil)
    
    
    @IBOutlet weak var imgeEmployee: UIImageView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var lastNamesTF: UITextField!
    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var numberTF: UITextField!
    @IBOutlet weak var workPositionTF: UITextField!
    @IBOutlet weak var scheduleTF: UITextField!
    
    
    @IBAction func imgBtn(_ sender: UIButton) {
        //show galery picker
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.mediaTypes = ["public.image"]
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //   If there is an image selected...
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let imageData = selectedImage.jpegData(compressionQuality: 1.0)
            let imageBase64String = imageData?.base64EncodedString()
            //Assign the base64string to the employee New values
            self.employeeNewValues.photo = imageBase64String
            //change default image to image selected
            imgeEmployee.image = selectedImage
            //quit gallery picker automatically
            picker.dismiss(animated: true)
        }
    }
    
    //Quit gallery picker
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    
    @IBAction func saveBtn(_ sender: UIButton) {
        setNewValuesEmployeeFromTextFields()
        updateEmployee()
        self.dismiss(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentEmplyeeAndSetInfo()
    }
    
    
    //Get current employee data to put in placeholder
    func getCurrentEmplyeeAndSetInfo(){
        ApiManager.shared.getEmployee (id_employee: id_employee_to_update ?? 0, id_establishment: id_establishment_of_employee!){  employee, error in
            if let employee = employee{
                //convert the establishment getted in the request to lozzºcal establishment
                self.currentEmployee = employee
                //set visual info
                self.setInfoCurrrentEmployee()
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    //set the info of the current employee to the textfields
    func setInfoCurrrentEmployee(){
        if let strBase64 = self.currentEmployee!.photo, let imageData = Data(base64Encoded: strBase64, options: .ignoreUnknownCharacters), let image = UIImage(data: imageData) {
            imgeEmployee.image = image            //if not set deafult establishment image
        } else {
            imgeEmployee.image = UIImage(systemName: "person.fill")
        }
        //use ternary operator to check if fields exists, if not, put them empty
        nameTF.text = self.currentEmployee!.name != nil ? self.currentEmployee!.name : ""
        lastNamesTF.text = self.currentEmployee!.lastnames != nil ? self.currentEmployee!.lastnames : ""
        ageTF.text = self.currentEmployee!.age != nil ? "\(self.currentEmployee!.age!)" : ""
        emailTF.text = self.currentEmployee!.mail != nil ? self.currentEmployee!.mail : ""
        numberTF.text = self.currentEmployee!.number != nil ? "\(self.currentEmployee!.number!)" : ""
        workPositionTF.text = self.currentEmployee!.work_position != nil ? self.currentEmployee!.work_position : ""
        scheduleTF.text = self.currentEmployee!.schedule != nil ? self.currentEmployee!.schedule : ""
    }
    
    
    func setNewValuesEmployeeFromTextFields(){
        if let nameText = nameTF.text, !nameText.isEmpty{
             self.employeeNewValues.name = nameText
         }

        if let lastnamesText = lastNamesTF.text, !lastnamesText.isEmpty{
             self.employeeNewValues.lastnames = lastnamesText
         }

         if let ageText = ageTF.text, !ageText.isEmpty{
             self.employeeNewValues.age = Int(ageText)
         }

         if let emailText = emailTF.text, !emailText.isEmpty{
             self.employeeNewValues.mail = emailText
         }

         if let numberText = numberTF.text, !numberText.isEmpty{
             self.employeeNewValues.number = Int(numberText)
         }

         if let positionText = workPositionTF.text, !positionText.isEmpty{
             self.employeeNewValues.work_position = positionText
         }

         if let scheduleText = scheduleTF.text, !scheduleText.isEmpty{
             self.employeeNewValues.schedule = scheduleText
         }
    }
    
    func updateEmployee(){
        ApiManager.shared.updateEmployee(newEmployeeValues: employeeNewValues, id_employee: id_employee_to_update!, id_establishment: id_establishment_of_employee!)
        NotificationCenter.default.post(name: Notification.Name("employeeUpdated"), object: nil)

    }
    

}
