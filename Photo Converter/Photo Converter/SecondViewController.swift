//
//  SecondViewController.swift
//  Photo Converter
//
//  Created by Arman Riasi on 8/20/20.
//  Copyright © 2020 Arman Riasi. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var image: UIImage? = nil
    var ConvertedImage: UIImage? = nil
    var boolForForwardButton = 0

    @IBOutlet var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

      //  title = "Second Screen"
       OpenPhoto()
    }
    
    @IBAction func openPhotos(_ sender: Any) {
        OpenPhoto()
        boolForForwardButton = 0
    }
    
    
    @IBAction func savePhotos(_ sender: Any) {
        let imageData = imageView.image!.pngData()
        let compresedImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compresedImage!, nil, nil, nil)
        
        let alert = UIAlertController(title: "Saved", message: "Your image has been saved", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
   
    
    @IBAction func convertPhoto(_ sender: Any) {
        ConvertedImage = addEffect(image: image!, name:"CIPhotoEffectChrome")
        imageView.image = ConvertedImage
        boolForForwardButton = 1

        }

    @IBAction func BackButton(_ sender: Any) {
        imageView.image = image
    }
    
    
    @IBAction func ForwardButton(_ sender: Any) {
        if boolForForwardButton == 1 {
            imageView.image = ConvertedImage
        }
    }
    
    
    @IBAction func blurButton(_ sender: Any) {
        
        ConvertedImage = addEffect(image: image!, name:"CIMotionBlur")
        imageView.image = ConvertedImage
        boolForForwardButton = 1

    }
    
    
    @IBAction func grayButton(_ sender: Any) {
        ConvertedImage = addEffect(image: image!, name:"CIPhotoEffectNoir")
        imageView.image = ConvertedImage
        boolForForwardButton = 1
    }
    
    
    func addEffect(image: UIImage, name: String) -> UIImage? {
        let context = CIContext(options: nil)
        if let filter = CIFilter(name: name) {
            filter.setValue(CIImage(image: image), forKey: kCIInputImageKey)
            
            if let output = filter.outputImage {
                if let cgImage = context.createCGImage(output, from: output.extent) {
                    return UIImage(
                        cgImage: cgImage,
                        scale: image.scale,
                        orientation: image.imageOrientation)
                }
            }
        }
        return nil
    }
    
    
    
    func OpenPhoto (){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        imagePickerController.sourceType = .photoLibrary
        self.present(imagePickerController, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        image = (info[UIImagePickerController.InfoKey.originalImage] as! UIImage)
        imageView.image = image
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
