//
//  CreateAccountViewController.swift
//  loginformyapp
//
//  Created by Nayla Rosihan on 30/4/2024.
//

import UIKit
import FirebaseAuth

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var emailAddressTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBAction func registerButtonClicked(_ sender: UIButton) {
        
        guard let email = emailAddressTextField.text, !email.isEmpty else {
            print("Email address cannot be empty.")
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            print("Password cannot be empty.")
            return
        }
        
        
        Auth.auth().createUser(withEmail: email, password: password) { firebaseResult, error in
            if let e = error {
                print("error")
            }
            else {
                // go to home screen
                self.performSegue(withIdentifier: "goToHomeScreen", sender: self)
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


