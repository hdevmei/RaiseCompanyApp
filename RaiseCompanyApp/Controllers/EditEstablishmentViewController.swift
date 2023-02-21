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
    var establishmentHecho: EstablishmentSQLView?
    
    var establishmentNewValues: Establishment = Establishment(benefits: nil, id_establishment: nil, location: nil, losses: nil, photo: nil, schedule: nil)
    
    @IBOutlet weak var locationTF: UITextField!
    
    @IBOutlet weak var benefitsTF: UITextField!
    
    @IBOutlet weak var lossesTF: UITextField!
    
    @IBOutlet weak var scheduleTF: UITextField!
    
    
    @IBAction func imgBtn(_ sender: UIButton) {
        print(self.establishmentNewValues)
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
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
    
//Get current establishment data to put in placeholder
    func getEstablishment() {
        AF.request("http://127.0.0.1:5000/safari/establishments/\(id_establishment_getted!)")
            .responseDecodable(of: [Establishment].self) { response in
                switch response.result {
                case .success(let establishments):
                    if let firstEstablishment = establishments.first {
                        self.establishmentGetted = firstEstablishment
//         Put the current data to the placeholders...
                        DispatchQueue.main.async {
                            self.locationTF.placeholder = "  Location: \(self.establishmentGetted!.location!)"
                            self.benefitsTF.placeholder = "  Benefits: \(self.establishmentGetted!.benefits!)"
                            self.lossesTF.placeholder = "  Losses: \(self.establishmentGetted!.losses!)"
                            self.scheduleTF.placeholder = "  Schedule: \(self.establishmentGetted!.schedule! )"
                        }
                        self.establishmentNewValues = Establishment(benefits: self.establishmentGetted?.benefits, id_establishment: self.establishmentGetted?.id_establishment, location: self.establishmentGetted?.location, losses: self.establishmentGetted?.losses, photo: self.establishmentGetted?.photo, schedule: self.establishmentGetted?.schedule)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    
    func editEstablishment(){
//        Change values if user has put new value
        if let locationText = locationTF.text, !locationText.isEmpty {
            self.establishmentNewValues.location = locationText
        }
        if let benefitsText = benefitsTF.text, let benefits = Int(benefitsText) {
            self.establishmentNewValues.benefits = benefits
        }
        if let lossesText = lossesTF.text, let losses = Int(lossesText) {
            self.establishmentNewValues.losses = losses
        }
        if let scheduleText = scheduleTF.text, !scheduleText.isEmpty {
            self.establishmentNewValues.schedule = scheduleText
        }

        
//        Put method
        let url = "http://127.0.0.1:5000/safari/establishments/\(id_establishment_getted!)"
        AF.request(url, method: .put, parameters: establishmentNewValues, encoder: JSONParameterEncoder.default)
            .validate(statusCode: 200..<300)
            .response { response in
                switch response.result {
                case .success:
                    print("PUT request successful")
                    NotificationCenter.default.post(name: Notification.Name("establishmentEdited"), object: nil)
                case .failure(let error):
                    print(error)
                    print(response)
                }
            }
        NotificationCenter.default.post(name: Notification.Name("establishmentEdited"), object: nil)
    }
    
}




