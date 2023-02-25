//
//  EditEstablishment.swift
//  RaiseCompanyApp
//
//  Created by mei_yocontrolo on 18/02/2023.
//

import Foundation
import UIKit
import Alamofire

class EditEstablishmentViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    //The id of the establishment, will always exists because is received from establishment detail view
    var id_establishment_getted : Int?
    var currentEstablihsment: EstablishmentSQLView?
    
    
    //instantiate a establishment without values, then it will be filled with the current establishment values
    var establishmentNewValues: Establishment = Establishment(benefits: nil, id_establishment: nil, location: nil, losses: nil, photo: nil, schedule: nil)
    

    @IBOutlet weak var imgEstablishment: UIImageView!
    @IBOutlet weak var locationTF: UITextField!
    @IBOutlet weak var benefitsTF: UITextField!
    @IBOutlet weak var lossesTF: UITextField!
    @IBOutlet weak var scheduleTf: UITextField!
    
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
            //Assign the base64string to the establishment New values
            self.establishmentNewValues.photo = imageBase64String
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
    
    
    
    @IBAction func saveButton(_ sender: UIButton) {
        //        editEstablishment()
        setNewValuesEstablishments()
        updateEstablishment()
        self.dismiss(animated: true)
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentEstablishmentAndSetInfo()
    }
    
    
    //Get current establishment data to put in placeholder
    func getCurrentEstablishmentAndSetInfo(){
        ApiManager.shared.getEstablishment (id_establishment: id_establishment_getted!){  establishment, error in
            if let establishment = establishment{
                //convert the establishment getted in the request to lozzºcal establishment
                self.currentEstablihsment = establishment
                //set visual info
                self.setInfoCurrentEstablishment()
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    //set the visual info of current establishment
    func setInfoCurrentEstablishment() {
        
        //if the current establishment has image
        if let strBase64 = self.currentEstablihsment!.photo, let imageData = Data(base64Encoded: strBase64, options: .ignoreUnknownCharacters), let image = UIImage(data: imageData) {
            imgEstablishment.image = image            //if not set deafult establishment image
        } else {
            imgEstablishment.image = UIImage(named: "defaultEstablishment")
        }
        
        self.locationTF.text = "\(self.currentEstablihsment!.location)"
        self.benefitsTF.text = " \(self.currentEstablihsment!.benefits!)"
        self.lossesTF.text = "\(self.currentEstablihsment!.losses!)"
        self.scheduleTf.text = "\(self.currentEstablihsment!.schedule! )"
    }
    
    
    
    func setNewValuesEstablishments(){
        //Change values if user has put new value
        
        
        
        if let locationText = locationTF.text, !locationText.isEmpty {
            self.establishmentNewValues.location = locationText
        }
        if let benefitsText = benefitsTF.text, let benefits = Int(benefitsText) {
            self.establishmentNewValues.benefits = benefits
        }
        if let lossesText = lossesTF.text, let losses = Int(lossesText) {
            self.establishmentNewValues.losses = losses
        }
        if let scheduleText = scheduleTf.text, !scheduleText.isEmpty {
            self.establishmentNewValues.schedule = scheduleText
        }
    }
    
    func updateEstablishment(){
        ApiManager.shared.updateEstabloshment(newEstablishmentValues: establishmentNewValues, id_establishment: id_establishment_getted!)
        
    }
}


