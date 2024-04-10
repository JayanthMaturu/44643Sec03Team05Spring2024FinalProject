//
//  HomeScreenVC.swift
//  dr_online
//
//  Created by Jayanth on 3/19/24.
//

import UIKit
import FirebaseAuth

class HomeScreenVC: UIViewController {

    @IBAction func logoutBTN(_ sender: Any) {
        do {
                    try Auth.auth().signOut()
                    
                    // After signing out, navigate back to the login screen or perform other actions
                    navigateToLogin()
                    
                } catch let signOutError as NSError {
                    print("Error signing out: \(signOutError.localizedDescription)")
                }
    }
    func navigateToLogin() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil) // Replace "Main" with your actual storyboard name
            let loginVC = storyboard.instantiateViewController(withIdentifier: "login")
            
            // Present the login view controller modally
            self.present(loginVC, animated: true, completion: nil)
        }
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

}
