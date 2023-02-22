//
//  AddEmployeeViewController.swift
//  RaiseCompanyApp
//
//  Created by mei_yocontrolo on 05/02/2023.
//

import UIKit
import Alamofire

class AddEmployeeViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    
    var employeeToAdd = Employee(name: "como duele", age: 0, mail: "" , salary: 0, schedule: "", work_position: "", id_establishment: nil, lastnames: "", photo: nil, id_employee: nil)
    
    
    
    
    //    cancel add employee view
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    var id_establishment_getted: Int?
    var canSave: Bool = true
    
    @IBOutlet weak var nameEmployeeTF: UITextField!
    
    @IBOutlet weak var lastNamesTF: UITextField!
    
    @IBOutlet weak var ageTF: UITextField!
    
    @IBOutlet weak var mailTF: UITextField!
    
    @IBOutlet weak var workPositionTF: UITextField!
    
    @IBOutlet weak var salaryTF: UITextField!
    
    @IBOutlet weak var scheduleTF: UITextField!
    
    @IBOutlet weak var imgBtn: UIButton!
    
    @IBOutlet weak var imgEmployee: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        employeeToAdd.id_establishment = id_establishment_getted
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func addEmployee(_ sender: Any) {
        if let name = nameEmployeeTF.text, !name.isEmpty,
           let lastnames = lastNamesTF.text, !lastnames.isEmpty,
           let mail = mailTF.text, !mail.isEmpty,
           let ageString = ageTF.text, let age = Int(ageString),
           let salaryString = salaryTF.text, let salary = Int(salaryString),
           let workPosition = workPositionTF.text, !workPosition.isEmpty{
            
        
            employeeToAdd.name = nameEmployeeTF.text
            employeeToAdd.lastnames = lastNamesTF.text
            employeeToAdd.mail = mailTF.text
            employeeToAdd.age = age
            employeeToAdd.salary = salary
            employeeToAdd.work_position = workPosition
            
            canSave = true
        }else {
            canSave = false
        }
            
        
        if canSave == true {
            ApiManager.shared.addEmployee(id_establishment: id_establishment_getted!, employeeToAdd: employeeToAdd)
            self.dismiss(animated: true)
        }else{
            let alert = UIAlertController(title: "Error", message: "Fields are missing or incorrect", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func selectImage(_ sender: UIButton) {
        //        show galery picker
        let imagePickerr = UIImagePickerController()
        imagePickerr.sourceType = .photoLibrary
        imagePickerr.delegate = self
        imagePickerr.allowsEditing = false
        imagePickerr.mediaTypes = ["public.image"]
        present(imagePickerr, animated: true, completion: nil)
    }
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //   If there is an image selected...
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let imageData = selectedImage.jpegData(compressionQuality: 1.0)
            let imageBase64String = imageData?.base64EncodedString()
            //            Assign the base64string to the new employee
            
            //            change camera image to image selected
            imgEmployee.image = selectedImage
            imgBtn.setBackgroundImage(selectedImage, for: .normal)
            picker.dismiss(animated: true)
        }
    }
    
    
    //    Quit gallery picker
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    
}
