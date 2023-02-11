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
    
    var canSave: Bool = false
    var postEstablishmentFunction: ((EstablishmentSQLView?) -> Void)?
    
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var benefitsTextField: UITextField!
    
    @IBOutlet weak var lossesTextField: UITextField!
    
    
    @IBOutlet weak var scheduleTextfield: UITextField!
    
    @IBAction func saveBtn(_ sender: Any) {
        
        
        addEstablishment()
        self.dismiss(animated: true)

    }
    
    
    func addEstablishment() {
        // Crear una instancia de EstablishmentSQLView
        var establishmentToAdd = EstablishmentSQLView(benefits: 0, location: "", losses: 0, photo: nil, id_establishment: nil, schedule: "", num_employees: 0, avg_rating: nil)
        // Asignar valores a las propiedades de establishmentToAdd
 
        
        establishmentToAdd.location = locationTextField.text ?? ""
        establishmentToAdd.schedule = scheduleTextfield.text ?? ""
//
        // Llamar a la función postEstablishment para agregar el establecimiento al servidor
        postEstablishmentFunction!(establishmentToAdd)
        
    }
    
    
    
    @IBAction func cancelBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
