//
//  StringExtensions.swift
//  SDKIntegration
//
//  Created by Joost van Dijk on 09/08/2022.
//

import Foundation

extension String {
    
    static func random(withLength length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
}
