
import Foundation

class DefaultHelper  {
   
   static  let shared =  DefaultHelper()
   
   func clearUserDefaults() {
       
       let defaults = UserDefaults.standard
       let dictionary = defaults.dictionaryRepresentation()

           dictionary.keys.forEach
           {
               key in   defaults.removeObject(forKey: key)
           }
   }
       
 
    
    func saveUID(uid: String) {
        UserDefaults.standard.setValue(uid, forKey: "uid")
    }
    
    
    func getUID()->String {
          return UserDefaults.standard.string(forKey: "uid") ?? ""
    }
    
    
   func getEmail()-> String {
       
       let email = UserDefaults.standard.string(forKey: "email") ?? ""
       
       print(email)
      return email
   }
   
   func getName()-> String {
      return UserDefaults.standard.string(forKey: "name") ?? ""
   }
    
  func getMobile()-> String? {
       return UserDefaults.standard.string(forKey: "mobile") ?? ""
  }
    
    func getAge()-> String? {
       return UserDefaults.standard.string(forKey: "age") ?? ""
  }
 
  
    func saveData(name:String, email:String,mobile:String,dob:String) {
       UserDefaults.standard.setValue(name, forKey: "name")
       UserDefaults.standard.setValue(email, forKey: "email")
       UserDefaults.standard.setValue(mobile, forKey: "mobile")
       UserDefaults.standard.setValue(dob, forKey: "age")
   }
 
   
   func clearData(){
       UserDefaults.standard.removeObject(forKey: "email")
       UserDefaults.standard.removeObject(forKey: "name")
   }
  
}
