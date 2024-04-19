//  APIModel.swift
//  dr_online
//
//  Created by VarunKumarReddyBhavanam on 3/8/24.

import Foundation
import Alamofire

struct Doctor: Codable {
    var id: Int?
    var Doctors: String?
    var Diseases: String?
}

struct DataManager {
    
    func loadDoctors(completion: @escaping ([Doctor]?) -> Void) {
        let url = "https://retoolapi.dev/x1twmd/data"
        AF.request(url, method: .get).responseDecodable(of: [Doctor].self) { response in
            guard let doctors = response.value else {
                completion(nil)
                return
            }
  
            print(doctors)
            completion(doctors)
        }
    }
}
