
import UIKit
import FirebaseAuth

class HomeScreenVC: UIViewController {
    
    @IBAction func logoutBTN(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            
            // After signing out, navigate back to the login screen or perform other actions
            performSegue(withIdentifier: "tologin", sender: nil)
            
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError.localizedDescription)")
        }
    }
    
    
    @IBAction func deleteuser(_ sender: Any) {
        
        let user = Auth.auth().currentUser
        
        user?.delete { error in
            if let error = error {
                print("Error while trying to delete user - \(error.localizedDescription)")
                
            } else {
                print("Success! User deleted.")
                self.performSegue(withIdentifier: "tologin", sender: nil)
            }
        }
        
    }
    
    
    
}
