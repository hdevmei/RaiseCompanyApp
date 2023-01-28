//
//  AddEstablishmentViewController.swift
//  RaiseCompanyApp
//
//  Created by mei_yocontrolo on 25/01/2023.
//

import Foundation
import UIKit
import Alamofire


class AddEstablishmentViewController: UIViewController{
    
    let url = URL(string: "http://127.0.0.1:5000/company/addEstablishment")!

    var canSaveEstablishment: Bool = false
    
    @IBOutlet weak var toastMessage: UILabel!
    
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var benefitsTextField: UITextField!
    
    @IBOutlet weak var lossesTextField: UITextField!
    
    @IBOutlet weak var scheduleTextField: UITextField!
    
    let params: Parameters = [
        "benefits": 2000,
        "losses": 1500,
        "schedule": "11:00 - 19:00",
        "location": "FANTASAMA",
    ]
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addEstablishmentBtn(_ sender: UIButton) {
        print("apretado")
        checkTextfields()
        if canSaveEstablishment == true{
//          do post 
            DataManager.postMethod(url: url, params: params)
            self.dismiss(animated: true, completion: nil)
        } else if canSaveEstablishment == false{
            print("faltan campos")
//            showToast()
        }
        
      

    }
    
    
    
    
    func checkTextfields(){
        if locationTextField.text == ""{
            canSaveEstablishment = false
        }else if locationTextField.text != ""{
            canSaveEstablishment = true
        }
    }
    
    /*
    func showToast(){
        toastMessage.text = "Need to complete location and schedule"
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            self.toastMessage.alpha = 0.0
        }, completion: {(isCompleted) in
            self.toastMessage.removeFromSuperview()
        })
    }
    */
    
}
