//
//  NameEntryViewController.swift
//  AllThingsHalal
//
//  Created by PettaMarukka on 4/6/2024.
//

import UIKit
import Firebase

class NameEntryViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        if let name = nameTextField.text, !name.isEmpty {
            let db = Firestore.firestore()
            let usersRef = db.collection("users")
            let userId = "some_unique_user_id"

            usersRef.document(userId).setData(["name": name]) { error in
                if let error = error {
                    print("Error setting document: \(error)")
                } else {
                    print("Document successfully written!")
                    self.performSegue(withIdentifier: "showProfileSegue", sender: self)
                }
            }
        }
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
