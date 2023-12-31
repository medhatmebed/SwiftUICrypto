//
//  Double.swift
//  SwiftUICrypto
//
//  Created by Medhat Mebed on 12/31/23.
//

import Foundation

extension Double {
    /// Convert Double into currency with 2decimale places
    /// ```
    /// Convert 1234.56 to $1234.56
    /// ```
    private var currencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = .current
        formatter.currencyCode = "usd"
        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    /// Convert Double into currency as String with 2-6 decimale places
    /// ```
    /// Convert 1234.56 to "$1234.56"
    /// ```
    func asCurrencyWith2Decimals() -> String {
        
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "$0.00"
    }
    /// Convert Double into currency with 2-6 decimale places
    /// ```
    /// Convert 1234.56 to $1234.56
    /// Convert 12.3456 to $12.3456
    /// Convert 0.123456 to $0.123456
    /// ```
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = .current
        formatter.currencyCode = "usd"
        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    /// Convert Double into currency as String with 2-6 decimale places
    /// ```
    /// Convert 1234.56 to "$1234.56"
    /// Convert 12.3456 to "$12.3456"
    /// Convert 0.123456 to "$0.123456"
    /// ```
    func asCurrencyWith6Decimals() -> String {
        
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "$0.00"
    }
    
    /// Convert Double into String representation
    /// ```
    /// Convert 2.1623456 to "2.16"
    /// ```
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    /// Convert Double into String representation with percent symbol
    /// ```
    /// Convert 2.16 to "2.16%"
    /// ```
    func asPercentString() -> String {
        return asNumberString() + "%"
    }
    
}
