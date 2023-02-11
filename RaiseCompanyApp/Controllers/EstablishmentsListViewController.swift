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
    
    
    
    
    @IBOutlet weak var mySearchBar: UISearchBar!
    @IBOutlet weak var myEstablishmentListTableView: UITableView!
    
    
    @IBAction func goToAddEstablishmentBtn(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goToAddEstablishment", sender: nil)
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
        print("getting estsblishments")
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
            //            print(response.description)
            self.myEstablishmentListTableView.reloadData()
            print("establishments count es \(self.establishments?.count)")
        }
    }
    
    
   
    
    
     func postEstablishment(establishmentToAdd : EstablishmentSQLView?){
        
        let url = "http://127.0.0.1:5000/safari/establishments"
        
        AF.request(url, method: .post, parameters: establishmentToAdd, encoder: JSONParameterEncoder.default)
            .validate(statusCode: 200..<300)
            .response { response in
                switch response.result {
                case .success:
                    print("POST request successful")
                    self.getEstablishments()
                    self.establishments!.append(establishmentToAdd!)
                    self.myEstablishmentListTableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        
    }
    
    
    @IBAction func btnPrueba(_ sender: Any) {
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "goToAddEstablishment" {
               let destinoVC = segue.destination as! AddEstablishmentViewController
               destinoVC.postEstablishmentFunction = postEstablishment
           }
       }
    
    
    
}




//indexpath.row stars in 0
//establishments array = 1
