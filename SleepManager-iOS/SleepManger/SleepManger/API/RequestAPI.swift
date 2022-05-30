//
//  RequestAPI.swift
//  RoutineManger
//
//  Created by 문다 on 2022/05/30.
//

import Foundation

class RequestAPI: ObservableObject {
    static let shared = RequestAPI()
    
    private init() { }
//    @Published var histories = [History]()
//    
//    
//    func fetchData(){
//        
//        guard let url = URL(string: "") else{
//            return
//        }
//        let session = URLSession(configuration: .default)
//        
//        let task = session.dataTask(with: url) { data, response, error in
//            if let error = error{
//                print(error.localizedDescription)
//                return
//            }
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                self.histories = []
//                return
//            }
//            guard let data = data else{
//                return
//            }
//            do {
//                let apiResponse = try JSONDecoder().decode(Results.self, from: data)
//                DispatchQueue.main.async {
//                    self.histories = apiResponse.histories
//                }
//            } catch(let err){
//                print(err.localizedDescription)
//            }
//        }
//        task.resume()
//    }
}
