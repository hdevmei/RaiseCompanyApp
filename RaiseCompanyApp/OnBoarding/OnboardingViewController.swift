//
//  OnboardingViewController.swift
//  Onboarding
//
//  Created by mei_yocontrolo on 14/01/2023.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count-1 {
                nextButton.setTitle("Get Started", for: .normal)
        
            } else {
                nextButton.setTitle("Next", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    var slides: [OnboardingSlide] = [OnboardingSlide(tittle: "Manage your company in a simple way", image: UIImage(named: "step1")!), OnboardingSlide(tittle: "Consult information about the establishments", image: UIImage(named: "step2")!), OnboardingSlide(tittle: "Make your employees feel more comfortable", image: UIImage(named: "step3")!), OnboardingSlide(tittle: "Consult the graphics to make decisions", image: UIImage(named: "step4")!)]
    
    
    
    
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        if currentPage == slides.count-1 {
            let controller = storyboard?.instantiateViewController(withIdentifier: "mainTabBarVC") as! UIViewController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .flipHorizontal
            present(controller, animated: true, completion: nil)
        }else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        
    }
    
}
    
    extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return slides.count
        }
        
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
            cell.setup(slides[indexPath.row])
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
        
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let width = scrollView.frame.width
            currentPage = Int(scrollView.contentOffset.x/width)
            pageControl.currentPage = currentPage
        }
        
        
        
        
    }
    
    
    
