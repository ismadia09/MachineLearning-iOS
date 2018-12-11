//
//  GameViewController.swift
//  MachineLearning
//
//  Created by Isma Dia on 07/12/2018.
//  Copyright © 2018 Isma Dia. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var validateButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var operationsCollectionView: UICollectionView!
    let cellId = "operationsCell"
    let space : CGFloat = 30
    var gameLogic = GameLogic()
    //var item = 0
    var indexPath = IndexPath(item: 0, section: 0)
    var operation : [Operation] = []{
        didSet {
            operationsCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Game"
        collectionViewSetup()
        gameSetup()
        pageContolSetup()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func validateAction(_ sender: Any) {
        goToNextOperation()
    }
    func collectionViewSetup(){
        operationsCollectionView.delegate = self
        operationsCollectionView.dataSource = self
        operationsCollectionView.isPagingEnabled = true
        let nib = UINib(nibName: "OperationsCollectionViewCell", bundle: nil)
        operationsCollectionView.register(nib, forCellWithReuseIdentifier: cellId)
    }
    func gameSetup(){
        gameLogic.generateOperations(nbOfOperations: 5)
        operation = gameLogic.operations
    }
    
    func pageContolSetup(){
        pageControl.currentPage = 0
        pageControl.numberOfPages = operation.count
        pageControl.currentPageIndicatorTintColor = UIColor.magenta
        pageControl.pageIndicatorTintColor = UIColor.cyan
    }

    func goToNextOperation(){
        var nextPage = pageControl.currentPage + 1
        if (nextPage < pageControl.numberOfPages){
            pageControl.currentPage = nextPage
        }else{
            nextPage = 0
            pageControl.currentPage = nextPage

        }
        let indexPath = IndexPath(item: nextPage, section: 0)
        operationsCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension GameViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - space , height: collectionView.frame.height - space)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        print(Int(x / operationsCollectionView.frame.width))
        pageControl.currentPage = Int(x/operationsCollectionView.frame.width )
    }
}

extension GameViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return operation.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! OperationsCollectionViewCell
        cell.operationLabel.text = operation[indexPath.item].operationString
        return cell
    }
    
    
}
