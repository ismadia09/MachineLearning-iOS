//
//  MainViewController.swift
//  MachineLearning
//
//  Created by Isma Dia on 04/12/2018.
//  Copyright © 2018 Isma Dia. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var trainingSwitch: UISwitch!
    @IBOutlet weak var canvasView: CanvasView!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var validateButton: UIButton!
    @IBOutlet weak var valueTrainingTextField: UITextField!
    var images : [UIImage] = []
    var image = UIImage()
    
    @IBOutlet weak var imageView: UIImageView!
    /*  var imageView : UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor.cyan
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()*/
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Training"
        self.navigationController?.navigationBar.barTintColor = UIColor.lightGray
        //setupImageView()

        // Do any additional setup after loading the view.
    }

    func setupImageView(){
        self.view.addSubview(imageView)
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.centerXAnchor.constraint(equalToSystemSpacingAfter: self.view.centerXAnchor, multiplier: 1).isActive = true
        imageView.centerYAnchor.constraint(equalToSystemSpacingBelow: self.view.centerYAnchor, multiplier: 1).isActive = true

    }
    
    func putImageInImageView(){
        image = canvasView.takeScreenshot()
        images = [image]
        imageView.image = image
    }
    @IBAction func clearCanvas(_ sender: Any) {
        canvasView.clearCanvas()
    }
    
    @IBAction func shareAction(_ sender: Any) {
       putImageInImageView()
        let activityViewController = UIActivityViewController(activityItems: images, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        present(activityViewController, animated: true, completion: nil)
    }
    @IBAction func validateAction(_ sender: Any) {
        putImageInImageView()
        guard let imageBase64String = Utlis.convertImageToBase64(image: image) else {
            return
            }
        var type = "ask"
        if (trainingSwitch.isOn){
            type = "train"
        }
        
        let expectedResult = Int(valueTrainingTextField.text!)!
        //Requests.sendDrawnNumbers(image: imageBase64String, type: type, expectedResult: calculResult
        let number = Number(image: imageBase64String, type: type, expectedResult: expectedResult)

        Requests.sendDrawnNumbers(number : number) { (result) in
            if (result == expectedResult){
                
            }
        }
                                  
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
