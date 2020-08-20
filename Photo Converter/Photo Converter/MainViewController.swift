//
//  MainViewController.swift
//  Photo Converter
//
//  Created by Arman Riasi on 8/20/20.
//  Copyright © 2020 Arman Riasi. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Main Screen"
    }
    
    
    @IBAction func openPhoto(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        self.present(imagePickerController, animated: true, completion: nil)
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let SecondViewController = mainStoryboard.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else {
            print("Couldn't find the view controller")
            return
        }
        navigationController?.pushViewController(SecondViewController, animated: true)
        
        }
    
    @IBAction func openCamera(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .camera
        self.present(imagePickerController, animated: true, completion: nil)
    }
    


}
