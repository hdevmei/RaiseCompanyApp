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
    var filteredEstablishments: [EstablishmentSQLView] = []
    
    @IBAction func btnPrueba(_ sender: Any) {
        postEstablishment()
        getEstablishments()
        print("boton prueba apretadi")
        myEstablishmentListTableView.reloadData()
    }
    
    
    
    @IBOutlet weak var mySearchBar: UISearchBar!
    @IBOutlet weak var myEstablishmentListTableView: UITableView!
    
        
    @IBAction func goToAddEstablishmentBtn(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "madero", sender: nil)
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    @objc func loadList(notification: NSNotification){
        //load data here
        getEstablishments()
    myEstablishmentListTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return establishments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EstablishmentTableViewCell
        let establishment = establishments?[indexPath.row]
        cell.location.text = establishment?.location
        cell.benefitsLabel.text = "   ▲ \(establishment!.benefits!) €"
        cell.lossesLabel.text = "   ▲ \(establishment!.losses!) €"
        //        cell.imgEstablishment.kf.setImage(with: URL(string: "\(establishment!.photo)"))
        cell.numberEmployees.text = "\(establishment!.num_employees) Employees"
        //        cell.rating.image = UIImage(named: "oasiz")
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoEstablishmentDetailedViewController", sender: nil)
        let id_establishment_selected = establishments?[indexPath.row].id_establishment
        print("id establishent selected    \(id_establishment_selected!)")
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {
            return
        }
        
        deleteEstablishment(at: indexPath.row)
    }
    
    
    
    //    URL METHODS
    
    func deleteEstablishment(at index: Int) {
        guard let establishmentId = establishments![index].id_establishment else {
            return
        }
        
        let url = "http://127.0.0.1:5000/safari/establishments/\(establishmentId)"
        AF.request(url, method: .delete).response { [weak self] response in
            guard let self = self else {
                return
            }
            
            switch response.result {
            case .success:
                self.establishments!.remove(at: index)
                self.myEstablishmentListTableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
            case .failure(let error):
                print("Failed to delete employee: \(error)")
            }
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
    
    
    
    var establishmentToAdd : Establishment = Establishment(benefits: 234234, id_establishment: 2342, location: "a bue o", losses: 2342, photo: nil, schedule: "estfe ees el horario")

    
    
    
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
        myEstablishmentListTableView.reloadData()
     }
    
    
    
}




//indexpath.row stars in 0
//establishments array = 1
