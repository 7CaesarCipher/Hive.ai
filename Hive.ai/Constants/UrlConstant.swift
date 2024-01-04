//
//  UrlConstant.swift
//  Hive.ai
//
//  Created by shashank Mishra on 03/01/24.
//

import Foundation
struct URLConstants {
    private struct Domains {
        static let wikiURL = "https://en.wikipedia.org/w/api.php"
        
    }
    private  static let Domain = Domains.wikiURL
    private  static let InjecApiRoute = "?format=json&action=query&generator=search&gsrnamespace=0&gsrsearch=apple"
    
    
    private  static let BaseURL = Domain + InjecApiRoute
 
    
    static var GetData: String {
        return BaseURL  + "&gsrlimit=10&prop=pageimages%7Cextracts&pilimit=max&exintro&explaintext&exsentences=1&exlimit=max"
    }
}
