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
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
        }
        
        func showAlert(message: String) {
            let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }

