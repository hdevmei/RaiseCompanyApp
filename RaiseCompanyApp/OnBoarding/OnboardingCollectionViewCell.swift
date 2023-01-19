import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: OnboardingCollectionViewCell.self)
    
    
    
    
    @IBOutlet weak var slideImageView: UIImageView!
    @IBOutlet weak var slideTittle: UILabel!
    
    func setup(_ slide: OnboardingSlide){
        slideTittle.text = slide.tittle
        slideImageView.image = slide.image
    }
}
