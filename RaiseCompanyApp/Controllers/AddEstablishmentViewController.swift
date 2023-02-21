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
    
    var newEstablishment: EstablishmentSQLView = EstablishmentSQLView(benefits: 3000, location: "", losses: 0, photo: nil, id_establishment: nil, schedule: nil , num_employees: 0, avg_rating: nil)
    
    
//    Cancel add establihment view
    @IBAction func cancelBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
    var canSave: Bool = false
    var postEstablishmentFunction: ((EstablishmentSQLView?) -> Void)?
    
    var selectedImage: UIImage?
    
    @IBOutlet weak var imgButton: UIButton!
    
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var benefitsTextField: UITextField!
    
    @IBOutlet weak var lossesTextField: UITextField!
    
    @IBOutlet weak var scheduleTextfield: UITextField!
    
    @IBAction func saveBtn(_ sender: Any) {
        
        
//    Check compulsory values and Int benefits and losses
        if let location = locationTextField.text, !location.isEmpty,
           let benefits = benefitsTextField.text, let benefitsValue = Int(benefits),
           let losses = lossesTextField.text, let lossesValue = Int(losses) {
        
            newEstablishment.location = locationTextField.text!
            newEstablishment.benefits = benefitsValue
            newEstablishment.losses = lossesValue
            
            
//   If user complete...
            if let schedule = scheduleTextfield.text{
                newEstablishment.schedule = schedule
            }
            
            canSave = true
        } else {
            canSave = false
        }
        
//    If can save...
        if canSave == true{
            ApiManager.shared.postEstablishment(establishmentToAdd: newEstablishment)
            self.dismiss(animated: true)
//    If not can sae...
        }else{
//    Show alert missing fields.
            let alert = UIAlertController(title: "Error", message: "fields are missing or incorrect", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
//    Close alert after 3 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    alert.dismiss(animated: true, completion: nil)
                }
        }
        
    }
    
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
        //   If there is an image selected...
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let imageData = selectedImage.jpegData(compressionQuality: 1.0)
            let imageBase64String = imageData?.base64EncodedString()
                 
            self.newEstablishment.photo = imageData
            
            imgButton.setBackgroundImage(selectedImage, for: .normal)
            
            picker.dismiss(animated: true)
        }
    }
    
//    Quit gallery picker
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    
}

