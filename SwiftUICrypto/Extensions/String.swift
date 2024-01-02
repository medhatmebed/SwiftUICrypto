//
//  String.swift
//  SwiftfulCrypto
//
//  Created by Medhat Mebed on 1/2/24.
//

import Foundation

extension String {
    
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}
