//
//  AddEstablishmentViewController.swift
//  RaiseCompanyApp
//
//  Created by mei_yocontrolo on 25/01/2023.
//

import Foundation
import UIKit
import Alamofire
import SwiftUI


class AddEstablishmentViewController : UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var newEstablishment: EstablishmentSQLView = EstablishmentSQLView(benefits: 3000, location: "que pasa tete", losses: 23423, photo: nil, id_establishment: nil, schedule: "este es el horario", num_employees: 0, avg_rating: nil)
    
    @IBAction func cancelBtn(_ sender: UIButton) {
        //DE MOMENTO VA A SER UN BOTÓN DE PRUEBA
        print(newEstablishment.photo)
    }
    
    
    var canSave: Bool = true
    var postEstablishmentFunction: ((EstablishmentSQLView?) -> Void)?
    
    var selectedImage: UIImage?
    @IBOutlet weak var imgButton: UIButton!
    
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var benefitsTextField: UITextField!
    
    @IBOutlet weak var lossesTextField: UITextField!
    
    @IBOutlet weak var scheduleTextfield: UITextField!
    
    @IBAction func saveBtn(_ sender: Any) {
        
        self.newEstablishment.location = locationTextField.text!
        
        ApiManager.shared.postEstablishment(establishmentToAdd: newEstablishment)
        
        self.dismiss(animated: true)
    }
    
    
    var stringBase64: String?
    
    
    @IBAction func imgBtn(_ sender: UIButton) {
//        show galery picker
        let imagePicker = UIImagePickerController()
               imagePicker.sourceType = .photoLibrary
               imagePicker.delegate = self
               imagePicker.allowsEditing = false
               imagePicker.mediaTypes = ["public.image"]
               present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
//        si hay una imagen seleccionada
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.selectedImage = selectedImage
            let imageData = selectedImage.jpegData(compressionQuality: 1.0)
            
            let imageBase64String = imageData?.base64EncodedString()

            
            
//            self.newEstablishment.photo = imageBase64String
            self.newEstablishment.photo = imageData
            
            imgButton.setBackgroundImage(selectedImage, for: .normal)
            
            picker.dismiss(animated: true)
        }
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    
    
    
    
    
    
}

