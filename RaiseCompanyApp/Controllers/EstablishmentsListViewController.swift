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
    

    public var establishments: [EstablishmentSQLView]?
    
    
    @IBOutlet weak var mySearchBar: UISearchBar!
    @IBOutlet weak var myEstablishmentListTableView: UITableView!
    
    
    @IBAction func btnPrueba(_ sender: Any) {
        print(establishments?.count)
    }
    
    
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
        UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
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
  cell.numberEmployees.text = "\(establishment!.num_employees) Employees"
        if cell.rating == nil {
            cell.rating.image = UIImage(named: "oasiz")
        } else {
            cell.rating.image = UIImage(named: "\(establishment!.avg_rating!)rating")
        }
        
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoEstablishmentDetailedViewController", sender: nil)
        let id_establishment_selected = establishments?[indexPath.row].id_establishment
        
        print("id establishent selected    \(id_establishment_selected!)")
        print(" establishments count \(establishments?.count)")
        print(" indez  path \(indexPath.row + 1)")
        print(indexPath.row.self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            establishments?.remove(at: indexPath.row )
            print(indexPath.row)
            let idEstablishmentToDelete = establishments?[indexPath.row].id_establishment
            let locationEstablishment = establishments?[indexPath.row].location


            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.endUpdates()
            
        }
    }
    
    
    func getEstablishments(){
            AF.request("http://127.0.0.1:5000/safari/establishments/view").responseDecodable(of: [EstablishmentSQLView].self) { response in
                self.establishments = try? response.result.get()
                print(response.description)
                print(self.establishments?.count)
                self.myEstablishmentListTableView.reloadData()
                print("establishments count es \(self.establishments?.count)")
        }
    }
    

    
    
    
}


//indexpath.row stars in 0
//establishments array = 1
