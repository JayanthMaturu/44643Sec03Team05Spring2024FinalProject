//
//  SignUpViewController.swift
//  dr_online
//
//  Created by Jayanth on 3/5/24.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var genderSC: UISegmentedControl!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmpasswordTF: UITextField!
    @IBAction func signupBTN(_ sender: UIButton) {
        guard let name = nameTF.text , !name.isEmpty  else {
            nameTF.text = ""
            nameTF.placeholder = "Name should not be empty"
            return
        }
        guard let text = ageTF.text , !text.isEmpty , let age = Int(text) ,age>0 else {
            ageTF.text = ""
            ageTF.placeholder = "Age should be an integer greater than zero"
            return
        }
        guard let text = phoneTF.text , !text.isEmpty , text.count == 10, let phone = Int(text)  else {
            phoneTF.text = ""
            phoneTF.placeholder = "phone number should has 10 digits"
            return
        }
        guard let email = emailTF.text , !email.isEmpty ,isValidGmailAddress(email: email) else {
            emailTF.text = ""
            emailTF.placeholder = "Enter a valid email address"
            return
        }
        
        guard let password = passwordTF.text , !password.isEmpty , isValidPassword(password) else {
            let message = """
                Password should contain:
                - Minimum 8 characters
                - At least one uppercase letter
                - At least one lowercase letter
                - At least one number
                - At least one special character
                """
            alert(message: message)
            passwordTF.text = ""
            return
        }
        
        guard let cpass = confirmpasswordTF.text , !cpass.isEmpty , cpass == password, isValidPassword(password) else {
            confirmpasswordTF.text = ""
            confirmpasswordTF.placeholder = "Password should match."
            return
        }
        
        let isUserCreated = self.signUpUser(email: email, password: password, name: name, age: age, gender: genderSC.selectedSegmentIndex == 0 ? "Male" : "Female", phoneNumber: phone)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    private func signUpUser(email: String, password: String, name: String, age: Int, gender: String, phoneNumber: Int) -> Bool {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            guard let user = authResult?.user, error == nil else {
                print("Error \(error!.localizedDescription)")
                return
            }
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = name
            changeRequest.commitChanges { error in
                if let error = error {
                    print("Error updating user profile: \(error.localizedDescription)")
                    return
                }
                let db = Firestore.firestore()
                let userRef = db.collection("users").document(user.uid)
                userRef.setData([
                    "name": name,
                    "age": age,
                    "gender": gender,
                    "phoneNumber": phoneNumber
                ]) { error in
                    if let error = error {
                        print("Error saving user data: \(error.localizedDescription)")
                    } else {
                        print("User created successfully with display name: \(name)")
                    }
                }
                print("User signed up: \(user.email ?? "")")
            }
        }
        return true
    }
        func isValidGmailAddress(email: String) -> Bool {
            let pattern = "^[A-Z0-9._%+-]+@gmail\\.com$"
            let regex = try! NSRegularExpression(pattern: pattern, options: [.caseInsensitive])
            return regex.firstMatch(in: email, options: [], range: NSRange(location: 0, length: email.utf16.count)) != nil
        }
        
        func isValidPassword(_ password: String) -> Bool {
            let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[#$%&'()*+,-./:;<=>?@\\[\\]^_`{|}~])[A-Za-z\\d#$%&'()*+,-./:;<=>?@\\[\\]^_`{|}~]{8,}$"
            
            let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
            return passwordTest.evaluate(with: password)
        }
    private func alert(message : String){
        let alert = UIAlertController(title: "Password", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default){ (action) in
        })
        present(alert, animated: true, completion: nil)
    }
    
}
