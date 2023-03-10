//
//  MyProfileViewController.swift
//  RaiseCompanyApp
//
//  Created by mei_yocontrolo on 22/02/2023.
//

import Foundation
import UIKit

class MyProfileViewController: UIViewController{
    
    @IBOutlet weak var managerImage: UIImageView!
    @IBOutlet weak var nameAndLastnames: UILabel!
    @IBOutlet weak var age: UILabel!
    
    @IBOutlet weak var mail: UILabel!
    
    var manager : Manager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getManagerAndCallSetInfo()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadDataManager), name: Notification.Name("ManagerUpdated"), object: nil)
    }
    
    
    @objc func reloadDataManager(){
        getManagerAndCallSetInfo()
    }
    
    
    
    func getManagerAndCallSetInfo(){
        ApiManager.shared.getManager{ manager, error in
            if let manager = manager {
                self.manager = manager
                self.setInfoManager()
            }
            else if let error = error {
                print(error.localizedDescription)
            }
        }
    }

    func setInfoManager(){
        if let strBase64 = self.manager?.photo, let imageData = Data(base64Encoded: strBase64, options: .ignoreUnknownCharacters), let image = UIImage(data: imageData) {
            managerImage.image = image
            //If image doesn't exists
        } else {
            managerImage.image = UIImage(systemName: "person.fill")
        }
        self.age.text = "\(self.manager?.age != nil ? "\(self.manager!.age!) years" : "")"
        self.mail.text = "\(self.manager?.mail != nil ? "\(self.manager!.mail!)" : "")"
        
        //Use ternary operator to set values
        //...name
        let nameValue = manager!.name != nil ? manager?.name! : "No name"
        //...lastnames
        let lastnameValue = manager!.lastnames != nil ? manager?.lastnames! : "No lastnames"
        
        //Join name and lastnames
        let nameAndLastNames = nameValue! + " " + lastnameValue!
        self.nameAndLastnames.text = nameAndLastNames
    }

    
    
    //Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToEditManager" {
            let editManagerVC = segue.destination as! EditManagerViewController
            editManagerVC.currentManager = self.manager
        }
    }
    
}











