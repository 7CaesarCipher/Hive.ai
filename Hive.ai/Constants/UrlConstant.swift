//
//  UrlConstant.swift
//  Hive.ai
//
//  Created by shashank Mishra on 03/01/24.
//

import Foundation
struct URLConstants {
    private struct Domains {
        static let BaseURL = "https://en.wikipedia.org/w/api.php"
        
    }
    private  struct Routes {
        static let InjecApi = "?format=json&action=query&generator=search&gsrnamespace=0&gsrsearch=apple"
       
    }
    private  static let MainUrl = Domains.BaseURL
    
    static var GetData: String {
        return MainUrl  + "&gsrlimit=10&prop=pageimages%7Cextracts&pilimit=max&exintro&explaintext&exsentences=1&exlimit=max"
    }
}
