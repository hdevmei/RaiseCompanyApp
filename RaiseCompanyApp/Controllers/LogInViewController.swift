//
//  LogInViewController.swift
//  RaiseCompanyApp
//
//  Created by mei_yocontrolo on 05/02/2023.
//

import UIKit

class LogInViewController: UIViewController {
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        userName.layer.cornerRadius = 15
        userName.layer.masksToBounds = true
        
        password.layer.cornerRadius = 15
        password.layer.masksToBounds = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
