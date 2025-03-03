//
//  AddRestaurantViewController.swift
//  AllThingsHalal
//
//  Created by Nayla Rosihan on 28/5/2024.
//

import UIKit

class Resaturant {
    var image: UIImage?
    
    init(image: UIImage?) {
        self.image = image
    }
}

class AddResaturantVewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,  UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    

    @IBOutlet weak var restaurantDescriptionTextView: UITextView!
    @IBOutlet weak var cuisineTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var nameOfTheRestaurantTextField: UITextField!
    @IBOutlet weak var restaurantImageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(selectImageFromPhotoLibrary))
        restaurantImageView.isUserInteractionEnabled = true
        restaurantImageView.addGestureRecognizer(imageTap)
        setupPickerView()
    }
    
    
    
    let pickerData = ["Italian", "Mexican", "Chinese", "Japanese", "Indian"]
       var pickerView: UIPickerView!
       
       
       func setupPickerView() {
           pickerView = UIPickerView()
           pickerView.delegate = self
           pickerView.dataSource = self
           cuisineTextField.inputView = pickerView
           cuisineTextField.delegate = self
           
           // Adding a toolbar with a Done button
           let toolBar = UIToolbar()
           toolBar.sizeToFit()
           let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.dismissPicker))
           toolBar.setItems([doneButton], animated: true)
           cuisineTextField.inputAccessoryView = toolBar
       }
       
       @objc func dismissPicker() {
           cuisineTextField.resignFirstResponder()
       }

       // MARK: - UIPickerView DataSource and Delegate
       
       func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }
       
       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {           return pickerData.count
       }
       
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
       
       func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
           cuisineTextField.text = pickerData[row]
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
        if info[UIImagePickerController.InfoKey.editedImage] is UIImage {
        } else if info[UIImagePickerController.InfoKey.originalImage] is UIImage {
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func postRestaurantButton(_ sender: Any) {
    }
    
}
