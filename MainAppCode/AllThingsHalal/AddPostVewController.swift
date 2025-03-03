//
//  AddPostVewController.swift
//  AllThingsHalal
//
//  Created by Nayla Rosihan on 28/5/2024.
//

import UIKit

class Event {
    var image: UIImage?
    
    init(image: UIImage?) {
        self.image = image
    }
}

class AddPostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var eventDescriptionTextView: UITextView!
    @IBOutlet var urlTextField: UIView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(selectImageFromPhotoLibrary))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(imageTap)
    }
    
    
    @objc func selectImageFromPhotoLibrary() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true

        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { _ in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true)
        }

        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true)
            } else {
                print("Camera not available")
            }
        }

        alertController.addAction(cancelAction)
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cameraAction)

        present(alertController, animated: true)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    @IBAction func postButton(_ sender: UIButton) {
        }
    
}
