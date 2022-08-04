//
//  Array+safeSubscript.swift
//  PokeChallenge
//
//  Created by Julio Brazil on 01/08/22.
//

import Foundation

extension Array {
    subscript (safe index: Int) -> Element? {
        guard index >= self.startIndex, index < self.endIndex else { return nil }
        return self[index]
    }
}
