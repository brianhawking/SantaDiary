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
            OnboardingSlide(title: "Santa Letters", description: "You can write letters to Santa as many times as you want. You can tell Santa why you should be on the Nice list and what you want for Christmas. You will also receive a letter from Santa within a few days. ", image: UIImage(named: App.holidayImages[0])!),
            OnboardingSlide(title: "Santa Diary", description: "This app acts as a Christmas themed diary. Each day you answer two simple questions that helps you journal and reflect. The second question will be one of the categories: Kindness, Smiles, and Learning.  After a certain number of questions are answered in a given category, a Santa elf will write you a letter.", image: UIImage(named: App.holidayImages[1])!),
            OnboardingSlide(title: "Nice or Naughty List", description: "You can check if you are on the Nice or Naughty list. No matter which list you are on, you will always receive a goal to complete. An example could be 'help someone with their chores.' Completing these goals will also give you something to write about in your diary. ", image: UIImage(named: App.holidayImages[3])!),
            OnboardingSlide(title: "Parent's Section", description: "Parents - your involvment is crucial. After this onboarding you will be prompted to enter a password. This gives you access to the Parent's section of the app, which is found in each profile. More information about what you do will be found there.", image: UIImage(named: App.holidayImages[4])!)
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
        
        pageControl.numberOfPages = slides.count
        
        view.backgroundColor = ColorScheme.backgroundColor
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        if currentPage == slides.count - 1 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "toHome") as! UINavigationController
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .flipHorizontal
            UserDefaults.standard.hasOnboarded = true
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
