//
//  EstablishmentDetailedViewController.swift
//  RaiseCompanyApp
//
//  Created by mei_yocontrolo on 16/01/2023.
//

import UIKit

class EstablishmentDetailedViewController : UIViewController {
    @IBOutlet weak var nEmployees: UILabel!
    var establishment: Establishment?
    
    
    
    
    @IBOutlet weak var locationName: UILabel!
    //Outlets
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //
    
    override func viewWillAppear(_ animated: Bool) {

        nEmployees.text = "\(establishment!.nEmployees)"
        
        
    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        return concert?.reviews.count ?? 0
//    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        let reviewRow: ReviewRow = tableView.dequeueReusableCell(withIdentifier: "reviewRowID", for: indexPath) as! ReviewRow
////        let review = concert?.reviews[indexPath.row]
////
////        reviewRow.ratingProgress.progress = Float(review?.rating ?? 0) / Concert.MAX_RATING
////        reviewRow.reviewLabel.text = review?.comment
////
////        return reviewRow
//    }
    
}
