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
    var Doctors: String
    var Diseases: String
}
struct doctorDeets {
    //var doctor: item
}
struct DataManager {
    private(set) var doctors = [doctorDeets]()
    func loadMenu() async{
    // https://retoolapi.dev/uYiI4p/data
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "retoolapi.dev"
        urlComponents.path = "uYiI4p/data"
        
        let task = AF.request(urlComponents.url!, method: .get).serializingDecodable([doctor].self)
        let response = await task.response
        guard let jsonData = response.value else {return}
        
    }
}

