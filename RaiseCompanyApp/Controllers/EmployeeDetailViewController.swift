//
//  EmployeeDetailVC.swift
//  RaiseCompanyApp
//
//  Created by mei_yocontrolo on 21/02/2023.
//

import Foundation
import UIKit
import Alamofire

class EmployeeDetailViewController: UIViewController{
    
    
    var id_employee_getted: Int?
    
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    
    @IBOutlet weak var workPosition: UILabel!
    
    @IBAction func editBtn(_ sender: UIButton) {
        print(id_employee_getted!)
    }
    
    @IBOutlet weak var age: UILabel!
    
    @IBOutlet weak var mail: UILabel!
    
    @IBOutlet weak var number: UILabel!
    
    
    @IBOutlet weak var schedule: UILabel!
    
    
    
    
}
