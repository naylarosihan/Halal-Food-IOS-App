//
//  ProfileViewController.swift
//  AllThingsHalal
//
//  Created by PettaMarukka on 4/6/2024.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var bioDisplayTextView: UITextView!
    
    @IBOutlet weak var cityDisplayLabel: UILabel!
    
    @IBOutlet weak var nationalityDisplayLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
       
    override func viewDidLoad() {
            super.viewDidLoad()
            updateProfile()
        }

    func updateProfile() {
        
        /*
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<UserProfile> = UserProfile.fetchRequest()
        
        do {
            let results = try context.fetch(request)
            if let userProfile = results.first {
                cityDisplayLabel.text = userProfile.city
                nationalityDisplayLabel.text = userProfile.nationality
                bioDisplayTextView.text = userProfile.bio
            }
        } catch {
            print("Failed to fetch user profile: \(error)")
        }
        
        */
        
        guard let userId = Auth.auth().currentUser?.uid else {
            nameLabel.text = "No user ID found"
            return
        }
        
        // Assuming UserService is a class you've defined to handle Firebase interactions
        UserService.fetchUserName(userId: userId) { name in
            DispatchQueue.main.async {
                self.nameLabel.text = name ?? "Name not available"
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateProfile()
    }


    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            
            // Assuming the login screen is the root view controller of the navigation stack
            // This will pop to the root view controller, typically your login screen
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
            // Optionally handle the error e.g., show an alert to the user
        }
    }

    
    @IBAction func editProfileTapped(_ sender: Any) {
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

class UserService {

    static func saveUserName(userId: String, name: String) {
        let db = Firestore.firestore()
        db.collection("users").document(userId).setData(["name": name]) { error in
            if let error = error {
                print("Error saving user name: \(error)")
            } else {
                print("User name saved successfully")
            }
        }
    }

    static func fetchUserName(userId: String, completion: @escaping (String?) -> Void) {
        let db = Firestore.firestore()
        db.collection("users").document(userId).getDocument { document, error in
            if let error = error {
                print("Error fetching user name: \(error)")
                completion(nil)
            } else if let document = document, document.exists {
                let name = document.data()?["name"] as? String
                completion(name)
            } else {
                completion(nil)
            }
        }
    }
}
