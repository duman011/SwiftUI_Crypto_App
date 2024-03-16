//
//  String.swift
//  SwiftfulCrypto
//
//  Created by Yaşar Duman on 16.03.2024.
//

import Foundation

extension String {
    
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}
