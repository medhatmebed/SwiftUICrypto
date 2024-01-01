//
//  UIApplication.swift
//  SwiftUICrypto
//
//  Created by Medhat Mebed on 1/1/24.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
