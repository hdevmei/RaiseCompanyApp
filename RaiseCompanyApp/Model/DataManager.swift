//
//  DataManager.swift
//  RaiseCompanyApp
//
//  Created by mei_yocontrolo on 25/01/2023.
//

import Foundation
import Alamofire



class DataManager: UIViewController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("holaaa")
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnPrueba(_ sender: UIButton) {
    }
    
    @IBAction func btnGet(_ sender: UIButton) {
    }
    
    
    @IBAction func btnDelete(_ sender: UIButton) {
    }
    
    
    
    
    static func postMethod(url: URL, params:Parameters) {
            AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = value as! [String: Any]
                    print(json)
                case .failure(let error):
                    print(error)
                }
            }
    }
}


