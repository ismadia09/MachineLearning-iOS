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
    @IBOutlet weak var canvasView: Canvas!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var validateButton: UIButton!
    @IBOutlet weak var valueTrainingTextField: UITextField!
    var images : [UIImage] = []
    var image = UIImage()
    @IBOutlet weak var ocrResultLabel: UILabel!
    
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
        //self.navigationController?.navigationBar.barTintColor = UIColor.lightGray
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
        self.ocrResultLabel.text = "Waiting for OCR"
        guard let imageBase64String = Utlis.convertImageToBase64(image: image) else {
            return
        }
        var type = "ask"
        if (trainingSwitch.isOn){
            type = "train"
        }
        var number = Number(image: imageBase64String, type: type, expectedResult: 0)
        if (type.elementsEqual("train")){
            if(!valueTrainingTextField.text!.elementsEqual("") && valueTrainingTextField.text?.count == 1){
                let expectedResult = Int(valueTrainingTextField.text!)!
                //Requests.sendDrawnNumbers(image: imageBase64String, type: type, expectedResult: calculResult
                number = Number(image: imageBase64String, type: type, expectedResult: expectedResult)
                
            }else{
                let alert = UIAlertController(title: "Error", message: "Fill valueTraining field", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                return
            }
        }
        
        Requests.sendDrawnNumbers(number : number) { (result) in
            if (result != -1){
                self.ocrResultLabel.text = "Result sended by OCR\t:\t\(result)"
            }else{
                self.ocrResultLabel.text = "A problem has occured"

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

