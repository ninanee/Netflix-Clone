//
//  Extensions.swift
//  Netflix Clone
//
//  Created by Yun Ni on 2024-06-11.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
