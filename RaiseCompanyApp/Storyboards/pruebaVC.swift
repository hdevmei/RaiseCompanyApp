//
//  pruebaVC.swift
//  RaiseCompanyApp
//
//  Created by mei_yocontrolo on 20/02/2023.
//

import Foundation
import UIKit
import Alamofire

class pruebaVC: UIViewController{
    
    
    var establishment: EstablishmentSQLView?
    
    @IBOutlet weak var Imagen: UIImageView!
    
    
    @IBAction func getPhotoBtn(_ sender: UIButton) {
        getPhoto()
    }
    
    
    
    @IBAction func showPhotoBtn(_ sender: UIButton) {
        showPhoto()
    }
    
    
    
    
    func getPhoto() {
        AF.request("http://127.0.0.1:5000/safari/establishments/236")
            .responseDecodable(of: [EstablishmentSQLView].self) { response in
                switch response.result {
                case .success(let establishments):
                    if let firstEstablishment = establishments.first {
                        self.establishment = firstEstablishment
                        print(self.establishment)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    func showPhoto(){
        //        TRY TO SHOW IMAGE
                let strBase64 = "iVBORw0KGgoAAAANSUhEUgAAADgAAABICAYAAACjpDbfAAAACXBIWXMAACxLAAAsSwGlPZapAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAEzSURBVHgB7dsxTsMwGMXx97VD4QgMILLVE3ADOBnhCNyE3oAjlIV0I4ILdCss/kgrZaCxaFWnVV/1fmO8+C8njhcbejD+qh7NUaJHZijfL8MTMhky7SOu1UdkVuA+41q5kTsHHiKulRNp4bNynLABTpwC2SmQnQJFRHJ0DtvsZ9PqKvxp0m+CnQLZKZCdAtkpkJ0C2SmQnQLZKZCdAtkpkJ0C2SmQnQLZKZCdAtkpkJ0C2SmQnQLZKZCdAtkpkJ0C2XUDHTVImdt0/VliBX0CUnG4RaBHewGrYezcMewEzorwCvdnsGnmPLsI9frj5CYzij8lEu/zsfKIt0U8L1NjycBpcTcfxcUDxUo2c/z2s/u6KOap4Y13eMcf1bUNlnd17abZpm5xDFY7vU+W+8Xqk/rHL5CPVxeaQ0r8AAAAAElFTkSuQmCC"
                do{
                    let dataDecoded : Data = Data(base64Encoded: strBase64, options:  .ignoreUnknownCharacters)!
                    let decodedImage: UIImage = UIImage(data: dataDecoded as Data)!
                    Imagen.image = decodedImage
                }catch{
                    Imagen.backgroundColor = .red
                }
    }
    
}
