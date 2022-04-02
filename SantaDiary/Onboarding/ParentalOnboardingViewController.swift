//
//  OnboardingViewController.swift
//  SantaDiary
//
//  Created by Brian Veitch on 3/26/22.
//

import UIKit

class ParentalOnboardingViewController: UIViewController {

    
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
            OnboardingSlide(title: "Your responsibility", description: "Your role is very important. Your job is to assist the child when entering diary entrires or writing letters. You also respond on behalf of Santa or his elves. Make it an engaging activity each night to reflect on their day. It helps you open a dialog to discuss good or not so good parts of their day.", image: UIImage(named: App.holidayImages[4])!),
            OnboardingSlide(title: "Santa Letters", description: "When a child writes a letter to Santa, you will come here and write a letter back. Make sure you are responding to specific things in their letter. You can also prompt the child with some goals for the week.", image: UIImage(named: App.holidayImages[0])!),
            OnboardingSlide(title: "Santa Diary", description: "There are three categories of questions. When a child answers one cateogry question four times, the app will prompt you to write a letter to the child as a Santa Elf. Write a meaningful message that focuses on those specific diary entries. You can address any positive or negative things as long as you are constructive and encouraging.", image: UIImage(named: App.holidayImages[1])!),
            OnboardingSlide(title: "Nice or Naughty List", description: "You have to pre-select whether the child is on the nice or naughty list, which you can change at any point. You can also select a goal for the child to complete.", image: UIImage(named: App.holidayImages[3])!)
            
        ]

        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setupViews() {
  
        pageControl.numberOfPages = slides.count
        
        // next button
        nextButton.layer.cornerRadius = 10
        nextButton.backgroundColor = ColorScheme.eventButtonBackgroundColor
        nextButton.setTitleColor(ColorScheme.eventButtonTextColor, for: .normal)
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        if currentPage == slides.count - 1 {
            
            UserDefaults.standard.parentHasOnboarded = true
            performSegue(withIdentifier: "onboardingToParentSettings", sender: nil)
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
}

extension ParentalOnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
