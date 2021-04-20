//
//  ViewController.swift
//  notAHotDog
//
//Shehzan Maredia
// Dan Hepworth

import UIKit
import SwiftUI
import Vision
import VisionKit
import CoreML

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var importButton: UIButton!
    
    @IBOutlet weak var cameraButton: UIButton!
    
    var alertController: UIAlertController!
    
    var image: UIImage! 
    
    var showActionSheet = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        importButton.layer.cornerRadius = 60.0
        cameraButton.layer.cornerRadius = 60.0
        
        importButton.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        cameraButton.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        
        importButton.addTarget(self, action: #selector(importAction), for: .touchUpInside)
        cameraButton.addTarget(self, action: #selector(cameraAction), for: .touchUpInside)
        
    }
    
    @IBAction func cameraAction(sender: UIButton!) {
        print("use camera")
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .camera
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func importAction(sender: UIButton!) {
        print("use photo library")
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .photoLibrary
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.image = editedImage
            print("got image")
        }else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            self.image = originalImage
            print("got image")
        }
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
            let destVC = segue.destination as! detailHotDogVC
            destVC.image = self.image
    }


    
    func isAHotDog (image: CIImage) {
            
        
            guard let model = try? VNCoreMLModel(for: Inceptionv3.model) else {
                fatalError("Error: unable to load ML model")
            }
            
            let request = VNCoreMLRequest(model: model) { request, error in
                guard let output = request.results as? [VNClassificationObservation],
                    let bestResult = output.first
                    else {
                        fatalError("Error: unexpected result type from VNCoreMLRequest")
                    }
                
                    if bestResult.identifier.contains("hotdog") {
                        DispatchQueue.main.async {
                           // ADD WHAT WE WANT TO HAPPEN IF HOTDOG
                            
                            
                            // self.navigationItem.title = "Hotdog!"
                           // self.navigationController?.navigationBar.barTintColor = UIColor.green
                          //  self.navigationController?.navigationBar.isTranslucent = false
                        }
                    }
                    else {
                        DispatchQueue.main.async {
                            // ADD WHAT WE WANT TO HAPPEN IF NOT HOTDOG
                            
                            
                            // self.navigationItem.title = "Not Hotdog!"
                            //self.navigationController?.navigationBar.barTintColor = UIColor.red
                           // self.navigationController?.navigationBar.isTranslucent = false
                            
                        }
                    }
                    
                
            }
            
            let handler = VNImageRequestHandler(ciImage: image)
            
            do { try handler.perform([request]) }
            catch { print(error) }
            
            
            
        }



}

