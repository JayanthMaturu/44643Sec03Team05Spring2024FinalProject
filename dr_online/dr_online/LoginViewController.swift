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
        
        guard isValidEmail(email) else {
            showAlert(message: "Please enter a valid email address.")
            return
        }
        guard isValidPassword(password) else {
            showAlert(message: "Password must be at least 8 characters long.")
            return
        }
        func isValidEmail(_ email: String) -> Bool {
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            
            let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
            return emailPredicate.evaluate(with: email)
        }
        
        func isValidPassword(_ password: String) -> Bool {
            return password.count >= 8
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
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alertController.addAction(UIAlertAction(title: "Reset", style: .default, handler: { [weak self] _ in
                if let email = alertController.textFields?.first?.text, !email.isEmpty {
                    self?.showAlert(message: "Password reset link sent to \(email)")
                } else {
                    self?.showAlert(message: "Please enter your email.")
                }
            }))
            present(alertController, animated: true, completion: nil)
            
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
                backgroundImage.image = UIImage(named: "doctorimage")
                
                backgroundImage.contentMode = .scaleAspectFill
                view.insertSubview(backgroundImage, at: 0)
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

