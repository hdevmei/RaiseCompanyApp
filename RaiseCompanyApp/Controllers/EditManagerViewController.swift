//
//  EditManagerViewController.swift
//  RaiseCompanyApp
//
//  Created by mei_yocontrolo on 09/03/2023.
//

import Foundation
import UIKit


class EditManagerViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    var currentManager: Manager?
    
    
    
    var ManagerNewValues : Manager = Manager(age: nil, lastnames: nil, mail: nil, manager_user_name: nil, name: nil, password: nil, photo: nil)
    
    
    @IBOutlet weak var imgManager: UIImageView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var lastNamesTF: UITextField!
    @IBOutlet var ageTF: UITextField!
    @IBOutlet weak var mailTF: UITextField!
    
    @IBAction func imgButton(_ sender: UIButton) {
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
            //Assign the base64string to the establishment New values
            self.ManagerNewValues.photo = imageBase64String
            //change default image to image selected
            imgManager.image = selectedImage
            //quit gallery picker automatically
            picker.dismiss(animated: true)
        }
    }
    
    //Quit gallery picker
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    
    @IBAction func saveBtn(_ sender: UIButton) {
        setNewValuesEstablishmentFromTextFields()
        print(ManagerNewValues)
        updateManager()
        self.dismiss(animated: true)
    }
    

    @IBAction func cancelBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCurrentManager()
    }
    
    func setCurrentManager(){
        //if the current manager has image
        if let strBase64 = self.currentManager!.photo, let imageData = Data(base64Encoded: strBase64, options: .ignoreUnknownCharacters), let image = UIImage(data: imageData) {
            imgManager.image = image
            //if not set deafult establishment image
        } else {
            imgManager.image = UIImage(systemName: "person.fill")
        }
        
        self.nameTF.text = self.currentManager?.name != nil ? "\(self.currentManager!.name!)" : ""
        self.lastNamesTF.text = self.currentManager?.lastnames != nil ? "\(self.currentManager!.lastnames!)" : ""
        
        self.ageTF.text = self.currentManager?.age != nil ? "\(self.currentManager!.age!) years" : ""
        
        self.mailTF.text = self.currentManager?.mail != nil ? "\(self.currentManager!.mail!)" : ""
    }
    
    
    //set the values of the new manager from textfields
    func setNewValuesEstablishmentFromTextFields(){
        if let nameText = nameTF.text, !nameText.isEmpty {
            self.ManagerNewValues.name = nameText
        }
        
        if let lastNamesText = lastNamesTF.text, !lastNamesText.isEmpty{
            self.ManagerNewValues.lastnames = lastNamesText
        }
        
        if let ageText = ageTF.text, let ageInt = Int(ageText), !ageText.isEmpty{
            self.ManagerNewValues.age = ageInt
        }
        
        if let mailText = mailTF.text, !mailText.isEmpty{
            self.ManagerNewValues.mail = mailText
        }
    }
    
    
    func updateManager(){
        ApiManager.shared.updateManager(newManagerValues: ManagerNewValues)
    }
    
}


