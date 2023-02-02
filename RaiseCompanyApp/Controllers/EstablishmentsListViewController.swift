//
//  EstablishmentsListVC.swift
//  RaiseCompanyApp
//
//  Created by mei_yocontrolo on 24/01/2023.
//

import UIKit
import Alamofire
import Foundation


class EstablishmentListViewController : UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var establishments: [Establishment]?
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
          return cell
      }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hola")

        performSegue(withIdentifier: "EstablishmentDetailedViewController", sender: nil)

    }
    
    @IBOutlet weak var mySearchBar: UISearchBar!
    
    @IBOutlet weak var myEstablishmentListTableView: UITableView!
    
    
       override func viewDidLoad() {
           super.viewDidLoad()
           // Do any additional setup after loading the view.
           myEstablishmentListTableView.delegate = self
           myEstablishmentListTableView.dataSource = self
           myEstablishmentListTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
           
//           getUsers()
           getEstablishments()
           print(establishments?.count)
       }
    
    
  
    
    func getEstablishments() {
        AF.request("http://127.0.0.1:5000/company/establishments").responseDecodable(of: [Establishment].self) { response in
            self.establishments = try? response.result.get()
            print(self.establishments)
        }
    }


}



struct Establishment: Codable {
    let benefits: Int
    let id_establishment: Int
    let location: String
    let losses: Int
    let photo: String
    let schedule: String
}



