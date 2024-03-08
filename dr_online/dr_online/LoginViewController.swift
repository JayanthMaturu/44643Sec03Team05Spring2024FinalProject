//
//  ViewController.swift
//  dr_online
//
//  Created by Jayanth on 2/19/24.
//

import UIKit
import Lottie

class LoginViewController: UIViewController {
    
    @IBOutlet weak var LaunchLAV: LottieAnimationView!{
        didSet{
            LaunchLAV.animation = LottieAnimation.named("Animation_app")
            LaunchLAV.alpha = 1
            LaunchLAV.play{ [weak self] _ in
                UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 1.0, delay: 0.0, options: [.curveEaseInOut]){
                    self?.LaunchLAV.alpha = 0.0
                }
            }
        }
    }
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var login: UIButton!
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        self.emailTF.text = ""
        self.passwordTF.text = ""
        
        
    }
    
    
    @IBAction func loginBTN(_ sender: Any) {
        let email = emailTF.text ?? ""
        let password = passwordTF.text ?? ""
        guard !email.isEmpty && !password.isEmpty else {
            showAlert(message: "Please enter both email and password.")
            return
            
        }
    }
    
    @IBAction func signUpBTN(_ sender: UIButton) {
        let signupVC =  self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        self.navigationController?.pushViewController(signupVC, animated: true);
    }
    
    @IBAction func forgetBTN(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Forgot Password", message: "Enter your email to reset your password", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Email"
            textField.keyboardType = .emailAddress
        }
        
        // Add "Cancel" and "Reset" buttons
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Reset", style: .default, handler: { [weak self] _ in
            // Perform password reset logic here
            if let email = alertController.textFields?.first?.text, !email.isEmpty {
                // Show confirmation that password reset link has been sent
                self?.showAlert(message: "Password reset link sent to \(email)")
            } else {
                // Show alert if email field is empty
                self?.showAlert(message: "Please enter your email.")
            }
        }))
        
        // Present the alert
        present(alertController, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
        extension UIViewController {
        func showAlert(message: String) {
            let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }

//extension UIViewController {
//    func showAlert(message: String) {
//        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//        alert.addAction(okAction)
//        present(alert, animated: true, completion: nil)
//    }
//}

