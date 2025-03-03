//
//  EditProfileViewController.swift
//  AllThingsHalal
//
//  Created by PettaMarukka on 8/6/2024.
//


import UIKit
// import CoreData

class EditProfileViewController: UIViewController {
    
    
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var nationalityTextField: UITextField!
    
    
    
    @IBOutlet weak var editableBioTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func saveChangesTapped(_ sender: Any) {
        /*
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let userProfile = UserProfile(context: context)
        userProfile.city = cityTextField.text
        userProfile.nationality = nationalityTextField.text
        userProfile.bio = editableBioTextView.text
        
        do {
            try context.save()
            print("Changes saved successfully.")
            self.dismiss(animated: true, completion: nil)
        } catch {
            print("Failed to save user profile: \(error)")
        }
        */
    }
    

        
    
}
