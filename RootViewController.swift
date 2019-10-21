//
//  RootViewController.swift
//  TestingSaveImageMania
//
//  Created by Likhit Garimella
//  Copyright © 2019.
//

import TinyConstraints
import FirebaseStorage
import FirebaseFirestore
import Kingfisher

struct MyKeys {
    static let imagesFolder = "imagesFolder"
    static let imagesCollection = "imagesCollection"
    static let uid = "uid"
    static let imageUrl = "imageUrl"
}

class RootViewController: UIViewController {
    
    lazy var takePhotoBarButtonItem = UIBarButtonItem(title: "Take", style: .done, target: self, action: #selector(takePhoto))
    
    lazy var savePhotoBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(savePhoto))
    
    lazy var uploadPhotoBarButtonItem = UIBarButtonItem(title: "Upload", style: .done, target: self, action: #selector(uploadPhoto))
    
    lazy var downloadPhotoBarButtonItem = UIBarButtonItem(title: "Download", style: .plain, target: self, action: #selector(downloadPhoto))
    
    lazy var imagePickerController: UIImagePickerController = {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .camera
        return controller
    }()
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    let activityIndicator = UIActivityIndicatorView(style: .gray)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupNavigationItem()
        setupViews()
    }
    
    fileprivate func setupNavigationItem() {
        navigationItem.setLeftBarButtonItems([takePhotoBarButtonItem, savePhotoBarButtonItem], animated: false)
        navigationItem.setRightBarButtonItems([uploadPhotoBarButtonItem, downloadPhotoBarButtonItem], animated: false)
    }
    
    fileprivate func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(imageView)
        view.addSubview(activityIndicator)
        
        imageView.edgesToSuperview()
        activityIndicator.centerInSuperview()
    }

    @objc fileprivate func takePhoto() {
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc fileprivate func savePhoto() {
        
        guard let image = imageView.image else { return }
        activityIndicator.startAnimating()
        
        // add code here
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc fileprivate func uploadPhoto() {
        // add code here
        
    }
    
    @objc fileprivate func downloadPhoto() {
        // add code here
        
    }
    
    func saveToAlbum(named: String, image: UIImage) {
        // add code here
        
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError err: Error?, contextInfo: UnsafeRawPointer) {
        activityIndicator.stopAnimating()
        if let err = err {
            // we got back an error!
            presentAlert(title: "Error", message: err.localizedDescription)
        } else {
            presentAlert(title: "Saved!", message: "Image saved successfully")
        }
    }
    
    func presentAlert(title: String, message: String) {
        activityIndicator.stopAnimating()
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

}

extension RootViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            print("Image not found!")
            return
        }
        imageView.image = selectedImage
        imagePickerController.dismiss(animated: true, completion: nil)
    }
}

