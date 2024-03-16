//
//  UIApplication.swift
//  SwiftfulCrypto
//
//  Created by Yaşar Duman on 16.03.2024.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
