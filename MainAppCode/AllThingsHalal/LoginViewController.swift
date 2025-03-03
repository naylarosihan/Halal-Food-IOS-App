//
//  LoginViewController.swift
//  loginformyapp
//
//  Created by Nayla Rosihan on 30/4/2024.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private var loginAttempted = false

    
    @IBAction func loginButtonClicked(_ sender: UIButton) {
        
        guard let email = emailAddressTextField.text else { return }
        guard let password = passwordTextField.text else { return }
                
        loginAttempted = true  // Set loginAttempted to true as the user attempts to login

                
        Auth.auth().signIn(withEmail: email, password: password) { firebaseResult, error in
            if let e = error {
                print("error")
            }
            else {
                // go to home screen
                self.performSegue(withIdentifier: "goToHomeScreen", sender: self)
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Check if the user is already signed in
        Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            if let user = user, self?.loginAttempted == false {
                // Automatically navigate to the home screen if a user is already logged in
                // and no login attempt was made (i.e., on app launch)
                self?.performSegue(withIdentifier: "goToHomeScreen", sender: nil)
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
