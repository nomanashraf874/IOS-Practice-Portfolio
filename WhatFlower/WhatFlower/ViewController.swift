//
//  ViewController.swift
//  WhatFlower
//
//  Created by Noman Ashraf on 8/18/22.
//

import UIKit
import CoreML
import Vision
import SDWebImage

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    let wikiManager = WikiManager()
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    let imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        imagePicker.delegate=self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        wikiManager.delegate=self
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userImage = info[UIImagePickerController.InfoKey.originalImage]as? UIImage{
            guard let ciimage=CIImage(image: userImage)else{
                fatalError("Could not convert to CIImage")
            }
            detect(flowerImage: ciimage)
        }
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    func detect(flowerImage: CIImage){
        guard let model = try? VNCoreMLModel(for: FlowerClassifier().model)else{
            fatalError("Cannot create model")
        }
        let request = VNCoreMLRequest(model: model) { request, error in
            guard let results = request.results as? [VNClassificationObservation] else{
                fatalError("could not classigy result")
            }
            if let firstResult = results.first{
                self.navigationItem.title = firstResult.identifier.capitalized
                self.wikiManager.fetchInfo(title: firstResult.identifier)
            }
        }
        let handler=VNImageRequestHandler(ciImage: flowerImage)
        do{
            try handler.perform([request])
        }
        catch{
            print(error)
        }
        
    }
    
    @IBAction func cameraPressed(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
    

}
//MARK: - WikiManagerDelegate
extension ViewController: WikiManagerDelegate{
    
    func didUpdateWiki(info: String, url: String){
        DispatchQueue.main.sync {
            infoLabel.text=info
            self.imageView.sd_setImage(with: URL(string: url))
        }
    }
    func didFailWithError(error: Error){
        print(error)
    }
}

