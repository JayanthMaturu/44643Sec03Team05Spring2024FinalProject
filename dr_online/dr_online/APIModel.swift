//
//  APIModel.swift
//  dr_online
//
//  Created by VarunKumarReddyBhavanam on 3/8/24.
//

import Foundation
import Alamofire

struct doctor:Codable{
    var id: Int
    var doctors: String
    var Diseases: String
}
struct doctorDetails {
    var id: Int
    var doctorsName: String
}
struct DataManager {
    private(set) var doctors = [doctorDetails]()
    
    func loadMenu() async{
        
        let url =  "https://retoolapi.dev/x1twmd/data"
        let api = URL(string:url)
        
        
        let task = AF.request(api!, method: .get).serializingDecodable([doctor].self)
        let response = await task.response
        guard let jsonData = response.value else {return}
    }
    do {
        let response = try await AF.request(url).responseDecodable(of: [doctor].self)
        self.doctors = response.value?.map { doctorDetails(id: $0.id, doctorsName: $0.doctors) } ?? []
    } catch {
        print("Error loading doctors: \(error)")
    }

    
}
