//
//  WikipediaResource.swift
//  Hive.ai
//
//  Created by shashank Mishra on 03/01/24.
//

import Foundation
func getWikipediatDetail(completionHandler: @escaping (_ result: WikipediaResponse?) -> Void) {
    guard let loginURL = URL(string: "https://en.wikipedia.org/w/api.php?format=json&action=query&generator=search&gsrnamespace=0&gsrsearch=apple&gsrlimit=10&prop=pageimages%7Cextracts&pilimit=max&exintro&explaintext&exsentences=1&exlimit=max") else {
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
