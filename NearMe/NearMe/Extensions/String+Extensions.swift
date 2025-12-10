//
//  String+Extensions.swift
//  NearMe
//
//  Created by Mohammad Azam on 11/2/22.
//

import Foundation

extension String {
    
    var formatPhoneForCall: String {
        self.replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "+", with: "")
            .replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
            .replacingOccurrences(of: "-", with: "")
    }
    
}
