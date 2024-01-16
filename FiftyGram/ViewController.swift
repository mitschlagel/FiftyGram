//
//  ViewController.swift
//  Fiftygram
//
//  Created by Spencer Jones on 1/16/24.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let context = CIContext()
    
    var original: UIImage?
    
    @IBOutlet var imageView: UIImageView!
    
    @IBAction func choosePhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            navigationController?.present(picker, animated: true, completion: nil)
        }
    }
    
    @IBAction func applySepia() {
        guard let original = original else { return }
        
        let filter = CIFilter(name: "CISepiaTone")
        filter?.setValue(0.5, forKey: kCIInputIntensityKey)
        guard let image = imageView.image else { return }
        filter?.setValue(CIImage(image: original), forKey: kCIInputImageKey)
        guard let output = filter?.outputImage?.oriented(.up) else { return }
        imageView.image = UIImage(cgImage: self.context.createCGImage(output, from: output.extent)!)
    }
    
    @IBAction func applyNoir() {
        guard let original = original else { return }
        guard let filter = CIFilter(name: "CIPhotoEffectNoir") else { return }
        display(filter: filter)
        
    }
    
    @IBAction func applyVintage() {
        guard let original = original else { return }
        guard let filter = CIFilter(name: "CIPhotoEffectProcess") else { return }
        display(filter: filter)
    }
    
    func display(filter: CIFilter) {
        guard let original = imageView.image else { return }
        filter.setValue(CIImage(image: original), forKey: kCIInputImageKey)
        guard let output = filter.outputImage?.oriented(.up) else { return }
        imageView.image = UIImage(cgImage: self.context.createCGImage(output, from: output.extent)!)
    }
                         

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        navigationController?.dismiss(animated: true)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
            original = image
        }
    }


}

