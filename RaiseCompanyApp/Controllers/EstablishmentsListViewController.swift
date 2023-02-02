//
//  EstablishmentsListVC.swift
//  RaiseCompanyApp
//
//  Created by mei_yocontrolo on 24/01/2023.
//

import UIKit
import Alamofire
import Foundation
import Kingfisher
class EstablishmentListViewController : UIViewController, UITableViewDelegate, UITableViewDataSource{
    

    public var establishments: [Establishment]?
    
    
    @IBOutlet weak var mySearchBar: UISearchBar!
    @IBOutlet weak var myEstablishmentListTableView: UITableView!
    
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myEstablishmentListTableView.delegate = self
        myEstablishmentListTableView.dataSource = self
        myEstablishmentListTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        //           getUsers()
        getEstablishments()
    }
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return establishments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EstablishmentTableViewCell
        let establishment = establishments?[indexPath.row]
        cell.location.text = establishment?.location
        cell.benefits.titleLabel?.text = "▲  \(establishment!.benefits)"
        cell.losses.titleLabel?.text = "▲  \(establishment!.losses)"
        cell.imgEstablishment.kf.setImage(with: URL(string: "\(establishment!.photo)"))
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "EstablishmentDetailedViewController", sender: nil)
    }
    
    
    func getEstablishments(){
            AF.request("http://127.0.0.1:5000/company/establishments").responseDecodable(of: [Establishment].self) { response in
                self.establishments = try? response.result.get()
                print(self.establishments?.count)
                self.myEstablishmentListTableView.reloadData()
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
    
    
    
}
