//
//  EditEstablishment.swift
//  RaiseCompanyApp
//
//  Created by mei_yocontrolo on 18/02/2023.
//

import Foundation
import UIKit
import Alamofire




class EditEstablishmentViewController: UIViewController{
    
    
    var id_establishment_getted : Int?
    var establishmentGetted: Establishment?
    
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var benefitsTextField: UITextField!
    
    @IBOutlet weak var lossesTextField: UITextField!
    
    @IBOutlet weak var scheduleTextField: UITextField!
    
    
    
    @IBAction func imgBtn(_ sender: UIButton) {
        print(self.establishmentNewValues)
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        //        editEstablishment()
        print("Quiero editar establecimiento")
        print(establishmentHecho)
        editEstablishment()
        self.dismiss(animated: true)
    }
    
    
    @IBAction func cancelButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getEstablishment()
    }
    
    
    var establishmentHecho: EstablishmentSQLView?
    
    

    func getEstablishment() {
        AF.request("http://127.0.0.1:5000/safari/establishments/\(id_establishment_getted!)")
            .responseDecodable(of: [Establishment].self) { response in
                switch response.result {
                case .success(let establishments):
                    if let firstEstablishment = establishments.first {
                        self.establishmentGetted = firstEstablishment
                        print(self.establishmentGetted)
                        DispatchQueue.main.async {
                            self.locationTextField.placeholder = "  Location: \(self.establishmentGetted!.location!)"
                            self.benefitsTextField.placeholder = "  Benefits: \(self.establishmentGetted!.benefits!)"
                            self.lossesTextField.placeholder = "  Losses: \(self.establishmentGetted!.losses!)"
                            self.scheduleTextField.placeholder = "  Schedule: \(self.establishmentGetted!.schedule! )"
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    var establishmentNewValues = Establishment(benefits: 1, id_establishment: nil, location:  nil, losses: nil, photo: nil, schedule: nil)
    
    func editEstablishment(){
       
        
        self.establishmentNewValues.location = locationTextField.text!
        self.establishmentNewValues.benefits = Int(benefitsTextField.text!)
        self.establishmentNewValues.losses = Int(lossesTextField.text!)
        self.establishmentNewValues.schedule = scheduleTextField.text!
        
        
        
        let url = "http://127.0.0.1:5000/safari/establishments/\(id_establishment_getted!)"
        AF.request(url, method: .put, parameters: establishmentNewValues, encoder: JSONParameterEncoder.default)
            .validate(statusCode: 200..<300)
            .response { response in
                switch response.result {
                case .success:
                    print("PUT request successful")
                    NotificationCenter.default.post(name: Notification.Name("employeeAddedToEstablishment"), object: nil)
                    NotificationCenter.default.post(name: Notification.Name("establishmentEdited"), object: nil)
                case .failure(let error):
                    print(error)
                    print(response)
                }
            }
        
        NotificationCenter.default.post(name: Notification.Name("establishmentEdited"), object: nil)
        
    }
    
}



//            if let location = locationTextField.text, !location.isEmpty {
//                establishmentNewValues.location = location
//            } else {
//                establishmentNewValues.location = establishmentHecho!.location
//            }
//
//            if let schedule = scheduleTextField.text, !schedule.isEmpty {
//                establishmentNewValues.schedule = schedule
//            } else {
//                establishmentNewValues.schedule = establishmentHecho!.schedule
//            }
//
//            if let benefits = benefitsTextField.text, !benefits.isEmpty {
//                if let benefitsInt = Int(benefits) {
//                    establishmentNewValues.benefits = benefitsInt
//                }
//            } else {
//                establishmentNewValues.benefits = establishmentHecho!.benefits
//            }
//
//            if let losses = lossesTextField.text, !losses.isEmpty {
//                if let lossesInt = Int(losses) {
//                    establishmentNewValues.losses = lossesInt
//                }
//            } else {
//                establishmentNewValues.losses = establishmentHecho!.losses
//            }

//            establishmentNewValues.id_establishment = id_establishment_getted

