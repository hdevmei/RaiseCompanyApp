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
    
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var benefitsTextField: UITextField!
    
    @IBOutlet weak var lossesTextField: UITextField!
    
    
    var establishmentToAdd : Establishment = Establishment(benefits: 234234, id_establishment: 2342, location: "a bue o", losses: 2342, photo: nil, schedule: "estfe ees el horario")
    
    @IBAction func saveBtn(_ sender: Any) {
      
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        
    }
    
    var listEstablishment: EstablishmentListViewController = EstablishmentListViewController()
    
    
    @IBAction func cancelBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
    func postEstablishment(){
        
         let url = "http://127.0.0.1:5000/safari/establishments"
         
         AF.request(url, method: .post, parameters: establishmentToAdd, encoder: JSONParameterEncoder.default)
             .validate(statusCode: 200..<300)
             .response { response in
                 switch response.result {
                 case .success:
                     print("POST request successful")
                 case .failure(let error):
                     print(error)
                 }
             }
        
     }
}
