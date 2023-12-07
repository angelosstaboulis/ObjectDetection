//
//  TextDetectionViewController.swift
//  ObjectDetection
//
//  Created by Angelos Staboulis on 7/12/23.
//

import UIKit
import Vision
class TextDetectionViewController: UIViewController {

    @IBOutlet weak var foundLabel: UITextView!
    @IBOutlet weak var mainImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initialViewController()
        // Do any additional setup after loading the view.
    }
    func textRequest(){
        do{
            let imageHandler = VNImageRequestHandler(cgImage: mainImage.image!.cgImage!)
            let request = VNRecognizeTextRequest { requestNew, error in
                if let textArray = requestNew.results as? [VNRecognizedTextObservation]{
                    for text in textArray{
                        DispatchQueue.main.async{
                            let getText = text.topCandidates(1)
                            for subtext in getText{
                                var newText:String!=""
                                newText = newText + subtext.string
                                self.foundLabel.text = self.foundLabel.text + newText + "\n"
                            }
                        }
                    }
                    
                }
              
            }
            request.usesCPUOnly = true
            try imageHandler.perform([request])
            
        }catch{
            debugPrint("something went wrong!!!"+error.localizedDescription)
        }
    }
    @objc func clickImage(sender:UITapGestureRecognizer){
        textRequest()
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
extension TextDetectionViewController{
    func initialViewController(){
        self.navigationItem.title = "Text Detection"
        mainImage.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(clickImage(sender:)))
        gesture.numberOfTapsRequired = 1
        mainImage.addGestureRecognizer(gesture)
    }
}
