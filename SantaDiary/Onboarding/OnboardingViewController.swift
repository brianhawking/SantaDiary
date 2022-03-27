//
//  OnboardingViewController.swift
//  SantaDiary
//
//  Created by Brian Veitch on 3/26/22.
//

import UIKit

class OnboardingViewController: UIViewController {

    
    @IBOutlet weak var nextButton: UIButton!
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextButton.setTitle("Let's get started!", for: .normal)
            } else {
                nextButton.setTitle("Next", for: .normal)
            }
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides: [OnboardingSlide] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slides = [
            OnboardingSlide(title: "one", description: "first description of the boardining cell stuff. I wonder if this is going to look right when I run it again?", image: UIImage(named: App.holidayImages[0])!),
            OnboardingSlide(title: "second", description: "second esoijojsodijfoi sfoijsdfo ijsdfojo sfdoij sdfoij oisj oioijsdoifjds ", image: UIImage(named: App.holidayImages[1])!),
            OnboardingSlide(title: "third", description: "ljasdoij sdfopij oiasjdfoij soadifjoisdfjoi jsdoifoijoijdfoi woifj oisdj soidfjo isdfj lakj a saioj foa wi eijoaf aoid", image: UIImage(named: App.holidayImages[3])!)
        ]

        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
        
        setupViews()
    }
    
    func setupViews() {
        
        // next button
        nextButton.layer.cornerRadius = 10
        nextButton.backgroundColor = ColorScheme.eventButtonBackgroundColor
        nextButton.setTitleColor(ColorScheme.eventButtonTextColor, for: .normal)
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        if currentPage == slides.count - 1 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "toHome") as! UINavigationController
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .flipHorizontal
            present(vc, animated: true)
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "onboardingCollectionViewCell", for: indexPath) as! OnboardingCollectionViewCell
        
        cell.setup(slide: slides[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
    
    
}
