//
//  AddEstablishmentViewController.swift
//  RaiseCompanyApp
//
//  Created by mei_yocontrolo on 25/01/2023.
//

import Foundation
import UIKit
import Alamofire


class AddEstablishmentViewController : UIViewController {
    
    var canSave: Bool = true
    var postEstablishmentFunction: ((EstablishmentSQLView?) -> Void)?
    
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var benefitsTextField: UITextField!
    
    @IBOutlet weak var lossesTextField: UITextField!
    
    @IBOutlet weak var scheduleTextfield: UITextField!
    
    @IBAction func saveBtn(_ sender: Any) {
        addEstablishment()
    }
    
    
    func addEstablishment() {
        var establishmentToAdd = EstablishmentSQLView(benefits: 0, location: "", losses: 0, photo: nil, id_establishment: nil, schedule: nil, num_employees: 0, avg_rating: nil)
        
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
