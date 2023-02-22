//
//  SquareEmloyeeCollectionViewCell.swift
//  RaiseCompanyApp
//
//  Created by mei_yocontrolo on 05/02/2023.
//

import UIKit

class SquareEmloyeeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameEmployee: UILabel!
    @IBOutlet weak var imgEmployee: UIImageView!
    @IBOutlet weak var workPositionEmployee: UILabel!
    @IBOutlet weak var salaryEmployee: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    
    
    
    func desactivateDeleteBtn(){
        deleteBtn.isEnabled = false
        deleteBtn.isHidden = true
    }
    
}
