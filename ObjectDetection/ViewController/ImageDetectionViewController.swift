//
//  ImageDetectionViewController.swift
//  ObjectDetection
//
//  Created by Angelos Staboulis on 7/12/23.
//

import UIKit
import Vision
class ImageDetectionViewController: UIViewController {

    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var foundLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        initialViewController()
        // Do any additional setup after loading the view.
    }
    @objc func clickImage(sender:UITapGestureRecognizer){
        imageRequest()
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
extension ImageDetectionViewController{
    func initialViewController(){
        self.navigationItem.title = "Image Detection"
        mainImage.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(clickImage(sender:)))
        gesture.numberOfTapsRequired = 1
        mainImage.addGestureRecognizer(gesture)
    }
    func imageRequest(){
            let imageHandler = VNImageRequestHandler(cgImage: mainImage.image!.cgImage!)
        do{
            let request =  VNDetectFaceRectanglesRequest { request, error in
                    if let facesArray = request.results as? [VNFaceObservation]{
                        DispatchQueue.main.async{
                            self.foundLabel.text = String(format:"faces found = %d",facesArray.count)
                        }
                    }
                    
                    
                    
                }
                request.usesCPUOnly = true
                try imageHandler.perform([request])
            } catch{
            debugPrint("something went wrong!!!!")
        }
    }
}
