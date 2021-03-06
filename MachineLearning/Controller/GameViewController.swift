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
    @IBOutlet weak var canvasView: Canvas!
    @IBOutlet weak var clearButton: RoundedButton!
    var gameTimer : Timer!
    let cellId = "operationsCell"
    let type = "ask"
    let space : CGFloat = 30
    var gameLogic = GameLogic()
    var answers : [Bool] = []
    var operation : [Operation] = []{
        didSet {
            operationsCollectionView.reloadData()
        }
    }
    var clearable = true
    var resultString = ""
    var correctAnswerCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Game"
        //clearable = canvasView.clearable
        //clearButton.isEnabled = clearable
        collectionViewSetup()
        gameSetup()
        pageContolSetup()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func validateAction(_ sender: Any) {
        //goToNextOperation()
        saveUserResponse()
    }
    @IBAction func clearCanvas(_ sender: Any) {
        canvasView.clearCanvas()
    }
    func collectionViewSetup(){
        operationsCollectionView.delegate = self
        operationsCollectionView.dataSource = self
        operationsCollectionView.isPagingEnabled = true
        operationsCollectionView.showsHorizontalScrollIndicator = false
        operationsCollectionView.isUserInteractionEnabled = false
        let nib = UINib(nibName: "OperationsCollectionViewCell", bundle: nil)
        operationsCollectionView.register(nib, forCellWithReuseIdentifier: cellId)
    }
    func gameSetup(){
        gameLogic.operations.removeAll()
        gameLogic.generateOperations(nbOfOperations: 5)
        operation = gameLogic.operations
        correctAnswerCount = 0
    }
    
    func pageContolSetup(){
        pageControl.currentPage = 0
        pageControl.numberOfPages = operation.count
        pageControl.currentPageIndicatorTintColor = UIColor.red
        pageControl.pageIndicatorTintColor = UIColor(red: 247/255, green: 161/255, blue: 54/255, alpha: 1)
    }

    func goToNextOperation(){
        var nextPage = pageControl.currentPage + 1
        if (nextPage < pageControl.numberOfPages){
            pageControl.currentPage = nextPage
        }else{
            nextPage = 0
            gameSetup()
            pageControl.currentPage = nextPage
            let alert = UIAlertController(title: "Game ended", message: "\(resultString)", preferredStyle: .alert)
            let replayAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(replayAction)
            self.present(alert, animated: true, completion: nil)

        }
        let indexPath = IndexPath(item: nextPage, section: 0)
        operationsCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        canvasView.clearCanvas()
    }

    
    func saveUserResponse(){
        let image = canvasView.takeScreenshot()
        guard let imageBase64String = Utlis.convertImageToBase64(image: image) else {
            return
        }
        
        let expectedResult = operation[pageControl.currentPage].getResult()
        let number = Number(image: imageBase64String, type: type, expectedResult: expectedResult)
        Requests.sendDrawnNumbers(number: number) { (result) in
            if (expectedResult == result){
                //Le resultat est bon
                self.answers.append(true)
                self.canvasView.backgroundColor = UIColor.green
                self.correctAnswerCount += 1
                
            }else{
                self.answers.append(false)
                self.canvasView.backgroundColor = UIColor.red

            }
             self.resultString = "Correct answers : \(self.correctAnswerCount) on \(self.operation.count)"
             self.gameTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.getReadyForAnswer), userInfo: nil, repeats: false)
        }
        
    }
    
    @objc func getReadyForAnswer(){
            self.canvasView.backgroundColor = UIColor.white
            goToNextOperation()
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
