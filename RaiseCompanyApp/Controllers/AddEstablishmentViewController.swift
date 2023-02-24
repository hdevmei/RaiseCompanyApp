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
    
    //    instantiate new establishment with default values
    var newEstablishment: EstablishmentSQLView = EstablishmentSQLView(benefits: 0, location: "", losses: 0, photo: nil, id_establishment: nil, schedule: nil , num_employees: 0, avg_rating: nil)
    
    //cancel add establishment view
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
    
    @IBOutlet weak var imgEstablishment: UIImageView!
    
    
    @IBAction func saveBtn(_ sender: Any) {
        
        //check if the user has written the compulsory values and if benefits and losses are tyoe Int
        if let location = locationTextField.text, !location.isEmpty,
           let benefits = benefitsTextField.text, let benefitsValue = Int(benefits),
           let losses = lossesTextField.text, let lossesValue = Int(losses) {
            
            //... If yes assign the values to the establisment to add
            newEstablishment.location = locationTextField.text!
            newEstablishment.benefits = benefitsValue
            newEstablishment.losses = lossesValue
            
            //If user has completed the not compulsory fields as schedule
            if let schedule = scheduleTextfield.text{
                //set the schedule value to the new establishment
                newEstablishment.schedule = schedule
            }
            
            //allow save
            canSave = true
        } else {
            //don't allow save
            canSave = false
        }
        
        //If can save...
        if canSave == true{
            // call post establishment method
            ApiManager.shared.postEstablishment(establishmentToAdd: newEstablishment)
            //quit view controller
            self.dismiss(animated: true)
        //If can't save...
        }else{
            //If not can save show alert "Fields are missing or incorrect"
            let alert = UIAlertController(title: "Error", message: "Fields are missing or incorrect", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    
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
            //Assign the base64string to the new establishment photo
            self.newEstablishment.photo = imageBase64String
            //change default image to image selected
            imgEstablishment.image = selectedImage
            //quit gallery picker automatically
            picker.dismiss(animated: true)
        }
    }
    
    //Quit gallery picker
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    
}

