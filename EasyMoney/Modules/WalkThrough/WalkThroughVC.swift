//
//  WalkThroughVC.swift
//  EasyMoney
//
//  Created by Ahmed Shawky on 14/11/2021.
//

import UIKit

class WalkThroughVC: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var currentPage = 0{
        didSet{
            pageControl.currentPage = currentPage
            if currentPage ==  slides.count - 1{
                nextButton.setTitle("Get started!", for: .normal)
            }else if currentPage < slides.count - 1{
                nextButton.setTitle("Next", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSlides()
        pageControl.numberOfPages = slides.count
    }
    
    @IBAction func NextButtonClicked(_ sender: UIButton) {
        if currentPage == slides.count - 1{
            UserDefaults.standard.setValue(true, forKey: "hasViewedWalkthrough")
//            let tabBar = MainTabBar.instantiate(storyboard: .main)
//            tabBar.modalPresentationStyle = .fullScreen
//            present(tabBar, animated: true, completion: nil)
        } else {
            currentPage += 1
            let rect = collectionView.layoutAttributesForItem(at: IndexPath(row: currentPage, section: 0))?.frame
            collectionView.scrollRectToVisible(rect!, animated: true)
        }
    }
    
}

extension WalkThroughVC:UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WalkThroughCell.identifier, for: indexPath)as! WalkThroughCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width , height: collectionView.frame.height)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}
