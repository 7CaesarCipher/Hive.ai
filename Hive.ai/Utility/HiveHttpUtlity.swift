//
//  HiveHttpUtlity.swift
//  Hive.ai
//
//  Created by shashank Mishra on 03/01/24.
//

import Foundation
struct HttpUtility {
    static let shared = HttpUtility()
    private init() {}

    func performDataTask<T: Decodable>(urlRequest: URLRequest, resultType: T.Type, completionHandler:@escaping(_ result: T?) -> Void) {
        URLSession.shared.dataTask(with: urlRequest) { (responseData, _, error) in
            if(error == nil && responseData != nil && responseData?.count != 0) {
                let decoder = JSONDecoder()
                do {
                    let userData = try JSONSerialization.jsonObject(with: responseData!, options: .allowFragments) as?  [String: Any]
                    print(userData as Any)
                    let result = try decoder.decode(T.self, from: responseData!)
                    completionHandler(result)
                } catch let error {
                    debugPrint("error occured while decoding = \(error.localizedDescription)")
                }
            }
            
        }.resume()
    }
}
