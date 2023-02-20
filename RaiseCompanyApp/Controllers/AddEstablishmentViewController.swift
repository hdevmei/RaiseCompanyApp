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
    
    var canSave: Bool = true
    var postEstablishmentFunction: ((EstablishmentSQLView?) -> Void)?
    
    var selectedImage: UIImage?
    @IBOutlet weak var imgButton: UIButton!

    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var benefitsTextField: UITextField!
    
    @IBOutlet weak var lossesTextField: UITextField!
    
    @IBOutlet weak var scheduleTextfield: UITextField!
    
    @IBAction func saveBtn(_ sender: Any) {
        addEstablishment()
    }
    
    var image64 = ""
    @IBAction func ImageButton(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.mediaTypes = ["public.image"]
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // Almacenar la imagen seleccionada en una variable.
            self.selectedImage = selectedImage
            let imageData = selectedImage.jpegData(compressionQuality: 1.0)
            let base64String = imageData?.base64EncodedString(options: [])
            
//            imgButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal) , for: .normal)
//
//            imgButton.sizeToFit()
//            imgButton.contentMode = .scaleAspectFill
            image64 = base64String!

            // Establecer la imagen escalada en el botón
            imgButton.setBackgroundImage(selectedImage, for: .normal)        }
            
        guard selectedImage!.jpegData(compressionQuality: 1.0) != nil else {
            return
        }
        
        dismiss(animated: true, completion: nil)
        
        imgButton.setBackgroundImage(selectedImage, for: .normal)
    }
    
    
    
    func addEstablishment() {
        
        var establishmentToAdd = EstablishmentSQLView(benefits: 0, location: "", losses: 0, photo: nil, id_establishment: nil, schedule: scheduleTextfield.text, num_employees: 0, avg_rating: nil)
        
        
        if image64 == "" {
            establishmentToAdd.photo = nil
        } else {
            establishmentToAdd.photo = image64
        }
        
        
        // Agregar la imagen al objeto establishmentToAdd si se ha seleccionado
          
        //          establishmentToAdd.schedule = scheduleTextfield.text!
        establishmentToAdd.location = locationTextField.text!
        
        // Comprobar si los campos de texto de beneficios y pérdidas son números enteros
        if let benefitsText = benefitsTextField.text, let benefits = Int(benefitsText),
           let lossesText = lossesTextField.text, let losses = Int(lossesText) {
            establishmentToAdd.benefits = benefits
            establishmentToAdd.losses = losses
            canSave = true
        } else {
            canSave = false
        }
        
        if locationTextField.text!.isEmpty{
            canSave = false
        }
        
        // Si se pueden guardar los datos, llamar a la función postEstablishment para agregar el establecimiento al servidor
        if canSave {
            ApiManager.shared.postEstablishment(establishmentToAdd: establishmentToAdd)
            self.dismiss(animated: true)
        } else {
            let alert = UIAlertController(title: "Error", message: "Faltan campos o están incorrectos", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func cancelBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
}


