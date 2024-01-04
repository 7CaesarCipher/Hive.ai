//
//  WikipediaResource.swift
//  Hive.ai
//
//  Created by shashank Mishra on 03/01/24.
//

import Foundation
func getWikipediatDetail(completionHandler: @escaping (_ result: WikipediaResponse?) -> Void) {
    guard let loginURL = URL(string: URLConstants.GetData) else {
        print("Error in Getting Auth token URL")
        return
    }
    
    var urlRequest = URLRequest(url: loginURL)
    print(urlRequest, "my trade chaing api")
    urlRequest.httpMethod = APIRequestType.get.rawValue
    HttpUtility.shared.performDataTask(urlRequest: urlRequest, resultType: WikipediaResponse.self) { (result) in
        completionHandler(result)
        
    }
}
